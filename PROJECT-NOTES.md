# Empire State Financing — Project Notes

Last updated: September 11, 2026

## Persistent project location
- Repository: ZENAI7/empire-state-financing
- Branch: main
- Primary website source: index.html
- Public site: https://empire-state-financing.vercel.app/

## Project purpose
Empire State Financing LLC is a bilingual English/Spanish funding-discovery website designed to help individuals, businesses, nonprofits, and organizations explore grants, affordable loans, CDFIs, and other financing opportunities.

## Current website structure
- Sticky Empire State Financing header
- English / Spanish language controls
- Hero section and funding call to action
- Funding solutions: grants, affordable loans, other capital
- Consultation / informational sections
- Four-step initial funding request form
- Potential program matches after submission
- Funding program registry
- Disclaimer footer
- Branded bilingual warning before users open an external website

## Application flow
1. Applicant type and name/business information
2. Contact information
3. Funding preference, requested amount, timeline, purpose, and plan description
4. Review, consent, submit, and display potential funding matches

The initial request is stored locally on the visitor's device under the browser localStorage key `esf-last-application`.

## Language system
The site supports English and Spanish. The selected language is stored locally under `esf-language`. Static page text, form text, program cards, and match cards switch language while form values remain stable.

## Funding sources currently represented
- SBA Microloan Program — U.S. Small Business Administration
- NYC Financing Assistance — NYC Small Business Services
- Empire State Development Programs
- CDFI Fund — U.S. Department of the Treasury

These are informational links to independent official sources. Funding availability, eligibility, approval, rates, fees, deadlines, and terms are controlled by the corresponding programs/institutions.

## External website protection / user experience
External funding links are intercepted by an Empire State Financing branded warning. The warning explains that the visitor is opening an independent external resource. The visitor can stay on Empire State Financing or continue. Continuing opens the official source in a new tab so the Empire State Financing page remains open. The warning follows the site's selected English/Spanish language.

## Important commits
- dd2e03195dd8d6a923ecd1c09cb6dffe3c5ffe0b — Fix EN/ES full-site language switching
- 704623fe8c780a2835b53290dc6c640efa0923ed — Add bilingual external-site warning modal

## Working rules for future changes
- Preserve English and Spanish behavior.
- Keep the funding form simple, friendly, and mobile-friendly.
- Do not claim that a new version is live until deployment is verified.
- External funding sources should be clearly identified as independent resources.
- Prefer opening outside sources in a new tab after the warning rather than embedding them, because many government/financial websites block iframe embedding.
- Keep the original Empire State Financing tab open when users visit an outside source.

## Deployment status note
The canonical public URL is https://empire-state-financing.vercel.app/. At the time this note was created, the connected Vercel tool was not listing this project, so the newest GitHub commit could not be independently confirmed as deployed from the connector. Verify deployment before representing a future source change as live.
