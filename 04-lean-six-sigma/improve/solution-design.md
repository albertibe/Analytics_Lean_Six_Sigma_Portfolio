# DMAIC — IMPROVE Phase
## Solution Design and Implementation

**LSS Lead:** Albert Ibe, PMP | CBAP  
**Phase Duration:** June – October 2024  
**Phase Status:** ✅ Complete

---

## Solution Selection — Pugh Matrix

Each solution option was evaluated against weighted criteria to select the optimal approach.

**Scoring:** 5 = Strongly meets criterion | 3 = Partially meets | 1 = Does not meet  
**Weight:** Importance of each criterion to the City's objectives (1–5)

### Water Services Solutions

| Criterion | Weight | Option A: Manual Process Improvement Only | Option B: SCADA Integration + Analytics | Option C: Full Predictive Platform |
|---|---|---|---|---|
| Addresses root causes | 5 | 1 | 5 | 5 |
| Reduces cycle time to target | 5 | 2 | 5 | 5 |
| Implementation feasibility | 4 | 5 | 4 | 2 |
| Cost within budget | 4 | 5 | 4 | 2 |
| Sustainable long-term | 3 | 1 | 4 | 5 |
| Staff adoption likelihood | 3 | 4 | 4 | 3 |
| **Weighted Score** | | **67** | **114** | **88** |

**Selected: Option B — SCADA Integration + Analytics Dashboard**  
*Reason: Highest weighted score. Option C deferred to Phase 2 — ML/predictive capability to be added once clean data pipeline is established.*

---

## Solution Design

### Solution 1 — Water Services: Integrated Maintenance Analytics

**Root Causes Addressed:** RC-01, RC-02, RC-07

#### Component 1A: SCADA-to-MAXIMO Integration
- Build API integration between City's SCADA monitoring platform and MAXIMO work order system
- Automate work order creation when SCADA detects asset performance below threshold
- Eliminate 4.7-day manual translation lag — target: <2 hour automated trigger

#### Component 1B: Risk-Based Work Order Prioritization
- Develop asset criticality scoring model incorporating:
  - Asset age and condition rating (from asset management system)
  - Historical failure frequency (from MAXIMO)
  - Population served / service impact (from GIS data)
  - SCADA performance deviation score
- Assign each work order a priority score (1–100) at creation
- Crew scheduling queue sorted by priority score, not FIFO

#### Component 1C: Predictive Parts Demand Model
- Analyze 24 months of work order history by asset type, age, and season
- Build demand forecast model: expected parts requirements by month and asset class
- Trigger automated procurement recommendation when forecast demand exceeds stock threshold

#### Component 1D: Power BI Maintenance Analytics Dashboard
**Dashboard Modules:**

| Module | Key Metrics | Audience |
|---|---|---|
| Operational Overview | Open WOs by priority; backlog trend; crew utilization | Operations Manager |
| Asset Health | SCADA performance by asset; degradation trend; predicted failures | Asset Manager |
| Maintenance Performance | Cycle time trend; reactive vs. planned ratio; MTBF | Director |
| Financial | Maintenance cost by asset class; budget vs. actual; cost avoidance | Finance |

---

### Solution 2 — MLS: Risk-Based Inspection Intelligence

**Root Causes Addressed:** RC-03, RC-05, RC-08

#### Component 2A: Property Risk Scoring Model
Develop a quantitative risk score (0–100) for each of the City's 340,000+ licensed properties:

```
Risk Score = 
  (Violation History Weight × Violation Score)           [35%]
+ (Property Type Weight × Type Risk Factor)              [25%]
+ (Time Since Last Inspection Weight × Recency Score)    [20%]
+ (Complaint Frequency Weight × Complaint Score)         [15%]
+ (Geographic Cluster Weight × Area Risk Score)          [5%]
```

**Risk Tiers:**
- **Critical (75–100):** Inspect within 5 business days
- **High (50–74):** Inspect within 15 business days
- **Medium (25–49):** Inspect within 45 business days
- **Low (0–24):** Inspect within 90 days or next annual cycle

