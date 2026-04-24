-- ============================================================
-- City of Toronto — MLS Inspection Risk Scoring Model
-- Author: Albert Ibe, PMP | CBAP
-- Engagement: ECG x City of Toronto, 2024
-- Description: Property risk scoring for inspection
--              prioritization — replaces FIFO scheduling
-- ============================================================

-- ============================================================
-- QUERY 1: Property Risk Score Calculation
-- Purpose: Calculate a 0-100 risk score for each licensed
--          property to drive risk-based inspection scheduling
-- ============================================================

WITH violation_history AS (
    SELECT
        property_id,
        COUNT(*)                                                  AS total_violations_3yr,
        SUM(CASE WHEN violation_severity = 'CRITICAL'
                 THEN 1 ELSE 0 END)                              AS critical_violations,
        SUM(CASE WHEN violation_severity = 'MAJOR'
                 THEN 1 ELSE 0 END)                              AS major_violations,
        MAX(violation_date)                                       AS last_violation_date,
        SUM(CASE WHEN is_repeat_violation = 1
                 THEN 1 ELSE 0 END)                              AS repeat_violations
    FROM mls.violations
    WHERE violation_date >= DATEADD(year, -3, GETDATE())
    GROUP BY property_id
),

inspection_history AS (
    SELECT
        property_id,
        MAX(inspection_date)                                      AS last_inspection_date,
        DATEDIFF(day, MAX(inspection_date), GETDATE())           AS days_since_inspection,
        COUNT(*)                                                  AS total_inspections_3yr,
        AVG(CAST(inspection_score AS FLOAT))                     AS avg_inspection_score
    FROM mls.inspections
    WHERE inspection_date >= DATEADD(year, -3, GETDATE())
    GROUP BY property_id
),

complaint_history AS (
    SELECT
        property_id,
        COUNT(*)                                                  AS total_complaints_12mo,
        SUM(CASE WHEN complaint_category = 'SAFETY'
                 THEN 1 ELSE 0 END)                              AS safety_complaints,
        MAX(complaint_date)                                       AS last_complaint_date
    FROM mls.complaints
    WHERE complaint_date >= DATEADD(month, -12, GETDATE())
    GROUP BY property_id
),

geographic_risk AS (
    -- Area-level risk based on cluster of violations in geographic zone
    SELECT
        p.postal_code_zone,
        COUNT(v.violation_id)                                     AS zone_violations_12mo,
        ROUND(
            100.0 * COUNT(v.violation_id) /
            COUNT(DISTINCT p.property_id), 1)                    AS zone_violation_rate
    FROM mls.properties p
    LEFT JOIN mls.violations v
        ON p.property_id = v.property_id
        AND v.violation_date >= DATEADD(month, -12, GETDATE())
    GROUP BY p.postal_code_zone
)

SELECT
    p.property_id,
    p.property_address,
    p.property_type,
    p.license_category,
    p.owner_name,
    p.postal_code_zone,

    -- Component scores (each 0-100, then weighted)
    -- Weight: Violation History 35%, Property Type 25%,
    --         Recency 20%, Complaints 15%, Geography 5%

    -- 1. Violation History Score (0-100)
    LEAST(100, ROUND(
        ISNULL(vh.total_violations_3yr, 0) * 10
        + ISNULL(vh.critical_violations, 0) * 20
        + ISNULL(vh.major_violations, 0) * 10
        + ISNULL(vh.repeat_violations, 0) * 15
    , 0))                                                         AS violation_score,

    -- 2. Property Type Risk (0-100) — based on type risk table
    pt.type_base_risk_score                                       AS property_type_score,

    -- 3. Recency Score (0-100) — higher = longer since inspection
    CASE
        WHEN ISNULL(ih.days_since_inspection, 999) > 365 THEN 100
        WHEN ih.days_since_inspection > 180                THEN 75
        WHEN ih.days_since_inspection > 90                 THEN 50
        WHEN ih.days_since_inspection > 45                 THEN 25
        ELSE 10
    END                                                           AS recency_score,

    -- 4. Complaint Score (0-100)
    LEAST(100, ROUND(
        ISNULL(ch.total_complaints_12mo, 0) * 15
        + ISNULL(ch.safety_complaints, 0) * 25
    , 0))                                                         AS complaint_score,

    -- 5. Geographic Cluster Risk (0-100)
    LEAST(100, ROUND(
        ISNULL(gr.zone_violation_rate, 0) * 5
    , 0))                                                         AS geographic_score,

    -- COMPOSITE RISK SCORE (0-100, weighted)
    ROUND(
        (LEAST(100, ISNULL(vh.total_violations_3yr, 0) * 10
               + ISNULL(vh.critical_violations, 0) * 20
               + ISNULL(vh.repeat_violations, 0) * 15)   * 0.35)  -- Violation weight
        + (pt.type_base_risk_score                         * 0.25)  -- Property type weight
        + (CASE
               WHEN ISNULL(ih.days_since_inspection,999)>365 THEN 100
               WHEN ih.days_since_inspection > 180 THEN 75
               WHEN ih.days_since_inspection > 90  THEN 50
               WHEN ih.days_since_inspection > 45  THEN 25
               ELSE 10
           END                                             * 0.20)  -- Recency weight
        + (LEAST(100, ISNULL(ch.total_complaints_12mo,0)*15
               + ISNULL(ch.safety_complaints,0)*25)        * 0.15)  -- Complaint weight
        + (LEAST(100,ISNULL(gr.zone_violation_rate,0)*5)   * 0.05)  -- Geography weight
    , 0)                                                          AS composite_risk_score,

    -- RISK TIER — drives inspection scheduling SLA
    CASE
        WHEN ROUND(composite_risk_score, 0) >= 75 THEN 'Critical — Inspect within 5 days'
        WHEN ROUND(composite_risk_score, 0) >= 50 THEN 'High — Inspect within 15 days'
        WHEN ROUND(composite_risk_score, 0) >= 25 THEN 'Medium — Inspect within 45 days'
        ELSE 'Low — Inspect within 90 days'
    END                                                           AS risk_tier,

    ih.last_inspection_date,
    ih.days_since_inspection,
    vh.last_violation_date,
    vh.total_violations_3yr,
    ch.total_complaints_12mo

