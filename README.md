# Submission Triage

An iOS app that fetches submission records and displays them for easy review — with search, pull-to-refresh, and seen/unseen tracking.

## Requirements

- Xcode 26
- iOS 26 +

## Getting Started

1. Clone the repo
2. Open `SubmissionTriage.xcodeproj`
3. Build and run the `SubmissionTriage` scheme on a simulator or device

## Architecture

MVVM, with a lightweight Router for navigation.

```
SubmissionTriage/
├── API/            # APIClient — fetches raw submission data (bundled JSON stub)
├── Service/        # SubmissionService — API-facing business logic
├── Model/          # Submission, SubmissionStatus, Submission+Stub
├── ViewModel/      # SubmissionViewModel — loading, search, seen state
├── View/           # SubmissionView, SubmissionRowView, SubmissionDetailView
├── Navigation/     # Router, Route
├── Formatter/      # FlexibleDateFormatter, SubmittedAtDisplayFormatter
├── Manager/        # SeenSubmissionsManager — persists seen state to UserDefaults
└── Mocks/          # MockSubmissionViewModel — for previews
```

- **Views** depend on a `SubmissionViewModelProtocol`, not a concrete type — `SubmissionView` is generic over it, so previews can swap in `MockSubmissionViewModel`.
- **Navigation** goes through `Router` (`NavigationPath` + `Route` enum), injected via `.environment(router)`.
- **Seen tracking**: `SeenSubmissionsManager` reads/writes a `Set<Int>` of submission ids to `UserDefaults`, injected into `SubmissionViewModel` at the composition root (`SubmissionTriageApp`).

## Features

- List of submissions with name, date, service, and a color-coded status badge
- Loading / error / empty / no-results states
- Pull-to-refresh
- Search by name
- Tap a row to view full submission detail
- Seen/unseen indicator, persisted across launches

## Testing

- `SubmissionTriageTests` — unit tests for `SubmissionService`, `SubmissionViewModel`, `SubmissionStatus`
- Manual test plan: see `PLANNING.md` §5

## Notes

`SubmissionViewModel.loadSubmissions()` randomly fails ~50% of the time to exercise the error/retry UI. See `PLANNING.md` for the rest of the planning docs.
