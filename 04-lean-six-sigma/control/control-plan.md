# DMAIC — CONTROL Phase
## Sustained Improvement and Governance

**LSS Lead:** Albert Ibe, PMP | CBAP  
**Phase Duration:** November – December 2024  
**Phase Status:** ✅ Complete

---

## Control Phase Objectives

1. Ensure improvements are sustained after the consulting engagement ends
2. Transfer ownership of processes, dashboards, and governance to City staff
3. Establish monitoring mechanisms with early warning triggers
4. Document all solutions for ongoing operations and future enhancement

---

## Control Plan

### Water Services Control Plan

| CTQ Measure | Target | Control Method | Monitoring Frequency | Alert Threshold | Responsible Owner |
|---|---|---|---|---|---|
| Work order cycle time | ≤5 days average | Power BI control chart — daily | Daily | >7 days average (3-day rolling) | Operations Manager |
| SCADA-to-WO lag | <4 hours | Automated system log monitoring | Daily | >8 hours (any event) | Water Services IT |
| Reactive maintenance ratio | ≤40% | Monthly maintenance type report | Monthly | >55% reactive in any month | Asset Manager |
| Parts stockout rate | ≤5% of WOs affected | MAXIMO stockout flag tracking | Weekly | >10% in any week | Supply Chain Lead |
| Work order backlog (>30 days) | <500 open WOs | Dashboard backlog tile | Daily | >800 open WOs | Operations Manager |
| Reporting manual effort | ≤2 hrs/week | Monthly time study (self-report) | Monthly | >5 hrs/week | Operations Manager |

### MLS Control Plan

| CTQ Measure | Target | Control Method | Monitoring Frequency | Alert Threshold | Responsible Owner |
|---|---|---|---|---|---|
| High-risk inspection coverage | ≥80% | Dashboard coverage rate tile | Weekly | <75% in any week | MLS Manager |
| Repeat violation rate | ≤25% | Monthly compliance report | Monthly | >30% in rolling 3 months | Director, MLS |
| Critical property overdue | 0 | Dashboard alert — automated | Daily | Any Critical property >5 days overdue | Team Lead |
| Re-inspection auto-trigger rate | ≥95% | System log audit | Monthly | <90% in any month | IT / Case Management Admin |
| Inspection lead time | ≤5 days | Dashboard scheduling metrics | Weekly | >8 days average | MLS Manager |

### HR Analytics Control Plan

| CTQ Measure | Target | Control Method | Monitoring Frequency | Alert Threshold | Responsible Owner |
|---|---|---|---|---|---|
| Data pipeline success rate | ≥99% | Automated pipeline health monitor | Daily | Any failed load | HR IT / Data Steward |
| HRIS data completeness | ≥95% | Data quality dashboard tile | Weekly | <92% any critical field | HR Data Steward |
| Workforce data freshness | ≤24 hrs | Pipeline timestamp monitoring | Daily | >36 hours since last refresh | HR IT |
| Manual reporting effort | ≤1 hr/week | Monthly check-in with team | Monthly | >3 hrs/week | People & Equity Director |
| Ad-hoc request volume | ≤5/month | Request log tracking | Monthly | >10/month (signals self-service gap) | HR Analytics Lead |

---

## Statistical Process Control — Control Charts

Control charts were configured in Power BI for the three primary CTQ measures.

### Water Services — Work Order Cycle Time Control Chart

```
Days
20 |     UCL = 18.4 days
   |  ────────────────────────────────────────────────────────
18 |
16 |  ●  ●
14 |        ●  ●  ●     ← BASELINE (Jan-Mar 2024: avg 14.2 days)
12 |                 ●  ●
10 |                          ●
 8 |         CL = 7.3 days (post-improvement)
   |  ────────────────────────────────────────────────────────
 6 |                             ●  ●  ●  ●
 4 |                                          ●  ●  ●  ●  ●
 2 |  ────────────────────────────────────────────────────────
   |                                    LCL = 1.2 days
 0 +────────────────────────────────────────────────────────▶
   Jan  Feb  Mar  Apr  May  Jun  Jul  Aug  Sep  Oct  Nov  Dec
         Baseline              Improve         Control
         Phase                  Phase          Phase
```

