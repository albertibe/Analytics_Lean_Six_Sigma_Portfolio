# Case Study — Water Services Maintenance Analytics
## City of Toronto | Consulting Engagement via ECG | 2024

---

## Engagement Context

**Client:** City of Toronto — Toronto Water Services  
**Consultant Firm:** Expertedge Consulting Group (ECG)  
**Consultant:** Albert Ibe, PMP | CBAP | CSM  
**Engagement Period:** January – December 2024  
**Methodology:** Lean Six Sigma (DMAIC) + Agile Analytics Delivery  
**Program Value:** ~$1.4M (Water Services workstream)

---

## Executive Summary

Toronto Water Services manages 7,200+ km of water mains, 3,100 km of watercourses, and serves a population of 2.9 million residents. The division was operating with a reactive maintenance posture — addressing failures after they occurred rather than preventing them — driven primarily by an absence of integrated data systems and analytics capability.

This case study documents the end-to-end DMAIC engagement that transformed Water Services from a complaint-driven, paper-intensive operation into a data-driven, risk-prioritized maintenance function — reducing work order cycle time by 73%, recovering 17 staff hours per week, and projecting $2.1M in avoided reactive maintenance costs in Year 1.

---

## DEFINE — Problem Framing

### Baseline Reality

When the engagement began in January 2024, Water Services was operating with the following conditions:

The work order management system (MAXIMO) and the SCADA asset monitoring system were completely disconnected. When SCADA detected an anomaly — pressure drop, flow irregularity, pump degradation — a technician would manually review the alert, manually create a work order in MAXIMO, and manually assign it to a crew. This translation process took an average of 4.7 days — meaning that by the time a crew was assigned to investigate a SCADA alert, the asset had been operating in a degraded state for nearly a week.

The scheduling queue was strictly first-in, first-out. A routine valve inspection and an urgent pump degradation alert sat in the same queue and were addressed in the order received. There was no risk-based prioritization — no way to surface the highest-criticality assets to the top of the queue.

Three analysts spent 18.5 hours per week compiling Excel reports from MAXIMO exports. The reports were 14 days old by the time they reached the Director's desk — making them descriptive of what had already happened, not useful for what needed to happen.

**Voice of the Customer (verbatim):**
> *"We find out about failures when a resident calls to say there's no water. By then, we're in emergency mode. I want to know about problems before my phone rings."* — Director, Water Services Operations

### Problem Statement (DEFINE output)
Work order average cycle time of 14.2 days (target: ≤5 days), reactive maintenance ratio of 71% (target: ≤40%), and 18.5 hours/week of manual reporting waste are costing the City an estimated $2.4M annually in reactive repair premiums and 936 analyst hours per year in non-value-added reporting activity.

---

## MEASURE — Baseline Quantification

### Data Sources Analyzed
- MAXIMO Work Order System: 24 months of work order history (n=8,420 records)
- SCADA Asset Monitoring: 24 months of alert and performance data (n=2,180 alerts)
- GIS Asset Database: Full asset inventory with criticality ratings
- Parts and Procurement System: 24 months of procurement history
- Analyst time diaries: 4-week time study across 3 analysts

### Key Baseline Metrics

| Metric | Baseline | Measurement |
|---|---|---|
| Average work order cycle time | 14.2 days | 24-month MAXIMO extract |
| Median work order cycle time | 11.8 days | 24-month MAXIMO extract |
| Reactive maintenance ratio | 71% reactive / 29% planned | 24-month WO classification |
| SCADA-to-work order creation lag | 4.7 days average | SCADA log vs. MAXIMO join |
| Open work orders >30 days (backlog) | 1,847 WOs | Point-in-time snapshot |
| Parts-related delay (% of WOs) | 33.7% of all delayed WOs | MAXIMO delay code analysis |
| Manual reporting hours | 18.5 hrs/week | 4-week time study |
| Infrastructure failures (unplanned) | 147 events in 2023 | MAXIMO incident records |
| **Baseline Process Sigma** | **1.8σ** | Cpk = -0.37 |

### Pareto Finding
Three root categories accounted for 74.1% of all work order delays: parts availability (33.7%), crew scheduling conflicts (22.8%), and manual data entry lag (17.6%). The analysis confirmed that addressing these three categories would deliver the majority of cycle time improvement.

---

## ANALYZE — Root Cause Identification

### Root Cause 1: SCADA-MAXIMO Disconnect (Validated)
**Evidence:** SQL analysis of SCADA alert timestamps vs. MAXIMO work order creation timestamps showed a mean lag of 4.7 days, with a standard deviation of 3.1 days. The maximum recorded lag was 23 days — meaning a critical infrastructure alert sat unaddressed for over three weeks.

**5-Why conclusion:** No integration was ever built between the two systems because they were procured at different times by different IT programs with no integration requirement. Manual bridging became institutionalized practice.

### Root Cause 2: No Demand Forecasting for Parts (Validated)
**Evidence:** Regression analysis of 24 months of parts procurement data against work order type, asset age, and season showed clear predictable demand patterns — pump seal replacements peak in winter; valve actuator failures correlate with freeze-thaw cycles; hydrant failures cluster by asset age. None of this pattern was being used to pre-position parts inventory.

**5-Why conclusion:** No analytics capability existed for operational planning — MAXIMO data was used for record-keeping only, never for demand modelling.

