# DMAIC — ANALYZE Phase
## Root Cause Analysis — Fishbone + 5-Why

**LSS Lead:** Albert Ibe, PMP | CBAP  
**Phase Duration:** April – May 2024  
**Phase Status:** ✅ Complete

---

## Analyze Phase Objectives

1. Identify and validate the root causes of the performance gaps quantified in Measure
2. Distinguish between root causes (addressable) and symptoms (not directly actionable)
3. Prioritize root causes by impact and controllability
4. Build the evidence base for solution design in Improve

---

## Analysis 1 — Water Services: Work Order Cycle Time

### Fishbone (Ishikawa) Diagram

```
                    EFFECT: Average Work Order Cycle Time = 14.2 Days
                           (Target: ≤1 Day)
                                        |
        ┌───────────────────────────────┼────────────────────────────────┐
        │                              │                                 │
   METHODS                          MACHINES                         MATERIALS
        │                              │                                 │
  No risk-based           MAXIMO not integrated          Parts ordering
  prioritization          with SCADA system              triggered only AFTER
        │                              │                 WO assigned — too late
  FIFO scheduling         Manual data entry              │
  regardless of           required (3+ touchpoints)      Parts on 5-day
  asset criticality       │                              delivery minimum
        │                 System updates lag             │
  No predictive           4.7 days behind               No local parts
  trigger from            real events                   buffer for common
  condition data          │                             failure modes
        │                              │                                 │
        └───────────────────────────────┼────────────────────────────────┘
                                        │
        ┌───────────────────────────────┼────────────────────────────────┐
        │                              │                                 │
   PEOPLE                         MEASUREMENT                    ENVIRONMENT
        │                              │                                 │
  Supervisor approval        No real-time dashboard         14-day reporting
  required for all WOs       for backlog visibility         cycle = decisions
  regardless of urgency      │                              made on stale data
        │                    KPIs measured monthly          │
  3 analysts spend           (not daily)                   Budget approval
  18.5 hrs/week on           │                             for unplanned work
  manual reporting           No early warning              requires 5-day cycle
        │                    system for asset              │
  Knowledge concentrated     degradation                   Seasonal demand
  in senior staff            │                             spikes not
  — capacity bottleneck      No baseline for               anticipated in
        │                    "normal" vs.                  resource planning
                             "abnormal" asset
                             performance
```

### 5-Why Analysis — Work Order Cycle Time

**Problem:** Average work order cycle time is 14.2 days against a target of ≤1 day

| Why # | Question | Answer |
|---|---|---|
| Why 1 | Why does it take 14 days to complete a work order? | Because work orders wait in queue, then wait for parts, then wait for crew availability |
| Why 2 | Why do work orders wait in queue so long? | Because scheduling is FIFO — no prioritization based on asset criticality or failure risk |
| Why 3 | Why is there no risk-based prioritization? | Because there is no risk score or asset health indicator to prioritize against |
| Why 4 | Why is there no asset health indicator? | Because SCADA condition data is not integrated with MAXIMO — it is manually translated 4.7 days late |
| Why 5 | **Root Cause:** Why is SCADA not integrated with MAXIMO? | **No integration was ever built — the two systems were procured separately with no API connection. Manual bridging became the default practice.** |

**Validated Root Cause #1:** Absence of SCADA-to-MAXIMO integration causes all asset condition data to be manually translated, creating a 4.7-day average lag and preventing any risk-based scheduling capability.

---

**Problem:** Parts availability causing 33.7% of work order delays

| Why # | Question | Answer |
|---|---|---|
| Why 1 | Why are parts causing delays? | Because parts are ordered only after a work order is assigned to a crew |
| Why 2 | Why are parts ordered so late in the process? | Because there is no demand forecasting — parts needs are unknown until the WO is assigned |
| Why 3 | Why is there no demand forecasting? | Because historical work order data is not analyzed to identify patterns by asset type and season |
| Why 4 | Why is historical data not analyzed? | Because no analytics capability exists — data sits in MAXIMO but is never queried for planning |
| Why 5 | **Root Cause:** Why is there no analytics capability? | **No investment in data analytics tooling or skills for the Water Services operational team. Data is used for record-keeping only, not decision support.** |

**Validated Root Cause #2:** Absence of predictive analytics means parts demand is never forecast — triggering reactive procurement that adds 5+ days to every affected work order.

---

## Analysis 2 — MLS: Repeat Violations

### Fishbone Diagram — Repeat Violation Rate = 38.2%

```
                 EFFECT: Repeat Violation Rate = 38.2% (Target: ≤25%)
                                        |
        ┌───────────────────────────────┼────────────────────────────────┐
        │                              │                                 │
   METHODS                          SYSTEMS                          PEOPLE
        │                              │                                 │
  No risk-based              Case management           Officer scheduling
  inspection scheduling      system has no             is manual — calendar
  — complaint-driven only    automated follow-up       management in Outlook
        │                    escalation                │
  Re-inspection not          │                         14% proactive
  auto-triggered at          No dashboard for          inspection rate —
  violation close            overdue re-inspections    officers are
        │                    │                         reactive by necessity
  High-risk properties       Property risk data        │
  treated same as            not integrated            Inspection findings
  low-risk in queue          with scheduling           not linked to
        │                    │                         enforcement outcomes
  No outcome feedback        Violation history         │
  loop — enforcement         not used for
  results don't inform       prioritization
  future scheduling
        │                              │                                 │
        └───────────────────────────────┼────────────────────────────────┘
                                        │
                                  MEASUREMENT
                                        │
                              No real-time compliance
                              rate dashboard
                                        │
                              Repeat violation rate
                              calculated monthly —
                              no early warning
                                        │
                              No property risk score
                              exists — subjective
                              prioritization only
```