FROM mls.properties p
LEFT JOIN violation_history vh        ON p.property_id = vh.property_id
LEFT JOIN inspection_history ih       ON p.property_id = ih.property_id
LEFT JOIN complaint_history ch        ON p.property_id = ch.property_id
LEFT JOIN mls.property_type_risk pt   ON p.property_type = pt.property_type
LEFT JOIN geographic_risk gr          ON p.postal_code_zone = gr.postal_code_zone
WHERE p.license_status = 'ACTIVE'
ORDER BY composite_risk_score DESC;


-- ============================================================
-- QUERY 2: Inspection Coverage Rate by Risk Tier
-- Purpose: Track weekly progress toward ≥80% high-risk
--          inspection coverage target
-- ============================================================

WITH risk_scored_properties AS (
    -- Reference the risk score CTE above (abbreviated here)
    SELECT
        property_id,
        composite_risk_score,
        CASE
            WHEN composite_risk_score >= 75 THEN 'Critical'
            WHEN composite_risk_score >= 50 THEN 'High'
            WHEN composite_risk_score >= 25 THEN 'Medium'
            ELSE 'Low'
        END AS risk_tier
    FROM mls.properties p
    -- [Join conditions as above]
),

inspection_coverage AS (
    SELECT
        rsp.risk_tier,
        COUNT(DISTINCT rsp.property_id)                           AS total_properties,
        COUNT(DISTINCT i.property_id)                            AS inspected_count,
        ROUND(
            100.0 * COUNT(DISTINCT i.property_id) /
            NULLIF(COUNT(DISTINCT rsp.property_id), 0), 1)       AS coverage_pct
    FROM risk_scored_properties rsp
    LEFT JOIN mls.inspections i
        ON rsp.property_id = i.property_id
        AND i.inspection_date >= DATEADD(day,
            CASE rsp.risk_tier
                WHEN 'Critical' THEN -5
                WHEN 'High'     THEN -15
                WHEN 'Medium'   THEN -45
                ELSE -90
            END, GETDATE())
    GROUP BY rsp.risk_tier
)

SELECT
    risk_tier,
    total_properties,
    inspected_count,
    total_properties - inspected_count                            AS uninspected_count,
    coverage_pct,
    CASE
        WHEN risk_tier IN ('Critical', 'High')
             AND coverage_pct >= 80 THEN '✅ On Target'
        WHEN risk_tier IN ('Critical', 'High')
             AND coverage_pct >= 70 THEN '⚠️ At Risk'
        WHEN risk_tier IN ('Critical', 'High')
             AND coverage_pct < 70  THEN '🔴 Off Target'
        ELSE '—'
    END                                                           AS target_status
FROM inspection_coverage
ORDER BY
    CASE risk_tier
        WHEN 'Critical' THEN 1
        WHEN 'High'     THEN 2
        WHEN 'Medium'   THEN 3
        WHEN 'Low'      THEN 4
    END;