### Root Cause 3: FIFO Scheduling with No Risk Context (Validated)
**Evidence:** Cohort analysis comparing outcomes for Critical-rated assets vs. Low-rated assets showed that Critical assets were not receiving materially faster response times — 14.8 days average for Critical vs. 13.4 days for Low. Priority code was being applied inconsistently and had no algorithmic enforcement.

---

## IMPROVE — Solution Design and Implementation

### Solution Architecture

**Component 1 — SCADA-to-MAXIMO Integration (8-week build)**
- REST API integration built between SCADA platform and MAXIMO
- Automated work order creation triggered when SCADA reading crosses defined threshold
- Priority code automatically assigned based on asset criticality and deviation magnitude
- Alert-to-WO creation time target: <2 hours (from 4.7 days)

**Component 2 — Risk-Based Priority Scoring Model**
A composite priority score (0–100) was built for every work order at creation:

```
Priority Score =
  (Asset Criticality Rating × 25)     [0–100 points, max weight 25%]
+ (SCADA Deviation Severity × 25)     [0–100 points, max weight 25%]
+ (Days Since Last Maintenance × 25)  [0–100 points, max weight 25%]
+ (Work Order Age × 25)               [0–100 points, max weight 25%]
```

Crew scheduling queue re-sorted by priority score descending — highest priority work orders always surface first regardless of creation date.

**Component 3 — Predictive Parts Demand Model**
- Analyzed 24 months of parts consumption by asset class, age cohort, and month
- Built seasonal demand forecast model (linear regression with seasonal adjustment)
- Integrated forecast output with procurement system — automated PO recommendation when forecast demand exceeds 70% of stock level
- Result: Parts ordered ahead of demand, not after assignment

**Component 4 — Power BI Maintenance Dashboard**
Four dashboard modules delivered in Agile sprints (3 × 2-week sprints):

*Sprint 1:* Operational Overview — Open WO queue by priority, backlog trend, crew utilization  
*Sprint 2:* Asset Health — SCADA performance by asset, degradation trend visualization  
*Sprint 3:* Management KPIs — Cycle time trend, reactive/planned ratio, cost analysis

---

## CONTROL — Sustained Improvement

### Final Results (December 2024 vs. January 2024 Baseline)

| Metric | Baseline | Final | Improvement |
|---|---|---|---|
| Average work order cycle time | 14.2 days | 3.8 days | **↓ 73%** |
| SCADA-to-work order creation lag | 4.7 days | 1.6 hours | **↓ 97%** |
| Reactive maintenance ratio | 71% | 48% | **↓ 32%** (en route to 40% target) |
| Parts stockout rate | ~34% of WOs affected | 8% | **↓ 76%** |
| Manual reporting hours | 18.5 hrs/week | 1.5 hrs/week | **↓ 92%** |
| Work order backlog (>30 days) | 1,847 WOs | 412 WOs | **↓ 78%** |
| Infrastructure failures (unplanned) | 147 (2023) | 94 (2024 projected) | **↓ 36%** |
| **Process Sigma** | **1.8σ** | **3.4σ** | **+1.6σ** |

### Financial Impact (Year 1 Projection)
| Category | Value |
|---|---|
| Reduced reactive repair premium (avg 3.2x planned cost) | $2.1M |
| Analyst time recovered (17 hrs/week × 48 weeks × blended rate) | $204K |
| Reduced emergency contractor callouts | $180K |
| **Total Year 1 Value** | **~$2.5M** |

### Sustainability Mechanisms
- Control charts configured in Power BI with UCL/LCL alerts to operations manager
- Quarterly SCADA threshold review process established
- Parts demand model recalibration scheduled annually (October — pre-winter)
- City IT staff trained and independently operating all systems by December 2024

---

## Key Lessons

**Lesson 1 — Integration unlocks everything**
The SCADA-MAXIMO integration was the single highest-impact change. Every other improvement depended on clean, timely asset condition data flowing into the work order system automatically. System integration is infrastructure for data-driven operations.

**Lesson 2 — FIFO is not neutral — it actively creates inequity**
First-in-first-out scheduling feels fair but produces risk-blind outcomes. By treating all work orders equally, the organization was systematically under-responding to critical assets and over-responding to low-risk ones. Risk-based prioritization is not just more efficient — it is more equitable.

**Lesson 3 — Demand forecasting is simple but rare**
The parts demand model was built in two weeks using 24 months of existing MAXIMO data and basic regression. The analysis was not technically complex — it just had never been done. The data was always there. The question was never asked.

---

## Artifacts Produced

| Artifact | Location in Portfolio |
|---|---|
| LSS Project Charter + SIPOC | [Define Phase](../04-lean-six-sigma/define/project-charter-lss.md) |
| Measurement Plan + Baseline | [Measure Phase](../04-lean-six-sigma/measure/measurement-plan.md) |
| Fishbone + 5-Why Analysis | [Analyze Phase](../04-lean-six-sigma/analyze/root-cause-analysis.md) |
| Solution Design + Pilot Results | [Improve Phase](../04-lean-six-sigma/improve/solution-design.md) |
| Control Plan + Final Sigma | [Control Phase](../04-lean-six-sigma/control/control-plan.md) |
| SQL — Work Order Analytics | [SQL Queries](../03-data-analytics/sql-queries/water-services-analysis.sql) |
| Power BI Dashboard Specs | [Dashboard Design](../03-data-analytics/dashboards/dashboard-design-specs.md) |

---

*Consulting engagement delivered through Expertedge Consulting Group (ECG). Client details generalized appropriately.*
