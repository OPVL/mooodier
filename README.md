# mooodier

Reusable visual design system and widget library extracted from the `mooody` app.

## What's included

### Design Tokens
- **Spacings** - Consistent spacing values (`xs`, `sm`, `md`, `lg`, `xl`, `xxl`, `screenPadding`)
- **Radii** - Border radius tokens (`small`, `medium`, `large`, `xLarge`)
- **Durations** - Animation duration values (`fast`, `medium`, `slow`)

### Theme System
- **UiTheme** - Material 3 theme builder with light/dark modes
- **AccessibilityConfig** - Built-in support for:
  - Large text (text scale factor)
  - Large touch targets (minimum 48x48)
  - High contrast mode
  - Reduced animations
- **Color Extensions** - `darken()` and `lighten()` helpers for dynamic color adjustments

### Visual Effect Surfaces
- **AnimatedGradientContainer** - Self-blurred animated gradient background with:
  - Configurable animation speed (0.1x - 3.0x)
  - Lava lamp-style chaotic movement
  - Customizable colors, blur, and circle count
  - Pause when offscreen for performance
- **FrostedGlassContainer** - Glass morphism overlay effect with configurable blur and opacity

### UI Components
- **SurfaceCard** - Card with variants: `elevated`, `outlined`, `glass`
- **Section** - Content section with optional title and children
- **SectionHeader** - Styled section headers
- **InfoBanner** - Informational banner with icon, title, and message
- **ActionButton** - Action buttons with variants: `primary`, `subtle`
- **CustomListTile** - List tile with icon, title, subtitle, and optional trailing widget

### Text Formatting
- **FormattedText** - Text widget with optional lowercase forcing
- **FormattedTextField** - Text field that can display text in lowercase while preserving original value

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

### Example: Using the theme

```dart
MaterialApp(
  theme: UiTheme.light(
    seedColor: Colors.blue,
    accessibility: AccessibilityConfig(
      largeText: true,
      highContrast: false,
    ),
  ),
  darkTheme: UiTheme.dark(seedColor: Colors.blue),
  home: MyHomePage(),
);
```

### Example: Animated gradient background

```dart
AnimatedGradientContainer(
  colors: [Colors.blue, Colors.purple, Colors.pink],
  animationSpeed: 1.5,
  child: YourContent(),
)
```

## Development

### Running Tests

Run all tests:

```bash
flutter test
```

The test suite includes 200+ tests covering:
- Theme generation and accessibility features
- All design tokens
- All widgets and their variants
- Text formatting behavior

### Coverage

Run tests with coverage (excludes `example/`):

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
- **Component Catalog** - Visual showcase of all widgets
- **Theme Settings** - Live theme color customization
- **Accessibility Settings** - Toggle accessibility features (large text, high contrast, etc.)
- **Interactive Demos** - Animation speed controls, frosted glass modals, formatted text examples

Run the example:

```bash
cd example
flutter run
```

## Features

### Accessibility First
All components respect `AccessibilityConfig` settings:
- Text scales with system/custom text size
- Touch targets expand to minimum 48x48 when large touch targets enabled
- High contrast mode adjusts colors
- Animations can be reduced/disabled

### Performance Optimized
- AnimatedGradientContainer pauses when offscreen
- Efficient widget composition
- Minimal rebuilds

### Customizable
- Theme built on Material 3 with custom seed colors
- All widgets accept standard Flutter styling
- Design tokens can be used independently
