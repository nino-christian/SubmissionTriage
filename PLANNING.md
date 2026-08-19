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
The UI does not animate properly
 
What should be tested?
Pull to refresh for state changes
 
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
Fetch data from api (using stub data) and decode the list of submissions
Display the decoded data into a row view to view a summary of each submission
Show loading, error, empty states
Search data submission via query via name or email (currently name only)
Tap a submission entry to view full details
Track and persist views/read status on tapped submissions
Use composable, modular, and decoupled patterns.
 
### Non-functional requirements
Should be user friendly, easy to understand. 
 
### Requirements I would clarify or challenge
N/A
 
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
| Initial load | Launch app | Spinner shows briefly, then list of submissions renders | Yes |
| Initial load failure | Launch app repeatedly until random failure hits | Error state (`ContentUnavailableView`) renders with message | Yes |
| Empty state | Load with a submissions source that returns `[]` | "No Submissions or (query)" empty state renders | Yes |
| Pull to refresh (list) | On loaded list, pull down | Refresh spinner shows, list reloads, nav bar stays responsive after | Yes |
| Pull to refresh (error state) | Trigger error, then pull down | Refresh spinner shows, retries load, transitions to list/error without freezing | Yes |
| Pull to refresh (empty state) | Trigger empty state, then pull down | Refresh spinner shows, retries load without freezing | Yes |
| Search filters list | Type a name/email(only name) into search bar | List filters to matching rows only | Yes |
| Search no results | Type text matching nothing | "No Results or (Query)" state renders | Yes |
| Clear search | Clear search text | Full list restores | Yes |
| Row displays fields | Inspect a row | Name, date, service, status badge all show correct values | Yes |
| Missing data row | Inspect a row with nil name/service/status | Fallback placeholders ("Unknown", "—") render, no crash | Yes |
| Name trimming | Inspect row with excess/irregular spacing in name | Name renders trimmed, single-spaced | Yes |
| Status color badge | Inspect rows across different statuses | Badge background color matches status (new/open/pending/etc.) | Yes |
| Tap row navigates | Tap a row | Pushes to Submission Detail screen with correct submission | Yes |
| Unseen row styling | Tap a never-opened row, go back | Row switches from bold/black to semibold/gray after visiting detail | Yes |
| Seen state persists | Mark a submission seen, relaunch app | Row still shows as seen (UserDefaults persisted) | Yes |
| Detail "New" badge | Open a never-seen submission | "New" badge shows next to name on first view | Yes |
| Detail badge on revisit | Open the same submission again | Badge no longer shows "New" instead shows "Reviewd" (already marked seen) | Yes |
| Detail shows all fields | Inspect detail screen | Service, email, phone, form version, message, internal notes all render | Yes |
| Back navigation | From detail, tap back | Returns to list, scroll position/search preserved | Yes |
 
---
 
## 6. Timebox Plan
 
Briefly explain how you plan to spend the 3 to 4 hours.
I would go structure the data layer first. API Client and the stub data.
I would create the data model
I would create the service for the submission record and inject its dependencies
I would create the service test
I would create next the view model and wire its dependencies
I would create the view model test
I would create the view wiring up with view model
I would create the router
I would create the second view
I would create the subviews
I would wire the routing
I would create the seen/read tracking manager
 
---
 
## 7. Risks, Trade-offs, and Follow-up
 
List important risks, shortcuts, or trade-offs. Also answer:
- What did you intentionally skip? Fetch data via text search, pagination, highlight on search, search via multiple field, sorting
- What would you improve with more time? fetch data via text search, pagination, hightlight on search, saerch via email as well, sorting, and ui fixes
- What would you ask the client before building this for production? 
- If you used AI tools, how did you use them and how did you validate output? I use them to type for me. I validate their inputs according to what was required and how it should be created i.e patterns, variable names, method names, file segregation, class names. This are important to me so that the code itself is self documenting. 
 
---
 
## 8. Iterations
 
| Change | Reason |
|---|---|
|  |  |
 
If there were no major changes, write: N/A, no major plan changes.

