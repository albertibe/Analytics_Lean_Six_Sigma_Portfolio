# DMAIC — DEFINE Phase
## Lean Six Sigma Project Charter + SIPOC

**Project:** City of Toronto — Municipal Service Delivery Analytics & Process Improvement  
**LSS Lead:** Albert Ibe, PMP | CBAP  
**Sponsor:** Director, Office of the CIO — City of Toronto  
**Date:** January 2024  
**Phase Status:** ✅ Complete

---

## LSS Project Charter

### Problem Statement

The City of Toronto's Water Services, Municipal Licensing & Standards (MLS), and People & Equity divisions are experiencing significant operational inefficiencies rooted in fragmented, manually-driven data processes. Key symptoms include:

- **Water Services:** Work order backlogs are invisible until they become failures. The current 14-day manual reporting cycle means decision-makers are managing yesterday's crisis, not preventing tomorrow's.
- **MLS:** Inspection scheduling is reactive — driven by complaint volume rather than risk. 39% of high-risk properties are not receiving timely inspections. Repeat violations are at 38%, indicating systemic process failure rather than isolated incidents.
- **People & Equity:** The City manages 35,000+ employees with no enterprise workforce analytics capability. Headcount and turnover data is compiled manually in Excel monthly — too slow and too error-prone for strategic workforce planning.

**Quantified Problem:**
- Estimated $3.7M+ in annual operational waste across the three divisions
- 47 staff hours per week consumed by manual data compilation and reporting
- Zero predictive capability in any of the three divisions

### Goal Statement

By December 2024, reduce operational waste and improve data-driven decision capability across three City of Toronto divisions:

| Division | Primary Goal | Target |
|---|---|---|
| Water Services | Reduce work order reporting cycle time | From 14 days to ≤1 day |
| Water Services | Increase predictive maintenance coverage | From 0% to ≥60% of high-risk assets |
| MLS | Increase high-risk inspection coverage | From 61% to ≥80% |
| MLS | Reduce repeat violation rate | From 38% to ≤25% |
| People & Equity | Eliminate manual HR reporting effort | From 12 hrs/week to 0 hrs/week |
| People & Equity | Achieve real-time workforce data availability | From monthly to daily refresh |

### Business Case

| Value Driver | Estimated Annual Value |
|---|---|
| Avoided reactive maintenance — Water Services | $2.1M |
| Reduced repeat violation remediation — MLS | $420K |
| Staff time recovered from manual reporting | $380K (47 hrs/week × 48 weeks × blended rate) |
| Improved inspection compliance — reduced legal exposure | $800K (estimated risk reduction) |
| **Total Estimated Annual Value** | **~$3.7M** |

### Project Scope

**In Scope:**
- Water Services: Work order management process; maintenance analytics dashboard
- MLS: Inspection scheduling process; risk scoring model; compliance dashboard
- People & Equity: Workforce data pipeline; HR analytics dashboard
- Data governance for all analytics outputs

**Out of Scope:**
- Water infrastructure capital planning (separate City program)
- HR system replacement (separate City program)
- Bylaw enforcement legal processes
- Any division not listed above

### Project Team

| Role | Name | Organization | Commitment |
|---|---|---|---|
| LSS Lead / Project Manager | Albert Ibe, PMP CBAP | ECG | 100% |
| Executive Sponsor | [Director, CIO Office] | City of Toronto | 10% |
| Business Lead — Water | [Manager, Water Services] | City of Toronto | 25% |
| Business Lead — MLS | [Manager, MLS] | City of Toronto | 25% |
| Business Lead — HR | [Director, People & Equity] | City of Toronto | 20% |
| Data Architect | [Name] | ECG | 60% |
| Power BI Developer | [Name] | ECG | 80% |
| SQL / Data Analyst | [Name] | ECG | 80% |
| Change Manager | [Name] | ECG | 40% |

---

## SIPOC Analysis

> SIPOC = **S**uppliers → **I**nputs → **P**rocess → **O**utputs → **C**ustomers  
> Used to define high-level process scope before detailed mapping begins.

---

### SIPOC 1 — Water Services: Work Order Management

| Suppliers | Inputs | Process | Outputs | Customers |
|---|---|---|---|---|
| Field crews | Work order requests | 1. Receive service request | Completed work orders | City residents |
| Public complaints system | Asset condition reports | 2. Log work order in MAXIMO | Work order status reports | Water Services management |
| SCADA monitoring system | Inspection reports | 3. Assign crew and schedule | Maintenance schedules | Infrastructure planning team |
| Asset management system | Parts and materials | 4. Execute maintenance work | Asset condition updates | Finance / Budget team |
| Parts suppliers | Labour availability | 5. Update work order status | Compliance reports | City Council |
| Weather data | Budget allocations | 6. Compile management reports (manual) | KPI dashboard (future state) | Public (via service delivery) |
| | | 7. Submit to leadership for review | | |

