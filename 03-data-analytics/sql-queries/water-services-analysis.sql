-- ============================================================
-- City of Toronto — Water Services Maintenance Analytics
-- Author: Albert Ibe, PMP | CBAP
-- Engagement: ECG x City of Toronto, 2024
-- Description: Work order performance and backlog analysis
--              for Power BI dashboard data model
-- ============================================================

-- ============================================================
-- QUERY 1: Work Order Cycle Time Analysis
-- Purpose: Calculate average, median, and distribution of
--          work order cycle time by category and priority
-- ============================================================

WITH work_order_metrics AS (
    SELECT
        wo.work_order_id,
        wo.asset_id,
        wo.work_order_type,                          -- Planned / Reactive / Emergency
        wo.priority_code,
        wo.division_code,
        wo.created_date,
        wo.assigned_date,
        wo.scheduled_date,
        wo.completed_date,
        a.asset_class,
        a.asset_age_years,
        a.criticality_rating,                        -- 1=Low, 2=Medium, 3=High, 4=Critical
        a.district_name,

        -- Core cycle time calculations (in business days)
        DATEDIFF(day, wo.created_date, wo.assigned_date)     AS days_to_assign,
        DATEDIFF(day, wo.assigned_date, wo.scheduled_date)   AS days_to_schedule,
        DATEDIFF(day, wo.scheduled_date, wo.completed_date)  AS days_to_complete,
        DATEDIFF(day, wo.created_date, wo.completed_date)    AS total_cycle_days,

        -- Flag work orders exceeding target thresholds
        CASE
            WHEN DATEDIFF(day, wo.created_date, wo.completed_date) > 5  THEN 'Exceeds Target'
            WHEN DATEDIFF(day, wo.created_date, wo.completed_date) <= 5 THEN 'Within Target'
        END AS cycle_time_status,

        -- Classify work order age bucket
        CASE
            WHEN DATEDIFF(day, wo.created_date, wo.completed_date) <= 1   THEN '0-1 Days'
            WHEN DATEDIFF(day, wo.created_date, wo.completed_date) <= 5   THEN '2-5 Days'
            WHEN DATEDIFF(day, wo.created_date, wo.completed_date) <= 14  THEN '6-14 Days'
            WHEN DATEDIFF(day, wo.created_date, wo.completed_date) <= 30  THEN '15-30 Days'
            ELSE '30+ Days'
        END AS cycle_time_bucket

    FROM maximo.work_orders wo
    INNER JOIN maximo.assets a
        ON wo.asset_id = a.asset_id
    WHERE
        wo.completed_date IS NOT NULL
        AND wo.created_date >= DATEADD(month, -24, GETDATE())   -- Last 24 months
        AND wo.division_code = 'WATER'
        AND wo.status_code NOT IN ('CANCELLED', 'DUPLICATE')
),

cycle_time_summary AS (
    SELECT
        work_order_type,
        asset_class,
        criticality_rating,
        district_name,
        COUNT(work_order_id)                                     AS total_work_orders,
        ROUND(AVG(CAST(total_cycle_days AS FLOAT)), 1)           AS avg_cycle_days,
        PERCENTILE_CONT(0.5) WITHIN GROUP
            (ORDER BY total_cycle_days) OVER
            (PARTITION BY work_order_type, asset_class)          AS median_cycle_days,
        MIN(total_cycle_days)                                    AS min_cycle_days,
        MAX(total_cycle_days)                                    AS max_cycle_days,
        SUM(CASE WHEN cycle_time_status = 'Within Target'
                 THEN 1 ELSE 0 END)                             AS within_target_count,
        ROUND(
            100.0 * SUM(CASE WHEN cycle_time_status = 'Within Target'
                             THEN 1 ELSE 0 END) / COUNT(*), 1)  AS pct_within_target
    FROM work_order_metrics
    GROUP BY
        work_order_type,
        asset_class,
        criticality_rating,
        district_name
)

SELECT
    work_order_type,
    asset_class,
    CASE criticality_rating
        WHEN 1 THEN 'Low'
        WHEN 2 THEN 'Medium'
        WHEN 3 THEN 'High'
        WHEN 4 THEN 'Critical'
    END                                                          AS criticality_level,
    district_name,
    total_work_orders,
    avg_cycle_days,
    median_cycle_days,
    min_cycle_days,
    max_cycle_days,
    within_target_count,
    pct_within_target,
    ROUND(100 - pct_within_target, 1)                           AS pct_exceeds_target
FROM cycle_time_summary
ORDER BY
    criticality_rating DESC,
    avg_cycle_days DESC;


-- ============================================================
-- QUERY 2: Open Work Order Backlog Analysis
-- Purpose: Identify and prioritize overdue open work orders
--          for operational triage dashboard
-- ============================================================

