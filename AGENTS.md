# AGENTS.md

Flutter app that computes a debt-to-income percentage and classifies credit risk. Everything user-facing is **Spanish** — specs, docs, test names, and error messages. Write new tests/docs in Spanish too.

## Commands (run from repo root)

```bash
flutter pub get
dart format --output=none --set-exit-if-changed lib test   # check only; formats nothing
flutter analyze
flutter test
# single file:
flutter test test/domain/services/credit_risk_classifier_test.dart
```

All four pass on `main` (42 tests, 0 analyzer issues). **There is no CI and no pre-commit hook — these commands are the only quality gate; keep them green.** `analysis_options.yaml` excludes `android/ ios/ web/ macos/ linux/ windows/ build/` from analysis, so `flutter analyze` will not catch mistakes in platform folders.

Toolchain: Flutter 3.47.2 / Dart 3.13.2 (pubspec requires `^3.13.2`). Pinned via FVM — `.fvmrc` and `.fvm/` exist locally but are **gitignored**; the tracked pin is `.vscode/settings.json` → `.fvm/versions/3.47.2`. The system `flutter` on PATH already matches.

## Architecture

- `lib/domain/` — entities, business services, repository **interfaces** (abstract only).
- `lib/application/` — use cases; dependencies injected via constructor (no DI framework).
- No data layer and no real UI yet: `lib/main.dart` is still the stock Flutter counter and does **not** use any use case. `test/widget_test.dart` still tests that counter — replace them together.
- Repository interfaces have no concrete implementations; tests define inline fakes (see `test/application/use_cases/*_test.dart`). `pubspec.yaml` has no `supabase_flutter` yet — Supabase exists only as CLI config + SQL under `supabase/`.
- Validity rules live only in domain services: `AnalyzeCreditUseCase` propagates `DebtToIncomeCalculator`'s `ArgumentError`; `LoginUser`/`RegisterUser` consult `AuthCredentialValidator` before touching the repository. Don't duplicate rules in use cases (rationale in `docs/PHASE_2_REPORT.md`, "Decisiones técnicas").

## Behavior gotchas

- Risk thresholds (`CreditRiskClassifier`, SPEC-002): ≤30 Bajo, ≤40 Moderado, ≤50 Alto, >50 Muy alto — bounds are **inclusive**, and the raw unrounded `double` is classified, so 30.000001 is Moderado. Don't round before classifying.
- Tests assert exact Spanish `ArgumentError` messages (e.g. `El ingreso mensual debe ser mayor que cero.`). Changing message text breaks tests by design.
- Spec-driven + TDD (`docs/constitution.md`): new behavior starts from a spec in `docs/specs/SPEC-00N-*.md`, then a failing test, then minimal implementation. `README.md` carries a dated "estado verificado" status — refresh it when behavior or test counts change.

## Supabase (`supabase/`)

- CLI is the npm devDependency — use `npx supabase ...` (no global install). Local stack needs Docker (`supabase start`).
- pgTAP tests: `npx supabase test db` runs `supabase/tests/database/*_test.sql`. Each file is `begin; ... rollback;` with `plan(N)` — keep the plan count in sync with assertions.
- `credit_analyses` has RLS: users can only insert/select their own rows. Schema changes go in new timestamped files under `supabase/migrations/`.
- `package.json` / `node_modules` exist only for the Supabase CLI; this is not a JS project.
