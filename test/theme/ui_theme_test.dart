import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mooodier/mooodier.dart';

void main() {
  group('CustomTheme', () {
    const seedColor = Colors.blue;

    group('light theme', () {
      test('creates a light theme with correct brightness', () {
        final theme = CustomTheme.light(seedColor: seedColor);

        expect(theme.brightness, Brightness.light);
        expect(theme.colorScheme.brightness, Brightness.light);
        expect(theme.useMaterial3, isTrue);
      });

      test('uses seed color for color scheme generation', () {
        final theme = CustomTheme.light(seedColor: seedColor);

        expect(theme.colorScheme.primary, isNotNull);
        expect(theme.colorScheme.secondary, isNotNull);
      });
    });

    group('dark theme', () {
      test('creates a dark theme with correct brightness', () {
        final theme = CustomTheme.dark(seedColor: seedColor);

        expect(theme.brightness, Brightness.dark);
        expect(theme.colorScheme.brightness, Brightness.dark);
        expect(theme.useMaterial3, isTrue);
      });

      test('uses seed color for color scheme generation', () {
        final theme = CustomTheme.dark(seedColor: seedColor);

        expect(theme.colorScheme.primary, isNotNull);
        expect(theme.colorScheme.secondary, isNotNull);
      });
    });

    group('accessibility features', () {
      group('large text', () {
        test('does not scale text by default', () {
          final theme = CustomTheme.light(seedColor: seedColor);
          final defaultTheme = ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: seedColor,
              brightness: Brightness.light,
            ),
          );

          expect(
            theme.textTheme.bodyMedium?.fontSize,
            defaultTheme.textTheme.bodyMedium?.fontSize,
          );
        });

        test('scales text when largeText is enabled', () {
          const accessibility = AccessibilityConfig(
            largeText: true,
            textScaleFactor: 1.5,
          );
          final theme = CustomTheme.light(
            seedColor: seedColor,
            accessibility: accessibility,
          );
          final defaultTheme = ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: seedColor,
              brightness: Brightness.light,
            ),
          );

          final defaultSize = defaultTheme.textTheme.bodyMedium?.fontSize ?? 14;
          expect(
            theme.textTheme.bodyMedium?.fontSize,
            closeTo(defaultSize * 1.5, 0.1),
          );
        });

        test('scales all text styles when largeText is enabled', () {
          const accessibility = AccessibilityConfig(
            largeText: true,
            textScaleFactor: 1.2,
          );
          final theme = CustomTheme.light(
            seedColor: seedColor,
            accessibility: accessibility,
          );

          expect(theme.textTheme.displayLarge?.fontSize, greaterThan(57));
          expect(theme.textTheme.headlineMedium?.fontSize, greaterThan(28));
          expect(theme.textTheme.bodySmall?.fontSize, greaterThan(12));
        });
      });

      group('large touch targets', () {
        test('uses default button padding when disabled', () {
          final theme = CustomTheme.light(seedColor: seedColor);

          final buttonStyle = theme.elevatedButtonTheme.style;
          final padding = buttonStyle?.padding?.resolve({});

          expect(padding, const EdgeInsets.all(Spacings.md));
        });

        test('uses larger button padding when enabled', () {
          const accessibility = AccessibilityConfig(largeTouchTargets: true);
          final theme = CustomTheme.light(
            seedColor: seedColor,
            accessibility: accessibility,
          );

          final buttonStyle = theme.elevatedButtonTheme.style;
          final padding = buttonStyle?.padding?.resolve({});

          expect(padding, const EdgeInsets.all(Spacings.lg));
        });

        test('increases button minimum size when enabled', () {
          const accessibility = AccessibilityConfig(largeTouchTargets: true);
          final theme = CustomTheme.light(
            seedColor: seedColor,
            accessibility: accessibility,
          );

          final buttonStyle = theme.elevatedButtonTheme.style;
          final minSize = buttonStyle?.minimumSize?.resolve({});

          expect(minSize?.width, 88);
          expect(minSize?.height, 48);
        });

        test('uses default button minimum size when disabled', () {
          final theme = CustomTheme.light(seedColor: seedColor);

          final buttonStyle = theme.elevatedButtonTheme.style;
          final minSize = buttonStyle?.minimumSize?.resolve({});

          expect(minSize?.width, 64);
          expect(minSize?.height, 40);
        });

        test('increases card border radius when enabled', () {
          const accessibility = AccessibilityConfig(largeTouchTargets: true);
          final theme = CustomTheme.light(
            seedColor: seedColor,
            accessibility: accessibility,
          );

          final cardShape = theme.cardTheme.shape as RoundedRectangleBorder?;
          final borderRadius = cardShape?.borderRadius as BorderRadius?;

          expect(borderRadius?.topLeft.x, Radii.xl);
        });

        test('uses default card border radius when disabled', () {
          final theme = CustomTheme.light(seedColor: seedColor);

          final cardShape = theme.cardTheme.shape as RoundedRectangleBorder?;
          final borderRadius = cardShape?.borderRadius as BorderRadius?;

          expect(borderRadius?.topLeft.x, Radii.lg);
        });

        test('increases list tile padding when enabled', () {
          const accessibility = AccessibilityConfig(largeTouchTargets: true);
          final theme = CustomTheme.light(
            seedColor: seedColor,
            accessibility: accessibility,
          );

          expect(
            theme.listTileTheme.contentPadding,
            const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          );
        });

        test('uses default list tile padding when disabled', () {
          final theme = CustomTheme.light(seedColor: seedColor);

          expect(
            theme.listTileTheme.contentPadding,
            const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          );
        });
      });

      group('high contrast', () {
        test('does not modify colors by default', () {
          final theme = CustomTheme.light(seedColor: seedColor);
          final defaultTheme = ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: seedColor,
              brightness: Brightness.light,
            ),
          );

          expect(theme.colorScheme.primary, defaultTheme.colorScheme.primary);
        });

        test('increases contrast when enabled', () {
          const accessibility = AccessibilityConfig(highContrast: true);
          final theme = CustomTheme.light(
            seedColor: seedColor,
            accessibility: accessibility,
          );
          final defaultTheme = CustomTheme.light(seedColor: seedColor);

          // High contrast theme should have different colors
          expect(
            theme.colorScheme.primary != defaultTheme.colorScheme.primary,
            isTrue,
          );
        });

        test('uses white/black for onPrimary in light mode', () {
          const accessibility = AccessibilityConfig(highContrast: true);
          final theme = CustomTheme.light(
            seedColor: seedColor,
            accessibility: accessibility,
          );

          expect(theme.colorScheme.onPrimary, Colors.white);
          expect(theme.colorScheme.onSecondary, Colors.white);
        });

        test('uses white/black for surface in light mode', () {
          const accessibility = AccessibilityConfig(highContrast: true);
          final theme = CustomTheme.light(
            seedColor: seedColor,
            accessibility: accessibility,
          );

          expect(theme.colorScheme.surface, Colors.white);
          expect(theme.colorScheme.onSurface, Colors.black);
        });

        test('uses black/white for surface in dark mode', () {
          const accessibility = AccessibilityConfig(highContrast: true);
          final theme = CustomTheme.dark(
            seedColor: seedColor,
            accessibility: accessibility,
          );

          expect(theme.colorScheme.surface, Colors.black);
          expect(theme.colorScheme.onSurface, Colors.white);
        });
      });

      group('reduced animation', () {
        test('uses default page transitions when disabled', () {
          final theme = CustomTheme.light(seedColor: seedColor);
          final defaultTheme = ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: seedColor,
              brightness: Brightness.light,
            ),
          );

          expect(
            theme.pageTransitionsTheme.builders,
            defaultTheme.pageTransitionsTheme.builders,
          );
        });

        test('uses fade transitions when enabled', () {
          const accessibility = AccessibilityConfig(reducedAnimation: true);
          final theme = CustomTheme.light(
            seedColor: seedColor,
            accessibility: accessibility,
          );

          expect(
            theme.pageTransitionsTheme.builders[TargetPlatform.android],
            isA<FadeUpwardsPageTransitionsBuilder>(),
          );
          expect(
            theme.pageTransitionsTheme.builders[TargetPlatform.iOS],
            isA<FadeUpwardsPageTransitionsBuilder>(),
          );
        });
      });
    });

    group('AccessibilityConfig', () {
      test('has correct defaults', () {
        const config = AccessibilityConfig();

        expect(config.largeText, isFalse);
        expect(config.textScaleFactor, 1.0);
        expect(config.largeTouchTargets, isFalse);
        expect(config.highContrast, isFalse);
        expect(config.reducedAnimation, isFalse);
      });

      test('allows customization of all properties', () {
        const config = AccessibilityConfig(
          largeText: true,
          textScaleFactor: 1.5,
          largeTouchTargets: true,
          highContrast: true,
          reducedAnimation: true,
        );

        expect(config.largeText, isTrue);
        expect(config.textScaleFactor, 1.5);
        expect(config.largeTouchTargets, isTrue);
        expect(config.highContrast, isTrue);
        expect(config.reducedAnimation, isTrue);
      });
    });

    group('theme consistency', () {
      test('card theme is properly configured', () {
        final theme = CustomTheme.light(seedColor: seedColor);

        expect(theme.cardTheme.elevation, 2);
        expect(theme.cardTheme.shape, isNotNull);
      });

      test('elevated button theme has pill-shaped border', () {
        final theme = CustomTheme.light(seedColor: seedColor);

        final buttonStyle = theme.elevatedButtonTheme.style;
        final shape =
            buttonStyle?.shape?.resolve({}) as RoundedRectangleBorder?;
        final borderRadius = shape?.borderRadius as BorderRadius?;

        expect(borderRadius, Radii.extraLarge);
      });
    });
  });
}