SELECT
    wo.work_order_id,
    wo.work_order_description,
    wo.priority_code,
    a.asset_id,
    a.asset_description,
    a.asset_class,
    a.criticality_rating,
    a.district_name,
    a.last_inspection_date,
    wo.created_date,
    DATEDIFF(day, wo.created_date, GETDATE())                    AS days_open,

    -- Risk-based priority score (0-100) for scheduling queue
    -- Higher score = higher priority
    ROUND(
        (a.criticality_rating * 25)                              -- Asset criticality weight (max 100)
        + CASE
            WHEN DATEDIFF(day, wo.created_date, GETDATE()) > 30 THEN 25
            WHEN DATEDIFF(day, wo.created_date, GETDATE()) > 14 THEN 15
            WHEN DATEDIFF(day, wo.created_date, GETDATE()) > 7  THEN 8
            ELSE 3
          END                                                     -- Age weight (max 25)
        + CASE wo.priority_code
            WHEN 'EMERGENCY' THEN 25
            WHEN 'URGENT'    THEN 18
            WHEN 'ROUTINE'   THEN 8
            ELSE 3
          END                                                     -- Priority code weight (max 25)
        + ISNULL(s.scada_deviation_score, 0) * 0.25             -- SCADA deviation weight (max 25)
    , 0)                                                         AS priority_score,

    wo.assigned_crew_id,
    wo.assigned_supervisor,
    wo.estimated_hours,
    wo.parts_ordered_flag,
    wo.parts_received_flag,

    -- Identify bottleneck stage
    CASE
        WHEN wo.assigned_crew_id IS NULL            THEN 'Awaiting Assignment'
        WHEN wo.parts_ordered_flag = 0              THEN 'Awaiting Parts Order'
        WHEN wo.parts_received_flag = 0             THEN 'Awaiting Parts Delivery'
        WHEN wo.supervisor_approved_flag = 0        THEN 'Awaiting Supervisor Approval'
        WHEN wo.scheduled_date IS NULL              THEN 'Awaiting Scheduling'
        ELSE 'In Progress'
    END                                                          AS bottleneck_stage

FROM maximo.work_orders wo
INNER JOIN maximo.assets a
    ON wo.asset_id = a.asset_id
LEFT JOIN scada.asset_performance s
    ON a.asset_id = s.asset_id
    AND s.reading_date = CAST(GETDATE() AS DATE)
WHERE
    wo.status_code = 'OPEN'
    AND wo.division_code = 'WATER'
    AND DATEDIFF(day, wo.created_date, GETDATE()) > 5           -- Open more than 5 days
ORDER BY
    priority_score DESC,
    days_open DESC;


-- ============================================================
-- QUERY 3: Reactive vs. Planned Maintenance Trend
-- Purpose: Track progress toward 40% reactive / 60% planned
--          target ratio over time
-- ============================================================

SELECT
    FORMAT(wo.completed_date, 'yyyy-MM')                         AS period_month,
    COUNT(*)                                                     AS total_work_orders,
    SUM(CASE WHEN wo.work_order_type = 'REACTIVE'  THEN 1 ELSE 0 END) AS reactive_count,
    SUM(CASE WHEN wo.work_order_type = 'PLANNED'   THEN 1 ELSE 0 END) AS planned_count,
    SUM(CASE WHEN wo.work_order_type = 'EMERGENCY' THEN 1 ELSE 0 END) AS emergency_count,
    ROUND(
        100.0 * SUM(CASE WHEN wo.work_order_type = 'REACTIVE'
                         THEN 1 ELSE 0 END) / COUNT(*), 1)      AS pct_reactive,
    ROUND(
        100.0 * SUM(CASE WHEN wo.work_order_type = 'PLANNED'
                         THEN 1 ELSE 0 END) / COUNT(*), 1)      AS pct_planned,

    -- Target flag: is this month within the 40% reactive target?
    CASE
        WHEN (100.0 * SUM(CASE WHEN wo.work_order_type = 'REACTIVE'
                               THEN 1 ELSE 0 END) / COUNT(*)) <= 40
        THEN 'On Target'
        ELSE 'Exceeds Target'
    END                                                          AS reactive_target_status,

    -- Month-over-month reactive % change
    ROUND(
        (100.0 * SUM(CASE WHEN wo.work_order_type = 'REACTIVE'
                          THEN 1 ELSE 0 END) / COUNT(*))
        - LAG(100.0 * SUM(CASE WHEN wo.work_order_type = 'REACTIVE'
                               THEN 1 ELSE 0 END) / COUNT(*))
          OVER (ORDER BY FORMAT(wo.completed_date, 'yyyy-MM'))
    , 1)                                                         AS mom_reactive_pct_change

FROM maximo.work_orders wo
WHERE
    wo.completed_date IS NOT NULL
    AND wo.division_code = 'WATER'
    AND wo.status_code NOT IN ('CANCELLED', 'DUPLICATE')
    AND wo.completed_date >= DATEADD(month, -24, GETDATE())
GROUP BY
    FORMAT(wo.completed_date, 'yyyy-MM')
ORDER BY
    period_month ASC;