**Key Process Pain Points Identified:**
- Step 6 (manual report compilation) accounts for 14 of 14 days of cycle time
- Step 3 (scheduling) has no risk-based prioritization — FIFO only
- No integration between SCADA alerts and work order creation — manual translation required

---

### SIPOC 2 — MLS: Inspection Scheduling and Compliance

| Suppliers | Inputs | Process | Outputs | Customers |
|---|---|---|---|---|
| Public complaints system | Complaints and service requests | 1. Receive complaint or trigger | Inspection reports | Property owners |
| Property database | Property records | 2. Review and triage manually | Violation notices | City residents |
| Bylaw officers | Inspection history | 3. Schedule inspection (manual, FIFO) | Compliance orders | MLS management |
| Court records | Officer availability | 4. Conduct inspection | Court referrals | City Legal team |
| Provincial legislation | Violation history | 5. Document findings | Performance reports | City Council |
| | Risk scores (future state) | 6. Issue orders or close | Risk-prioritized queue (future) | Provincial regulators |
| | | 7. Track compliance manually | | |

**Key Process Pain Points Identified:**
- Step 3: No risk-based prioritization — high-risk properties treated same as low-risk
- Step 7: Compliance tracking in spreadsheets — no automated escalation
- No feedback loop from court outcomes to inspection prioritization

---

### SIPOC 3 — People & Equity: Workforce Reporting

| Suppliers | Inputs | Process | Outputs | Customers |
|---|---|---|---|---|
| HRIS (SAP HCM) | Employee records | 1. Extract data from HRIS manually | Monthly headcount report | Senior leadership |
| Payroll system | Payroll data | 2. Clean and reconcile in Excel | Turnover report | People & Equity team |
| Timekeeping system | Leave records | 3. Build Excel pivot tables | Vacancy report | Finance / Budget |
| Division managers | Org chart data | 4. Validate with division managers | Workforce dashboard (future) | City Manager's Office |
| Finance | Budget data | 5. Compile final report | | City Council |
| | | 6. Email to leadership | | |
| | | 7. Respond to ad-hoc data requests | | |

**Key Process Pain Points Identified:**
- Steps 1–6 consume 12 hours of skilled analyst time per week — pure waste
- Step 4 (validation) required because data quality is poor — root cause, not symptom
- Step 7 (ad-hoc requests) consumes additional 3–5 hours/week with no self-service alternative

---

## Voice of the Customer (VOC)

*Captured through 18 stakeholder interviews and 2 focus groups across the three divisions.*

| Stakeholder Group | Key Pain (verbatim themes) | Critical to Quality (CTQ) |
|---|---|---|
| Water Services Management | "We find out about failures after they happen, not before" | Predictive maintenance alerts; real-time asset health visibility |
| MLS Officers | "I'm scheduling inspections based on who called last, not who's highest risk" | Risk-based inspection queue; automated scheduling |
| People & Equity Director | "I present workforce data that's 30 days old to a Council that wants answers today" | Daily data refresh; self-service analytics |
| City CIO | "We need to move from reporting to insight — from backward-looking to forward-looking" | Predictive analytics capability; enterprise dashboard |
| Front-line staff (all divisions) | "We spend more time generating reports than acting on them" | Automated reporting; exception-based alerts only |

---

## CTQ Tree (Critical to Quality)

```
Customer Need → Quality Driver → CTQ Measure
│
├── Timely data for decisions
│   ├── Reporting frequency              → Data refresh cycle ≤ 4 hours
│   └── Report availability              → Dashboard available 99.5% uptime
│
├── Accurate and trusted data
│   ├── Data quality                     → <2% error rate in critical fields
│   └── Consistent definitions           → 100% of KPIs have agreed definitions
│
├── Actionable insights
│   ├── Predictive capability            → ≥60% of high-risk assets flagged before failure
│   └── Risk prioritization              → ≥80% of high-risk inspections completed on schedule
│
└── Reduced manual effort
    ├── Automated reporting              → ≤30 min/week manual reporting effort per division
    └── Self-service access              → Leaders access data independently without analyst support
```

---

## Define Phase Sign-Off

| Stakeholder | Role | Approved | Date |
|---|---|---|---|
| [Director, CIO Office] | Executive Sponsor | ✅ | January 2024 |
| [Manager, Water Services] | Business Lead | ✅ | January 2024 |
| [Manager, MLS] | Business Lead | ✅ | January 2024 |
| [Director, People & Equity] | Business Lead | ✅ | January 2024 |
| Albert Ibe | LSS Lead / PM | ✅ | January 2024 |

---

*Next Phase: [MEASURE — Data Collection and Baseline](../measure/measurement-plan.md)*