#### Component 2B: Automated Inspection Queue
- Case management system reconfigured with risk score integration
- Daily automated queue generation — officers see prioritized inspection list each morning
- Automatic re-inspection trigger at violation close — scheduled based on violation severity
- Escalation alert when high-risk or critical property passes inspection due date

#### Component 2C: MLS Compliance Dashboard

| Module | Key Metrics | Audience |
|---|---|---|
| Inspection Performance | Coverage rate by risk tier; on-time %; officer productivity | MLS Manager |
| Compliance Trends | Violation rate by property type; repeat violation rate; resolution time | Director |
| Risk Overview | Properties by risk tier; critical properties overdue | Operations |
| Officer Workload | Cases per officer; geographic distribution; open queue age | Team Lead |

---

### Solution 3 — People & Equity: Workforce Analytics Platform

**Root Causes Addressed:** RC-04, RC-06

#### Component 3A: HR Data Governance Remediation (Prerequisite)
Before analytics build, a 6-week data remediation workstream:
- Define mandatory fields and validation rules for all 14 commonly incorrect fields
- Configure HRIS field-level validation — mandatory fields cannot be left blank
- Develop data entry standards guide — distributed to all 34 data entry teams
- Conduct data quality baseline re-assessment after remediation
- Appoint People & Equity Data Steward (role defined, not a new hire — existing analyst)

#### Component 3B: Automated HR Data Pipeline
- Build automated daily extract from SAP HCM using scheduled SQL job
- Apply transformation and standardization rules (Python / Power Query)
- Load to centralized HR Analytics data mart (Azure SQL)
- Data quality validation at each pipeline stage — failed records quarantined, not loaded

#### Component 3C: Workforce Analytics Dashboard

| Module | Key Metrics | Audience |
|---|---|---|
| Headcount Overview | Total headcount by division/role; FTE vs. part-time; trend | City Manager |
| Turnover & Retention | Turnover rate by division; voluntary vs. involuntary; tenure at exit | HR Director |
| Vacancy Management | Open positions; time-to-fill; cost of vacancy | HR & Finance |
| Workforce Planning | Retirement eligibility %; succession gap; diversity metrics | Executive Team |

---

## Pilot Results (September 2024)

Before full rollout, each solution was piloted with one team/region for 6 weeks.

### Water Services Pilot — North District (8-week pilot)
| Metric | Baseline | Pilot Result | Projected Annual |
|---|---|---|---|
| Work order cycle time | 14.2 days | 3.8 days | ↓ 73% |
| SCADA-to-WO lag | 4.7 days | 1.6 hours | ↓ 97% |
| Parts stockout events | 12/month | 3/month | ↓ 75% |
| Reporting time | 18.5 hrs/week | 1.5 hrs/week | ↓ 92% |

### MLS Pilot — Central District (6-week pilot)
| Metric | Baseline | Pilot Result | Projected Annual |
|---|---|---|---|
| High-risk inspection coverage | 61.3% | 79.4% | ↑ 29.5% |
| Avg scheduling lead time | 12.4 days | 4.1 days | ↓ 67% |
| Re-inspection triggered auto | 0% | 94% | New capability |

### HR Analytics Pilot — 3 Divisions (4-week pilot)
| Metric | Baseline | Pilot Result |
|---|---|---|
| Manual reporting hours | 12.3 hrs/week | 0.5 hrs/week (exception only) |
| Data freshness | 28 days | Daily refresh |
| HRIS data completeness | 84.7% | 96.2% (post-remediation) |
| Ad-hoc request fulfilment time | 2.1 hrs avg | Self-service — 0 hrs analyst time |

---

## Improve Phase Sign-Off

| Stakeholder | Confirmed | Date |
|---|---|---|
| Albert Ibe — LSS Lead | ✅ | October 2024 |
| [Manager, Water Services] | ✅ | October 2024 |
| [Manager, MLS] | ✅ | October 2024 |
| [Director, People & Equity] | ✅ | October 2024 |
| [Director, CIO Office] | ✅ | October 2024 |

---

*Next Phase: [CONTROL — Sustained Improvement](../control/control-plan.md)*
