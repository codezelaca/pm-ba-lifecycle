# PM Portfolio Guide

**For Project and Product Managers**

---

## Why PMs Need a Portfolio

**The Reality:** Most PM resumes say "Shipped X features, grew Y metric by Z%" - but there's no proof.

**The Solution:** A portfolio showcasing **strategy documents** and **measurable impact**.

**The Outcome:** Stand out in a crowded field, command 20-30% higher salaries, get interviews at top companies.

---

## What to Include in Your PM Portfolio

### 1. Product Strategy Documents

**Must-Have:**

- Product Requirements Document (PRD)
- Product Roadmap (Now/Next/Later)
- OKRs with actuals vs targets

**Example from This Repo:**

- [Product Backlog with RICE Scoring](../02-reserve-easy-project/04-delivery/product-backlog.md)
- [BRD with Market Analysis](../02-reserve-easy-project/02-specs/BRD-v1.0.md)

**How to Frame:**

> "I authored a PRD for a two-sided marketplace MVP, aligning 5 stakeholders and securing $450k in funding. The roadmap prioritized 20+ features using RICE scoring, focusing on an 8-week launch timeline."

---

### 2. Data-Driven Decision Making

**Must-Have:**

- A/B test results with statistical analysis
- SQL queries showing metric tracking
- Before/After metrics proving impact

**Example from This Repo:**

- [A/B Test SQL Query](../02-reserve-easy-project/05-analytics/queries/ab_test_results.sql)
- [Funnel Analysis](../02-reserve-easy-project/05-analytics/queries/funnel_analysis.sql)

**How to Frame:**

> "I ran an A/B test on booking button copy ('Book Now' vs 'Reserve Table'), reducing drop-off by 12%. I wrote SQL queries to analyze the funnel, identifying a 30% drop-off at payment. This led to a UX redesign that recovered $200k in annual revenue."

---

### 3. Competitive Strategy (Optional)

**Must-Have:**

- Competitive analysis matrix
- Market sizing (TAM/SAM/SOM)
- Go-to-market strategy

**How to Frame:**

> "I conducted a 9-dimension gap analysis comparing our product to 3 competitors, identifying a $3B underserved market (casual dining reservations). This informed our positioning: lower commission + deposit system."

---

## Portfolio Formats

### Option 1: Notion Public Page

**Best for:** PMs with 2+ years experience

**Advantages:**

- Beautiful, interactive
- Easy to update
- Can embed Figma, videos, charts

**Example Structure:**

```
notion.so/yourname/product-portfolio
├── About Me
├── Case Study 1: ReserveEasy (Marketplace MVP)
│   ├── Challenge
│   ├── Approach (PRD, roadmap)
│   ├── Results (metrics, screenshots)
│   └── Learnings
├── Case Study 2: [Another Project]
└── Skills & Tools
```

---

### Option 2: Google Slides Deck

**Best for:** Interview presentations

**Structure:**

1. Cover: Name, Role, Contact
2. Problem Statement (1 slide)
3. Discovery Research (1-2 slides)
4. Solution & Prioritization (2 slides)
5. Execution & Launch (1 slide)
6. Results & Impact (1 slide)
7. Learnings (1 slide)

**Tip:** Keep it to 8-10 slides max. Interviewers have limited time.

---

### Option 3: GitHub Repository (Technical PMs)

**Best for:** B2B SaaS, API-first products, data products

**This Repository is a Template!**

- Fork `pm-ba-lifecycle`
- Replace ReserveEasy with your project
- Keep the structure (BRD, PRD, API specs, SQL queries)

**Advantages:**

- Shows technical fluency (APIs, SQL, version control)
- Demonstrates systems thinking
- Diff history shows your iteration process

---

## How to Talk About Projects in Interviews

### ❌ Wrong Approach:

> "I was PM for a booking platform. We launched successfully."

### ✅ Right Approach (STAR Framework):

**Situation:**

> "Our restaurant partners were losing $60k/year to no-shows (30% rate), and existing platforms like OpenTable charged 20% commission."

**Task:**

> "I was tasked with designing an MVP to reduce no-shows and win market share in the underserved casual dining segment."

**Action:**

> "I conducted 20 restaurant interviews and 50 diner surveys, identifying deposit systems as the key differentiator. I authored a BRD and PRD, prioritizing 15 features using RICE scoring. I worked with engineering to build a real-time availability API (OpenAPI spec here - _pull up portfolio_), and partnered with Twilio for SMS confirmations."

