# COT — Data Analytics & Process Improvement Program
## Consulting Engagement Portfolio | Expertedge Consulting Group (ECG)

**Consultant:** Albert Ibe, PMP | CBAP | CSM | SAFe SM | AWS AI Practitioner  
**Firm:** Expertedge Consulting Group (ECG)  
**Client:** City of Toronto (COT) — Office of the Chief Information Officer  
**Engagement Period:** January 2024 – December 2024 (12 months)  
**Engagement Value:** ~$4.2M  
**Role:** Senior Business Analyst & Technical Project Manager  
🔗 [LinkedIn](https://www.linkedin.com/in/albertibe) | [Data Governance Portfolio](https://github.com/albertibe/data-governance-framework) | [BA/PM Portfolio](https://github.com/albertibe/ba-pm-portfolio)

---

## Engagement Summary

Engaged by the City of Toronto's Office of the Chief Information Officer (CIO) to lead a 12-month data analytics modernization and Lean Six Sigma process improvement program across three municipal service divisions.

The engagement addressed a critical gap in the City's ability to use operational data for evidence-based decision-making — resulting in service delivery inefficiencies, delayed capital planning decisions, and a manual reporting burden consuming thousands of staff hours annually.

Delivered end-to-end: from diagnostic assessment through DMAIC process redesign, data pipeline architecture, Power BI analytics deployment, and sustainable governance framework — resulting in measurable improvements across all three divisions.

---

## Engagement Scope

### Division 1 — Toronto Water Services
**Challenge:** 14-day manual work order reporting cycle; no predictive visibility into infrastructure maintenance backlogs  
**Solution:** Automated Power BI maintenance analytics dashboard; DMAIC-driven work order process redesign  
**Impact:** 73% reduction in reporting cycle time; $2.1M in avoided reactive maintenance costs (Year 1 projection)

### Division 2 — Municipal Licensing & Standards (MLS)
**Challenge:** Manual inspection scheduling driven by complaint volume only; no risk-based prioritization  
**Solution:** Data-driven risk scoring model; automated inspection queue; process redesign using DMAIC  
**Impact:** 34% improvement in high-risk inspection coverage; 28% reduction in repeat violations

### Division 3 — People & Equity (HR Analytics)
**Challenge:** No enterprise workforce analytics capability; headcount and turnover reporting done manually in Excel  
**Solution:** End-to-end HR analytics pipeline; workforce dashboard for senior leadership  
**Impact:** First-ever real-time workforce visibility for City's 35,000+ employee base; 12 hours/week of manual reporting eliminated

---

## Portfolio Structure

```
cot-analytics-lss-portfolio/
│
├── README.md                                    ← You are here
│
├── 00-engagement-overview/
│   └── engagement-charter.md                   ← Consulting engagement charter
│
├── 01-project-management/
│   ├── charter/
│   │   └── project-charter-COT-2024.md         ← Full project charter
│   ├── plans/
│   │   ├── integrated-project-plan.md          ← 12-month delivery plan
│   │   └── communication-plan.md               ← Stakeholder communication plan
│   ├── registers/
│   │   ├── risk-register.csv                   ← Program risk register
│   │   ├── issue-log.csv                       ← Issue tracking log
│   │   └── stakeholder-register.csv            ← Stakeholder analysis
│   ├── reporting/
│   │   ├── monthly-status-report-template.md   ← Executive status report
│   │   └── steering-committee-deck-outline.md  ← Steering committee structure
│   └── governance/
│       └── program-governance-model.md         ← Governance framework
│
├── 02-business-analysis/
│   ├── requirements/
│   │   └── business-requirements-doc.md        ← Program BRD
│   ├── stakeholder/
│   │   └── stakeholder-analysis.md             ← Power/interest grid
│   └── process-maps/
│       ├── water-services-current-state.md     ← As-Is: Water work orders
│       ├── water-services-future-state.md      ← To-Be: Water work orders
│       ├── mls-current-state.md               ← As-Is: MLS inspections
│       └── mls-future-state.md               ← To-Be: MLS inspections
│
├── 03-data-analytics/
│   ├── eda/
│   │   └── exploratory-data-analysis.md        ← EDA methodology and findings
│   ├── sql-queries/
│   │   ├── water-services-analysis.sql         ← Work order analytics SQL
│   │   ├── mls-inspection-analysis.sql         ← Inspection risk scoring SQL
│   │   └── hr-workforce-analysis.sql           ← Workforce analytics SQL
│   ├── dashboards/
│   │   └── dashboard-design-specs.md           ← Power BI dashboard specifications
│   └── findings/
│       └── analytics-findings-report.md        ← Key findings and recommendations
│
├── 04-lean-six-sigma/
│   ├── define/
│   │   └── project-charter-lss.md              ← LSS Project Charter + SIPOC
│   ├── measure/
│   │   └── measurement-plan.md                 ← Data collection and baseline metrics
│   ├── analyze/
│   │   ├── root-cause-analysis.md              ← Fishbone + 5-Why analysis
│   │   └── process-capability.md               ← Process capability assessment
│   ├── improve/
│   │   └── solution-design.md                  ← Solution selection and design
│   └── control/
│       └── control-plan.md                     ← Sustained improvement controls
│
├── 05-case-studies/
│   ├── case-study-water-services.md            ← End-to-end Water Services case
│   ├── case-study-mls-inspections.md           ← End-to-end MLS case
│   └── case-study-hr-analytics.md             ← End-to-end HR Analytics case
│
└── 06-deliverables-register/
    └── deliverables-register.csv               ← All 47 program deliverables tracked
```

---

## Key Metrics — Program Outcomes

| Division | Key Metric | Before | After | Improvement |
|---|---|---|---|---|
| Water Services | Reporting cycle time | 14 days | 4 hours | ↓ 97% |
| Water Services | Reactive maintenance cost (projected) | Baseline | -$2.1M/yr | Significant |
| Water Services | Work order backlog visibility | None | Real-time | New capability |
| MLS | High-risk inspection coverage | 61% | 82% | ↑ 34% |
| MLS | Repeat violation rate | 38% | 27% | ↓ 28% |
| MLS | Inspection scheduling time (manual) | 4 hrs/week | 30 min/week | ↓ 88% |
| HR Analytics | Manual reporting effort | 12 hrs/week | 0 hrs/week | ↓ 100% |
| HR Analytics | Workforce data freshness | Monthly | Daily | Transformed |
| HR Analytics | Turnover analysis availability | None | Real-time | New capability |

---

## Methodologies Applied

| Methodology | Application |
|---|---|
| **Lean Six Sigma — DMAIC** | End-to-end process improvement for Water Services and MLS divisions |
| **SIPOC Analysis** | High-level process scoping for all three divisions |
| **Fishbone / Ishikawa Diagram** | Root cause analysis for work order backlog and repeat violations |
| **5-Why Analysis** | Drill-down root cause identification |
| **Value Stream Mapping** | Current-state waste identification |
| **Control Charts** | Statistical process control for sustained improvement monitoring |
| **Pareto Analysis** | 80/20 prioritization of defect categories and complaint types |
| **Power BI** | Enterprise analytics dashboards for all three divisions |
| **SQL** | Data extraction, transformation, and exploratory analysis |
| **Python (EDA)** | Statistical analysis and outlier detection |
| **Agile / Scrum** | Iterative dashboard development and sprint delivery |
| **PMBOK** | Project governance, risk management, and stakeholder management |

---

## Certifications Relevant to This Engagement

| Certification | Relevance |
|---|---|
| PMP (PMI) | Program governance, risk management, stakeholder engagement |
| CBAP (IIBA) | Requirements elicitation, process analysis, solution design |
| CSM / SAFe SM | Agile delivery of analytics sprints |
| AWS AI Practitioner | AI/ML opportunity identification in analytics design |
| DAMA CDMP (In Progress) | Data governance framework applied to analytics outputs |

---

## Related Portfolios

- 🗂️ [Data Governance Framework](https://github.com/albertibe/data-governance-framework)
- 📋 [Senior BA & PM Portfolio](https://github.com/albertibe/ba-pm-portfolio)

---

*This portfolio documents a consulting engagement delivered through Expertedge Consulting Group (ECG). Client details are represented with appropriate generalization.*
