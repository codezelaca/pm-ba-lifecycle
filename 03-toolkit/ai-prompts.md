# AI-Assisted PM & BA Prompts

**Practical prompts for using AI tools in product and analysis work**

---

## How to Use This Guide

These prompts are designed for use with AI assistants (ChatGPT, Claude, etc.) to accelerate your PM/BA work. Each prompt includes:

- **Purpose** - What you'll get
- **Template** - Copy-paste prompt with placeholders
- **Example** - Real usage with sample output

⚠️ **Important:** AI is your assistant, not your replacement. Always validate AI outputs against your domain knowledge.

---

## Requirements & Discovery Prompts

### Prompt 1: User Story Generator

**Purpose:** Convert feature requests into well-formatted user stories

**Template:**

```
Convert this feature request into 3-5 user stories with acceptance criteria:

Feature: [Paste feature description]

Context:
- Product: [Your product]
- Target Users: [Personas]
- Business Goal: [Objective]

Format each story as:
"As a [persona], I want [goal], so that [benefit]"

Include GIVEN-WHEN-THEN acceptance criteria.
Estimate story points (1, 2, 3, 5, 8).
```

**Example Input:**

```
Feature: Users should be able to export their booking history

Context:
- Product: Restaurant reservation app
- Target Users: Diners, Restaurant managers
- Business Goal: Increase user retention
```

**Example Output:**

```
US-001: Personal Booking Export
As a diner, I want to export my booking history to PDF, so that I can track my dining expenses.

Acceptance Criteria:
- GIVEN I'm on my profile page, WHEN I click "Export History", THEN I see options for PDF and CSV
- GIVEN I select PDF, WHEN the export completes, THEN I receive a formatted document with date, restaurant, party size, and amount
- Points: 3
```

---

### Prompt 2: Requirements Clarification Questions

**Purpose:** Generate clarifying questions for vague requirements

**Template:**

```
Generate 10 clarifying questions for this requirement:

Requirement: [Paste vague requirement]

Product Context: [Brief context]

Categorize questions by:
1. Scope clarification
2. User needs
3. Technical constraints
4. Edge cases
5. Success criteria
```

---

### Prompt 3: Stakeholder Interview Prep

**Purpose:** Prepare for stakeholder discovery meetings

**Template:**

```
I'm meeting with a [stakeholder role] to gather requirements for [project].

Generate:
1. 10 open-ended discovery questions
2. 5 follow-up probes for deeper insight
3. 3 questions to uncover hidden constraints
4. Meeting agenda template

Context: [Brief project description]
```

---

## Analysis & Strategy Prompts

### Prompt 4: SWOT Analysis Generator

**Purpose:** Create comprehensive SWOT for any product/feature

**Template:**

```
Create a SWOT analysis for:

Product: [Product name]
Market: [Target market]
Key Competitors: [List 2-3]

For each quadrant, provide:
- 5 bullet points
- Evidence or reasoning
- Recommended actions
```

---

### Prompt 5: Competitive Analysis Matrix

**Purpose:** Create structured competitive comparison

**Template:**

```
Create a competitive analysis matrix comparing:

Our Product: [Product]
Competitors: [Comp A], [Comp B], [Comp C]

Analyze across these dimensions:
- Pricing model
- Target audience
- Key features (list 5-7)
- Strengths
- Weaknesses
- Market positioning

Format as a table with our product in the first column.
End with strategic recommendations.
```

---

### Prompt 6: Market Sizing (TAM/SAM/SOM)

**Purpose:** Structure market analysis

**Template:**

```
Help me estimate TAM/SAM/SOM for:

Product: [Description]
Geography: [Target region]
Industry: [Sector]

Walk me through:
1. TAM calculation with data sources
2. SAM segmentation logic
3. SOM assumptions for Year 1-3
4. Key assumptions to validate

Show your math step-by-step.
```

---

## Prioritization Prompts

### Prompt 7: RICE Scoring Assistant

**Purpose:** Help score and prioritize features

**Template:**

```
Help me RICE score these features for [product]:

Features:
1. [Feature A]
2. [Feature B]
3. [Feature C]

Context:
- Monthly active users: [number]
- Current priorities: [goals]

For each, estimate:
- Reach (users/month affected)
- Impact (0.25, 0.5, 1, 2, 3)
- Confidence (50%, 80%, 100%)
- Effort (person-months)

Calculate RICE scores and rank. Explain reasoning.
```

