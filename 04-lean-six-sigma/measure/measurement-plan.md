# DMAIC — MEASURE Phase
## Data Collection Plan & Baseline Metrics

**LSS Lead:** Albert Ibe, PMP | CBAP  
**Phase Duration:** February – March 2024  
**Phase Status:** ✅ Complete

---

## Measure Phase Objectives

1. Establish a quantitative baseline for all CTQ measures identified in Define
2. Validate the measurement system — confirm data is reliable and consistent
3. Identify data sources, gaps, and quality issues before analysis begins
4. Calculate baseline process capability (Sigma level) for key processes

---

## Data Collection Plan

| CTQ Measure | Data Source | Collection Method | Sample Size | Collection Period | Data Owner | Frequency |
|---|---|---|---|---|---|---|
| Work order cycle time (days) | MAXIMO Work Order System | SQL extract | All WOs — last 24 months | Feb 1–28, 2024 | Water Services IT | One-time extract |
| Work order backlog count | MAXIMO | SQL extract | All open WOs | Feb 1–28, 2024 | Water Services IT | Weekly |
| Asset failure rate (% reactive vs. planned) | MAXIMO + SCADA | SQL join | All maintenance events — 24 months | Feb 1–28, 2024 | Water Services IT | One-time extract |
| Inspection scheduling lead time (days) | MLS Case Management System | SQL extract | All inspections — 24 months | Feb 1–28, 2024 | MLS IT | One-time extract |
| High-risk inspection coverage (%) | MLS + Property Database | SQL join | All high-risk properties | Feb 1–28, 2024 | MLS IT | Monthly |
| Repeat violation rate (%) | MLS Case Management | SQL extract | All closed cases — 24 months | Feb 1–28, 2024 | MLS IT | One-time extract |
| Manual HR reporting hours | Time study (staff self-report) | Time diary + observation | People & Equity team (n=4) | 4 weeks | People & Equity | Weekly diary |
| Data error rate — HR records | HRIS (SAP HCM) | Data quality audit | Random sample n=500 records | Feb 2024 | HR IT | One-time |
| Workforce data lag (days) | HRIS extract timestamps | System log review | 12 months of extract logs | Feb 2024 | HR IT | One-time |

---

## Measurement System Analysis (MSA)

Before relying on any data source, each was evaluated for:

| Criterion | Assessment Method | Acceptable Threshold |
|---|---|---|
| **Accuracy** | Compare system data to source documents (n=50 per source) | <5% discrepancy |
| **Completeness** | Count NULL / missing values in critical fields | <3% null rate |
| **Consistency** | Compare same metric across two reporting periods | <2% variance unexplained by business activity |
| **Timeliness** | Calculate lag between event occurrence and system recording | <48 hours for operational data |

### MSA Results Summary

| Data Source | Accuracy | Completeness | Consistency | Timeliness | Overall |
|---|---|---|---|---|---|
| MAXIMO Work Orders | ✅ 98.2% | ✅ 96.1% | ✅ 97.4% | ⚠️ 3.2 day avg lag | **Usable with lag caveat** |
| SCADA Monitoring | ✅ 99.7% | ✅ 99.1% | ✅ 99.3% | ✅ <1 hour | **Reliable** |
| MLS Case Management | ✅ 96.8% | ⚠️ 87.3% (status field) | ✅ 94.1% | ⚠️ 5.1 day avg lag | **Usable — completeness remediation needed** |
| SAP HCM (HRIS) | ⚠️ 91.4% | ⚠️ 84.7% | ⚠️ 88.9% | ❌ 28 day avg lag | **Significant remediation required** |
| Property Database | ✅ 97.1% | ✅ 95.3% | ✅ 96.8% | ✅ Updated weekly | **Reliable** |

**MSA Finding:** SAP HCM data quality was the most significant measurement risk. A targeted data cleansing effort was initiated as a parallel workstream before HR analytics build began.

---

## Baseline Measurements

### Division 1 — Water Services

| Metric | Baseline Value | Measurement Period | Sample Size | Notes |
|---|---|---|---|---|
| Average work order cycle time | **14.2 days** | Jan 2022 – Jan 2024 | n=8,420 WOs | Median: 11.8 days; significant right skew from complex WOs |
| Work order backlog (open WOs >30 days) | **1,847 WOs** | Feb 2024 snapshot | All open WOs | 22% of total open WO volume |
| Reactive vs. planned maintenance ratio | **71% reactive / 29% planned** | Jan 2022 – Jan 2024 | n=8,420 WOs | Industry benchmark: 40% reactive / 60% planned |
| Average days from SCADA alert to work order creation | **4.7 days** | Jan 2022 – Jan 2024 | n=2,180 SCADA alerts | Manual translation process bottleneck |
| Manual reporting hours per week | **18.5 hours** | 4-week time study | 3 staff members | Across scheduling, compilation, and distribution |
| Infrastructure failures (unplanned) | **147 events** | Calendar year 2023 | Full year | 89 attributable to deferred maintenance |