### 5-Why Analysis — Repeat Violations

**Problem:** 38.2% of closed violations result in a repeat violation within 12 months

| Why # | Question | Answer |
|---|---|---|
| Why 1 | Why are violations repeating at 38%? | Because properties are not re-inspected quickly enough after a violation is issued |
| Why 2 | Why are re-inspections delayed? | Because re-inspection is not automatically triggered — it depends on an officer manually following up |
| Why 3 | Why is there no automatic re-inspection trigger? | Because the case management system has no workflow automation for follow-up scheduling |
| Why 4 | Why is there no workflow automation? | Because the system was configured for case recording only — not process management |
| Why 5 | **Root Cause:** Why was it configured for recording only? | **The system was implemented without a process design phase — configuration mirrored the existing manual process rather than redesigning it.** |

**Validated Root Cause #3:** MLS case management system was implemented as a digital record-keeper rather than a process management tool — no automation, no escalation, no risk scoring. The process failure is structural, not a people issue.

---

## Analysis 3 — People & Equity: HR Reporting Waste

### Value Stream Analysis — Current State HR Reporting

| Step | Activity | Time | Value Classification |
|---|---|---|---|
| 1 | SAP HCM data extract (manual) | 1.5 hrs | **Non-Value-Added (NVA)** |
| 2 | Export to Excel; format columns | 0.5 hrs | **NVA** |
| 3 | Clean data errors (14 fields commonly incorrect) | 2.0 hrs | **NVA — waste from poor data quality** |
| 4 | Build pivot tables for headcount | 1.0 hrs | **NVA — repetitive manual work** |
| 5 | Build turnover analysis | 1.5 hrs | **NVA — repetitive manual work** |
| 6 | Build vacancy report | 1.0 hrs | **NVA — repetitive manual work** |
| 7 | Validate with 3 division managers | 2.0 hrs | **NVA — validation caused by poor data quality** |
| 8 | Format final report for presentation | 1.5 hrs | **NVA** |
| 9 | Distribute and respond to questions | 1.3 hrs | **Partial VA — communication has value; format does not** |
| **Total** | | **12.3 hrs/week** | **~95% Non-Value-Added** |

**Key Finding:** 95% of the 12.3 weekly hours consumed by HR reporting is pure waste — activity that consumes cost and time without creating value for the end customer (leadership decision-making).

### 5-Why Analysis — Manual HR Reporting Waste

| Why # | Question | Answer |
|---|---|---|
| Why 1 | Why does HR reporting consume 12.3 hours per week? | Because all data extraction, cleaning, analysis, and formatting is done manually each cycle |
| Why 2 | Why is it all manual? | Because there is no automated data pipeline or self-service reporting tool |
| Why 3 | Why is there no automated pipeline? | Because the HRIS data is too inconsistent to automate without extensive transformation |
| Why 4 | Why is HRIS data inconsistent? | Because data entry standards are not enforced at the point of entry — 34 separate teams enter HR data with no validation rules |
| Why 5 | **Root Cause:** Why are there no data entry validation rules? | **HRIS configuration did not include mandatory field validation or data standards enforcement. There is no data governance framework for HR data — no owner, no steward, no standards.** |

**Validated Root Cause #4:** Absence of HR data governance (no data standards, no entry validation, no data owner) means data quality is permanently degraded at the source — making automation impossible without a governance remediation workstream first.

---

## Root Cause Summary and Prioritization

| # | Root Cause | Division | Impact Score (1–10) | Controllability (1–10) | Priority |
|---|---|---|---|---|---|
| RC-01 | No SCADA-to-MAXIMO integration — prevents risk-based scheduling | Water | 9 | 7 | **Critical** |
| RC-02 | No predictive analytics — parts demand never forecast | Water | 8 | 8 | **Critical** |
| RC-03 | Case management implemented as record-keeper not process tool — no automation | MLS | 9 | 6 | **Critical** |
| RC-04 | No HR data governance — validation and standards absent at point of entry | HR | 8 | 7 | **Critical** |
| RC-05 | No risk scoring model for properties — scheduling is complaint-driven | MLS | 8 | 8 | **Critical** |
| RC-06 | No self-service analytics — all insight requires analyst mediation | All | 7 | 9 | **High** |
| RC-07 | Supervisor approval required for all WOs regardless of urgency | Water | 6 | 7 | **High** |
| RC-08 | No automated re-inspection trigger post-violation | MLS | 7 | 7 | **High** |

---

## Analyze Phase Sign-Off

| Stakeholder | Confirmed | Date |
|---|---|---|
| Albert Ibe — LSS Lead | ✅ | May 2024 |
| [Manager, Water Services] | ✅ | May 2024 |
| [Manager, MLS] | ✅ | May 2024 |
| [Director, People & Equity] | ✅ | May 2024 |
| [Director, CIO Office] | ✅ | May 2024 |

---

*Next Phase: [IMPROVE — Solution Design](../improve/solution-design.md)*