---

### Prompt 8: Stakeholder Alignment Email

**Purpose:** Draft communication for difficult prioritization decisions

**Template:**

```
Draft a stakeholder email explaining why we're deprioritizing their request:

Request: [Feature they wanted]
Requester: [Role]
Decision: Deferring to Q3 (not doing in Q1)
Reason: [Brief reason]

Tone: Professional, empathetic, transparent
Include: Alternative solutions or workarounds

Keep it under 200 words.
```

---

## Documentation Prompts

### Prompt 9: BRD Section Generator

**Purpose:** Draft specific BRD sections

**Template:**

```
Write the [section name] section of a BRD for:

Project: [Project name]
Summary: [1-2 sentence description]

Section to write: [e.g., "Success Criteria", "Risk Assessment", "Scope"]

Include:
- Industry-standard format
- Specific measurable criteria
- 3-5 items per subsection
```

---

### Prompt 10: Process Map Description

**Purpose:** Generate process map from narrative

**Template:**

```
Convert this narrative into a step-by-step process:

Process: [Paste narrative description]

Output as:
1. Numbered steps (who does what)
2. Decision points (if/then branches)
3. Swimlane assignments (which role owns each step)
4. Inputs/outputs for each step

Format for Mermaid diagram compatibility.
```

---

### Prompt 11: Meeting Notes to Action Items

**Purpose:** Extract actionable items from meeting notes

**Template:**

```
Extract action items from these meeting notes:

[Paste meeting notes]

Output format:
| Action Item | Owner | Due Date | Priority |
|-------------|-------|----------|----------|

Also list:
- Key decisions made
- Open questions requiring follow-up
- Risks or blockers identified
```

---

## Technical Prompts

### Prompt 12: SQL Query Helper

**Purpose:** Generate SQL for product analytics

**Template:**

```
Write a SQL query for:

Metric: [What you want to measure]
Tables available:
- [table1] ([columns])
- [table2] ([columns])

Requirements:
- Time range: [e.g., last 30 days]
- Grouping: [e.g., by day, by user segment]
- Filters: [any conditions]

Use PostgreSQL syntax. Add comments explaining logic.
```

---

### Prompt 13: API Requirements Generator

**Purpose:** Document API needs for engineering

**Template:**

```
Design an API for this user story:

User Story: [Paste story]

Generate:
1. Endpoint (method + path)
2. Request payload (JSON schema)
3. Response payload (success + error cases)
4. Business validation rules
5. Edge cases to handle

Use RESTful conventions.
```

---

## Communication Prompts

### Prompt 14: Executive Summary Writer

**Purpose:** Summarize for leadership

**Template:**

```
Summarize this for a C-level executive (max 5 sentences):

Content: [Paste detailed content]

Include:
- Key problem/opportunity (1 sentence)
- What we did/propose (1-2 sentences)
- Result/expected outcome (1 sentence)
- Recommended action (1 sentence)

Avoid jargon. Focus on business impact.
```

---

### Prompt 15: Technical-to-Business Translation

**Purpose:** Explain technical concepts to stakeholders

**Template:**

```
Translate this technical explanation for a non-technical VP:

Technical version: [Paste technical explanation]

Requirements:
- No jargon
- Focus on business impact
- Use analogies if helpful
- Max 3 paragraphs
```

---

## Best Practices

### ✅ Do:

- Provide context (product, users, constraints)
- Specify output format
- Ask for reasoning, not just answers
- Iterate and refine

### ❌ Don't:

- Submit confidential customer data
- Accept outputs without review
- Use for final decisions without validation
- Skip human judgment on edge cases

---

## Advanced Tip: Chain Prompts

Break complex tasks into steps:

1. **Prompt 1:** "Analyze this market data and identify top 3 trends"
2. **Prompt 2:** "For trend #1, generate 5 feature ideas"
3. **Prompt 3:** "For feature idea #2, write user stories"
4. **Prompt 4:** "For user story #1, design the API"

Each step builds on prior context for better results.

---

[⬅️ Back to Main](../README.md)