**Baseline Sigma Level — Work Order Cycle Time:**
- Upper Specification Limit (USL): 5 days (target future state)
- Current Mean: 14.2 days
- Standard Deviation: 8.4 days
- Process Capability (Cpk): **-0.37** (highly incapable — significant improvement opportunity)
- **Baseline Sigma: 1.8σ**

---

### Division 2 — Municipal Licensing & Standards

| Metric | Baseline Value | Measurement Period | Sample Size | Notes |
|---|---|---|---|---|
| High-risk inspection coverage rate | **61.3%** | Jan 2022 – Jan 2024 | n=4,210 high-risk properties | Target: ≥80% |
| Average inspection scheduling lead time | **12.4 days** | Jan 2022 – Jan 2024 | n=11,840 inspections | Time from trigger to scheduled date |
| Repeat violation rate (12 months) | **38.2%** | Jan 2022 – Jan 2024 | n=6,920 closed cases | Industry benchmark: <20% |
| % inspections from proactive vs. reactive triggers | **14% proactive / 86% reactive** | Jan 2022 – Jan 2024 | n=11,840 | Complaint-driven only |
| Manual scheduling hours per week | **4.2 hours** | 4-week time study | 2 officers | Manual queue review and calendar management |
| Average days from violation to re-inspection | **67 days** | Jan 2022 – Jan 2024 | n=2,640 violations | No systematic escalation mechanism |

**Baseline Sigma Level — High-Risk Inspection Coverage:**
- Target: 80% coverage (USL direction: maximize)
- Current: 61.3%
- Gap to target: 18.7 percentage points
- **Baseline Sigma: 2.1σ**

---

### Division 3 — People & Equity

| Metric | Baseline Value | Measurement Period | Sample Size | Notes |
|---|---|---|---|---|
| Weekly manual reporting hours | **12.3 hours** | 4-week time study | 4 analysts | Headcount: 6hrs; Turnover: 3.5hrs; Vacancy: 2.8hrs |
| Workforce data lag (days) | **28.4 days average** | 12-month log review | 12 monthly cycles | Time from period end to report availability |
| HRIS data completeness (critical fields) | **84.7%** | Feb 2024 data audit | n=500 records | 15.3% of records missing ≥1 critical field |
| Ad-hoc data request volume | **23 requests/month** | 3-month log review | 68 requests | Avg 2.1 hrs per request to fulfil |
| Time from headcount change to system update | **8.2 days average** | Jan 2023 – Jan 2024 | n=840 transactions | Longest lag: 47 days |
| Number of active Excel workforce reports | **34 separate files** | Audit — Feb 2024 | Full inventory | Maintained by 7 different staff across divisions |

---

## Pareto Analysis — Top Defect Categories

### Water Services — Work Order Delays (Pareto)

| Delay Category | Frequency | % of Total | Cumulative % |
|---|---|---|---|
| Awaiting parts / materials | 2,840 WOs | 33.7% | 33.7% |
| Crew scheduling conflict | 1,920 WOs | 22.8% | 56.5% |
| Manual data entry / system update lag | 1,480 WOs | 17.6% | 74.1% |
| Incomplete work order information | 980 WOs | 11.6% | 85.7% |
| Awaiting supervisor approval | 620 WOs | 7.4% | 93.1% |
| Other | 580 WOs | 6.9% | 100% |

**Pareto Finding:** The top 3 categories account for 74.1% of all work order delays. Addressing parts availability, crew scheduling, and data entry lag will deliver the majority of cycle time improvement.

### MLS — Repeat Violation Root Categories (Pareto)

| Category | Frequency | % of Total | Cumulative % |
|---|---|---|---|
| Re-inspection delayed >60 days | 1,180 cases | 44.7% | 44.7% |
| Low-risk classification (incorrect) | 740 cases | 28.0% | 72.7% |
| No follow-up enforcement action | 380 cases | 14.4% | 87.1% |
| Owner dispute / appeal backlog | 220 cases | 8.3% | 95.4% |
| Other | 120 cases | 4.6% | 100% |

**Pareto Finding:** 72.7% of repeat violations are caused by re-inspection delays and incorrect risk classification — both directly addressable through process redesign and data-driven risk scoring.

---

## Measure Phase Sign-Off

| Stakeholder | Confirmed | Date |
|---|---|---|
| Albert Ibe — LSS Lead | ✅ | March 2024 |
| [Manager, Water Services] | ✅ | March 2024 |
| [Manager, MLS] | ✅ | March 2024 |
| [Director, People & Equity] | ✅ | March 2024 |

---

*Next Phase: [ANALYZE — Root Cause Analysis](../analyze/root-cause-analysis.md)*
