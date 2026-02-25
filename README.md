# mooodier

Reusable visual design system and widget library extracted from the `mooody` app.

## What's included

- Design tokens (`spacing`, `radius`, `durations`)
- Theme helpers and colour extensions
- Visual effect surfaces (`AnimatedGradientContainer`, `FrostedGlassContainer`)
- Common composable widgets (`UiSurfaceCard`, `UiSection`, `UiSectionHeader`, `UiInfoBanner`, `UiActionButton`, `UiListTile`)
- Text normalization widgets (`UiFormattedText`, `UiFormattedTextField`)
- A visual catalog page (`UiComponentCatalogPage`) for quick preview and integration testing

## Usage

Add as a path dependency:

```yaml
dependencies:
  mooodier:
    path: packages/mooodier
```

Import:

```dart
import 'package:mooodier/mooodier.dart';
```

Open catalog page:

```dart
Navigator.of(context).push(
  MaterialPageRoute(builder: (_) => const UiComponentCatalogPage()),
);
```

## Development

### Running Tests

Run all tests:

```bash
flutter test
```

### Coverage

Run tests with coverage (excludes `example/` and `lib/src/showcase/`):

```bash
./coverage.sh
```

Or manually:

```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

### Example App

The example app provides an interactive storybook with:
- Component catalog
- Theme customization
- Accessibility settings

```bash
cd example
flutter run
```
