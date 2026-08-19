# Feature Planning Document: Submissions Triage
 
## 1. Feature Overview
 
### Feature name
 
### Overview
This an app that fetches submission records and display it for easy access to the user.
Included in the fetched records are those entries that may lack data.  
This comes with search/filter for faster submission look up.
 
### User / customer perspective
The app solves the user problem of compiling records into one place.
The search feature solves the user problem of looking up into records one by one.  
 
### Developer perspective
How do you plan to implement it? 
Create one screen to display the submission records and have the search feat inside it. And another screen for details  

Why is this approach reasonable for the timebox?
A simple screen to render records and a lookup search bar inside it is reasonable for the current timebox. UI / UX are not specified, it is assumed to be simple which is another reason that it suits the timebox provided.

 
### QA perspective
What could go wrong?

 
What should be tested?
 
 
---
 
## 2. User Stories
 
Write 2 to 4 user stories.
 
Format:
- As a <type of user>, I want to <action>, so that <benefit>.
 
For each user story, include 2 to 4 acceptance criteria.
 As a user, I want to have a screen to render all submissions, so that i can see what are the current records, latest from to oldest
 As a user I want to tap on each submission, so that I can see the details of each records
 As a user I want to be able to search through a specific submission, so that it take much of my time to find a single record
 
---
 
## 3. Requirements Review
 
### Functional requirements
List the main functional requirements in your own words.
 
### Non-functional requirements
Usability, performance, accessibility, maintainability,
reliability, and security if relevant.
 
### Requirements I would clarify or challenge
List anything unclear, risky, unnecessary, or worth changing.
 
---
 
## 4. Technical Plan
 
### Technology stack
Xcode - iOS 27, SwiftUI, MVVM
 
### Data model / data handling
Model properties that are not ensured that are required should be optional. 
Adding default values when decoding is a team's preference 
 
### Architecture / components / modules
Views, ViewModels, Models, Services, Networking/API.
 
### State management / flow
Loading, error, empty, search / filter, selected item, reviewed state.
 
### Implementation steps
A short step-by-step plan.
 
---
 
## 5. Testing Plan
 
Manual tests are required. Automated tests are optional.
 
| Test Case | Steps | Expected Result | Tested? |
|---|---|---|---|
|  |  |  | Yes / No |
 
---
 
## 6. Timebox Plan
 
Briefly explain how you plan to spend the 3 to 4 hours.
 
---
 
## 7. Risks, Trade-offs, and Follow-up
 
List important risks, shortcuts, or trade-offs. Also answer:
- What did you intentionally skip?
- What would you improve with more time?
- What would you ask the client before building this for production?
- If you used AI tools, how did you use them and how did you validate output?
 
---
 
## 8. Iterations
 
| Change | Reason |
|---|---|
|  |  |
 
If there were no major changes, write: N/A, no major plan changes.

