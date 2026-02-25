# UI Library Analysis

## Scope reviewed

The current `mooody` app UI was reviewed across:

- `lib/widgets/common`
- `lib/widgets/forms`
- `lib/widgets/layout`
- `lib/widgets/onboarding`
- `lib/widgets/settings`
- `lib/widgets/theme`
- `lib/theme`

## Patterns observed

1. **Repeated surface styling**
   - Frequent rounded containers with soft borders and translucent backgrounds.
   - Multiple variants of glass-like treatment and elevated cards.

2. **Repeated semantic sections**
   - Section headers and section wrappers recur in settings, onboarding, and mood UI.

3. **Typography normalization**
   - Text casing behavior is applied through dedicated formatting wrappers.

4. **Action and list primitives**
   - Variants of action buttons and list rows are repeated with small style differences.

5. **Theme-driven colour usage**
   - Components mostly derive colours from `Theme.of(context).colorScheme` with transparency modifiers.

## Packaging decisions

### Included in `mooodier`

- Visual effects:
  - `AnimatedGradientContainer`
  - `FrostedGlassContainer`
- Foundation tokens:
  - spacing, radius, durations
- Generic reusable building blocks:
  - section, section header, list tile, info banner, action button, surface card
- Text wrappers:
  - formatted text, formatted text field with transform option
- Theme helper:
  - optional accessibility-oriented theme shaping
- Developer tooling:
  - visual catalog page for fast review

### Deferred (app-specific)

- Mood-specific views (`MoodGrid`, scale widgets, detail drawers)
- Security/auth wrappers and dialogs with domain behavior
- Theme management/editor widgets that depend on app providers/models

## Result

The package now provides a reusable design system foundation that can be imported by this app and future Flutter apps, while intentionally leaving domain-specific logic in `mooody`.