**Result:**

> "We launched in 8 weeks with 50 pilot restaurants. Month 1: 5,000 bookings, <5% no-show rate (vs 30% baseline), NPS of 42. This generated $50k in commission revenue and proved product-market fit."

---

## Metrics That Impress

**Quantify Everything:**

- User growth: "Grew MAU from 0 → 15,000 in 3 months"
- Revenue: "Generated $1.2M ARR in Year 1"
- Efficiency: "Reduced onboarding time from 10 min → 90 sec (85% improvement)"
- Impact: "Feature drove 20% of total revenue despite being 5% of eng time"

---

## Portfolio Hygiene

**Do:**

- ✅ Remove confidential data (use realistic fake data like ReserveEasy)
- ✅ Show Both wins and learnings ("We killed Feature X after 2 months - here's why")
- ✅ Update quarterly (add new projects, archive old ones)
- ✅ Get permission if showcasing real company work

**Don't:**

- ❌ Violate NDAs (anonymize company names if needed)
- ❌ Take sole credit for team work (say "I led" or "collaborated with")
- ❌ Include half-baked examples (3 polished case studies > 10 mediocre ones)

---

## Sample LinkedIn Summary

**Before:**

> Product Manager with 4 years of experience in SaaS. Skilled in roadmapping and stakeholder management.

**After:**

> Product Manager specializing in two-sided marketplaces and growth products. I combine product strategy with technical fluency (SQL, API design) to ship high-impact features:

> - Led a restaurant reservation MVP from 0 → $1.2M ARR (reduced no-shows 80%, 42 NPS)
> - Grew user activation 25% via A/B tested onboarding flow (statistical significance: p<0.01)
> - Managed $2M product budget, prioritizing 50+ features using RICE framework
>
> **Portfolio:** [notion.so/yourname] | **GitHub:** [github.com/yourname]

---

## Senior PM vs Junior PM Portfolios

### Junior PM (0-2 years)

**Focus on:**

- Execution skills (user stories, acceptance criteria, backlog management)
- Collaboration (working with eng/design)
- Learning agility (how you improved over time)

**Example Projects:**

- "Feature launch: Booking modification flow (8 user stories, 2-week sprint)"
- "A/B test: SMS copy optimization (+12% click-through)"

---

### Senior PM (5+ years)

**Focus on:**

- Strategic thinking (market analysis, competitive positioning)
- Leadership (influencing without authority, cross-functional alignment)
- Business impact (revenue, cost savings, market share)

**Example Projects:**

- "Product strategy: Entered $3B casual dining market, captured $1.2M Year 1"
- "Turnaround: Resurrected declining product (+40% retention via user research pivot)"

---

## Tools to Showcase in Portfolio

| Category          | Tools to Mention                                   |
| ----------------- | -------------------------------------------------- |
| **Analytics**     | SQL, Mixpanel, Amplitude, Google Analytics, Looker |
| **Design**        | Figma (link mockups), Miro (link roadmaps)         |
| **Project Mgmt**  | Jira, Linear, Asana                                |
| **Documentation** | Notion, Confluence, Google Docs                    |
| **Technical**     | APIs (REST, GraphQL), Git, basic Python/JavaScript |

**Pro Tip:** Link to actual artifacts. Don't just say "proficient in SQL" - show the query.

---

## Next Steps

1. **Choose 2-3 projects** to showcase (variety: growth feature, new product, optimization)
2. **Create artifacts** using [templates from this repo](../03-toolkit/templates/)
3. **Publish** to Notion, GitHub, or Google Slides
4. **Add to resume/LinkedIn:** "Portfolio: [link]" in header
5. **Practice storytelling:** Can you explain each project in 3 minutes?

---

## Inspiration

**Great PM Portfolios:**

- [Lenny Rachitsky's Blog](https://www.lennysnewsletter.com) - PM best practices, case studies
- [Jackie Bavaro's Portfolio](https://jackiebavaro.com) - Asana PM, clear case studies
- [Ken Norton essays](https://www.bringthedonuts.com) - Google PM, thought leadership

---

[← Back to Main](../README.md) | [BA Portfolio Guide →](ba-portfolio-guide.md)
