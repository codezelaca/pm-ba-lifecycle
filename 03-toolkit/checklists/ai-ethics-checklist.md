# AI Ethics Checklist

**Purpose:** Ensure responsible AI development and deployment.

---

## Overview

As AI becomes embedded in products, PMs and BAs must consider **ethical implications** beyond just technical feasibility. This checklist helps identify and mitigate potential harms.

**When to use:** Before building any feature that uses AI/ML (recommendations, predictions, automation, personalization).

---

## Checklist

### 1. Fairness & Bias

**Question:** Could this AI system discriminate against protected groups?

- [ ] Training data is representative of all user groups (not skewed toward one demographic)
- [ ] Model has been tested for bias across race, gender, age, disability, etc.
- [ ] Outcomes audited: Do different groups experience different error rates?
- [ ] Mitigation plan exists if bias is detected (e.g., rebalance training data)

**Example:**  
❌ Bad: Resume screening AI trained only on profiles of past hires (who are 80% male) → Systematically ranks women lower  
✅ Good: Audit model performance by gender, adjust training data to balance representation

---

### 2. Transparency & Explainability

**Question:** Can users understand how the AI made a decision?

- [ ] Users are informed when AI is being used (not hidden)
- [ ] Key factors influencing decisions are explainable (not a "black box")
- [ ] Users can challenge or appeal AI decisions
- [ ] Documentation exists explaining model logic (for regulators, auditors)

**Example:**  
❌ Bad: Loan application denied by AI with no explanation  
✅ Good: "Loan denied due to: debt-to-income ratio (40%), recent missed payment (30%), short credit history (30%)"

---

### 3. Privacy & Data Protection

**Question:** Are we respecting user privacy?

- [ ] Minimum data collection (only what's necessary for the AI to function)
- [ ] User consent obtained before using personal data for AI training
- [ ] Data anonymized where possible (remove PII from training sets)
- [ ] Compliance with GDPR, CCPA, and other privacy regulations
- [ ] Users can opt out of AI features (or request data deletion)

**Example:**  
❌ Bad: Using customer chat transcripts to train AI without informing users  
✅ Good: "We use your anonymized chat data to improve our chatbot. [Opt Out]"

---

### 4. Accountability

**Question:** Who is responsible if the AI causes harm?

- [ ] Clear ownership: Who monitors AI performance post-launch?
- [ ] Incident response plan: What happens if AI makes a harmful decision?
- [ ] Human-in-the-loop for high-stakes decisions (medical, legal, financial)
- [ ] AI decisions are auditable (logs retained for review)

**Example:**  
❌ Bad: Fully automated hiring decisions with no human review  
✅ Good: AI shortlists candidates → Human recruiter makes final decision

---

### 5. Safety & Robustness

**Question:** Could the AI fail in unexpected ways?

- [ ] Adversarial testing: Can users game or manipulate the system?
- [ ] Edge case testing: What happens with unusual inputs?
- [ ] Graceful degradation: If AI fails, does the system fall back safely?
- [ ] Model monitoring: Alert if accuracy drops below threshold

**Example:**  
❌ Bad: Restaurant recommendation AI always suggests closed restaurants (stale data)  
✅ Good: Real-time validation → If restaurant closed, exclude from recommendations

---

### 6. User Autonomy

**Question:** Does the AI empower or manipulate users?

- [ ] Users can override AI suggestions (AI assists, doesn't dictate)
- [ ] Dark patterns avoided (e.g., AI nudging users to spend more money)
- [ ] Addiction mechanisms avoided (e.g., infinite scroll optimized by AI)
- [ ] Users understand consequences of accepting AI recommendations

**Example:**  
❌ Bad: AI auto-subscribes users to premium plan "because it predicts they'll want it"  
✅ Good: AI suggests premium plan → User consciously chooses to upgrade

---

### 7. Environmental Impact

**Question:** What is the carbon footprint of this AI?

- [ ] Model size justified (do we need GPT-4 or will a smaller model work?)
- [ ] Training done on renewable energy infrastructure (when possible)
- [ ] Inference optimized (reduce compute per prediction)
- [ ] Carbon cost documented and considered in ROI

**Example:**  
❌ Bad: Retrain massive model daily for marginal accuracy gain (+0.1%)  
✅ Good: Retrain quarterly, use smaller model for 95% of use cases

---

### 8. Accessibility

**Question:** Can people with disabilities use this AI feature?

- [ ] AI outputs are screen-reader friendly
- [ ] Voice-based AI includes text alternatives (for deaf users)
- [ ] Visual AI includes audio descriptions (for blind users)
- [ ] AI doesn't rely solely on one modality (e.g., facial recognition excludes people with face coverings)

**Example:**  
❌ Bad: Voice-only chatbot (excludes deaf/hard-of-hearing users)  
✅ Good: Chatbot supports both voice and text input/output

---

### 9. Truthfulness & Misinformation

**Question:** Could this AI spread false information?

- [ ] AI-generated content is labeled as such (not passed off as human-created)
- [ ] Fact-checking mechanisms in place (for news, health, legal advice)
- [ ] Sources cited (if AI makes factual claims)
- [ ] Harmful misinformation filtered (e.g., medical advice that could cause harm)

**Example:**  
❌ Bad: AI generates medical advice with no disclaimers or source citations  
✅ Good: "This information is AI-generated and not a substitute for professional medical advice. Consult a doctor."

---

### 10. Job Displacement & Economic Impact

**Question:** Will this AI eliminate jobs without a transition plan?

- [ ] Impact assessment: How many jobs could be affected?
- [ ] Reskilling programs offered (if automating roles)
- [ ] Augmentation prioritized over replacement (AI assists workers, doesn't replace them)
- [ ] Stakeholder communication: Workers informed early about automation plans

**Example:**  
❌ Bad: Replace all customer service reps with chatbots overnight  
✅ Good: Chatbot handles simple FAQs → Reps focus on complex issues (upskill to "escalation specialists")

---

## Case Study: ReserveEasy AI Features

### Use Case: Personalized Restaurant Recommendations

**Fairness:**

- [x] Training data includes diverse cuisines (not just Italian, French)
- [x] Model tested across zip codes (doesn't only recommend expensive restaurants to wealthy neighborhoods)

**Transparency:**

- [x] Users see why restaurants are recommended: "Based on your past bookings (Italian, seafood) and high ratings"

**Privacy:**

- [x] User consent: "ReserveEasy uses your booking history to personalize recommendations. [Manage Privacy Settings]"

**Autonomy:**

- [x] Recommendations are suggestions, not forced (users can search/browse freely)

---

## Red Flags (When to Pause Development)

⚠️ **Stop and reassess if:**

- Model shows >10% accuracy difference across demographic groups
- Users can't understand why AI made a decision
- AI makes decisions that could significantly harm users (financially, emotionally, physically)
- No human oversight for high-stakes outcomes
- Privacy regulators raise concerns

---

## Resources

**Learn More:**

- [AI Ethics Guidelines (Google)](https://ai.google/principles/)
- [Fairness, Accountability, Transparency in ML (FAT/ML)](https://www.fatml.org/)
- [EU AI Act](https://digital-strategy.ec.europa.eu/en/policies/regulatory-framework-ai)

---

[⬅️ Back to Toolkit](../README.md)