**UCL** (Upper Control Limit) = Mean + 3σ = 7.3 + (3 × 3.7) = 18.4 days  
**LCL** (Lower Control Limit) = Mean - 3σ = 7.3 - (3 × 3.7) = 1.2 days (floored at 0)  
**Alert rule:** Any single point above UCL triggers immediate investigation

---

## Handover and Knowledge Transfer

### Knowledge Transfer Plan

| Item | Transfer Method | Recipient | Completion Date |
|---|---|---|---|
| Power BI dashboards — admin access | Hands-on training (4 hrs) | Water IT, MLS IT, HR IT | Nov 15, 2024 |
| SCADA-to-MAXIMO integration — runbook | Documented runbook + walkthrough | Water Services IT | Nov 22, 2024 |
| Risk scoring model — logic and recalibration guide | Documentation + workshop (2 hrs) | MLS Manager + IT | Nov 29, 2024 |
| HR data pipeline — technical documentation | Runbook + architecture diagram | HR IT + Data Steward | Dec 6, 2024 |
| Data quality monitoring — procedures | SOP document + training | HR Data Steward | Dec 6, 2024 |
| Control charts — interpretation guide | Training session (1.5 hrs) | All division leads | Dec 13, 2024 |
| Governance framework — ongoing operations | Documented framework + RACI | All Data Stewards + IT | Dec 13, 2024 |

### Roles Transitioned to City Staff

| Role | Scope | City Staff Owner | ECG Handover Date |
|---|---|---|---|
| Water Analytics Dashboard Owner | Publish, maintain, update Water dashboard | Operations Manager | Dec 1, 2024 |
| MLS Risk Model Owner | Recalibrate risk weights annually | MLS Manager | Dec 1, 2024 |
| HR Data Steward | Data quality monitoring; pipeline exception management | Senior HR Analyst | Nov 15, 2024 |
| Power BI Workspace Admin | All three division workspaces | City IT — Analytics Team | Dec 15, 2024 |
| Program Governance | Quarterly performance review against control plan | Director, CIO Office | Dec 31, 2024 |

---

## Final Sigma Level — Post-Implementation

| Division | CTQ Measure | Baseline Sigma | Final Sigma | Improvement |
|---|---|---|---|---|
| Water Services | Work order cycle time | 1.8σ | 3.4σ | **+1.6σ** |
| MLS | High-risk inspection coverage | 2.1σ | 3.2σ | **+1.1σ** |
| HR Analytics | Manual reporting waste | 1.4σ | 4.1σ | **+2.7σ** |

---

## Lessons Learned — DMAIC Engagement

| # | Lesson | Category | Apply To |
|---|---|---|---|
| 1 | Data governance must be resolved before analytics build — building on bad data creates trusted lies | Data | All analytics projects |
| 2 | Pilot before scaling — the MLS pilot prevented a scheduling logic error from affecting all 340K properties | Risk | All process changes |
| 3 | Control charts in Power BI are more effective than static reports — leaders engage with dynamic visuals | Analytics | All dashboard projects |
| 4 | SIPOC is most valuable when business leads do it themselves — not when consultants do it for them | DMAIC | All LSS projects |
| 5 | The 5-Why stops at the root cause the organization can control — don't identify root causes outside span of control | LSS | All RCA sessions |
| 6 | Knowledge transfer must start in Improve, not at the end of Control — staff need ramp time | Change Mgmt | All consulting engagements |

---

## Engagement Close-Out

| Deliverable | Status |
|---|---|
| All 47 program deliverables completed | ✅ |
| Dashboards live in production | ✅ |
| City staff trained and operating independently | ✅ |
| Control plans active and monitored | ✅ |
| Final engagement report delivered to CIO | ✅ |
| Post-implementation review scheduled (Q1 2025) | ✅ |

**Final Engagement Status: ✅ SUCCESSFULLY CLOSED — December 2024**

---

## Engagement Outcomes Summary

| Category | Value Delivered |
|---|---|
| Annual cost savings / avoidance | ~$3.7M |
| Staff hours recovered per week | 47 hours |
| Process Sigma improvement (avg across divisions) | +1.8σ |
| New analytics capabilities delivered | 3 enterprise dashboards |
| Employees impacted by improved processes | 35,000+ (City workforce) |
| Residents served by improved services | 2.9M (Toronto population) |
