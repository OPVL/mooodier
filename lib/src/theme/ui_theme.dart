import 'package:flutter/material.dart';
import 'package:mooodier/mooodier.dart';

class AccessibilityConfig {
  final bool largeText;
  final double textScaleFactor;
  final bool largeTouchTargets;
  final bool highContrast;
  final bool reducedAnimation;

  const AccessibilityConfig({
    this.largeText = false,
    this.textScaleFactor = 1.0,
    this.largeTouchTargets = false,
    this.highContrast = false,
    this.reducedAnimation = false,
  });
}

abstract final class CustomTheme {
  static ThemeData light({
    required Color seedColor,
    AccessibilityConfig accessibility = const AccessibilityConfig(),
  }) {
    final scheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.light,
    );
    return _buildTheme(scheme, accessibility);
  }

  static ThemeData dark({
    required Color seedColor,
    AccessibilityConfig accessibility = const AccessibilityConfig(),
  }) {
    final scheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.dark,
    );
    return _buildTheme(scheme, accessibility);
  }

  static ThemeData _buildTheme(
    ColorScheme baseScheme,
    AccessibilityConfig accessibility,
  ) {
    final scheme =
        accessibility.highContrast ? _increaseContrast(baseScheme) : baseScheme;

    final base = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
    );

    final buttonPadding = accessibility.largeTouchTargets
        ? const EdgeInsets.all(Spacings.lg)
        : const EdgeInsets.all(Spacings.md);

    return base.copyWith(
      textTheme: accessibility.largeText
          ? _scaledTextTheme(base.textTheme, accessibility.textScaleFactor)
          : base.textTheme,
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            accessibility.largeTouchTargets ? Radii.xl : Radii.lg,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: buttonPadding,
          minimumSize: Size(
            accessibility.largeTouchTargets ? 88 : 64,
            accessibility.largeTouchTargets ? 48 : 40,
          ),
          shape: const RoundedRectangleBorder(borderRadius: Radii.extraLarge),
        ),
      ),
      listTileTheme: ListTileThemeData(
        contentPadding: accessibility.largeTouchTargets
            ? const EdgeInsets.symmetric(horizontal: 24, vertical: 8)
            : const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
      pageTransitionsTheme: accessibility.reducedAnimation
          ? const PageTransitionsTheme(
              builders: {
                TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
                TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
              },
            )
          : base.pageTransitionsTheme,
    );
  }

  static ColorScheme _increaseContrast(ColorScheme scheme) {
    final isLight = scheme.brightness == Brightness.light;
    return ColorScheme(
      brightness: scheme.brightness,
      primary: _adjustContrast(scheme.primary),
      onPrimary: isLight ? Colors.white : Colors.black,
      secondary: _adjustContrast(scheme.secondary),
      onSecondary: isLight ? Colors.white : Colors.black,
      error: Colors.red,
      onError: Colors.white,
      surface: isLight ? Colors.white : Colors.black,
      onSurface: isLight ? Colors.black : Colors.white,
    );
  }

  static Color _adjustContrast(Color color) {
    final hsl = HSLColor.fromColor(color);
    if (hsl.lightness < 0.5) {
      return hsl.withLightness((hsl.lightness * 0.8).clamp(0.0, 1.0)).toColor();
    }
    return hsl.withLightness((hsl.lightness * 1.2).clamp(0.0, 1.0)).toColor();
  }

  static TextTheme _scaledTextTheme(TextTheme base, double factor) {
    TextStyle? scale(TextStyle? style, double fallback) =>
        style?.copyWith(fontSize: (style.fontSize ?? fallback) * factor);

    return TextTheme(
      displayLarge: scale(base.displayLarge, 57),
      displayMedium: scale(base.displayMedium, 45),
      displaySmall: scale(base.displaySmall, 36),
      headlineLarge: scale(base.headlineLarge, 32),
      headlineMedium: scale(base.headlineMedium, 28),
      headlineSmall: scale(base.headlineSmall, 24),
      titleLarge: scale(base.titleLarge, 22),
      titleMedium: scale(base.titleMedium, 16),
      titleSmall: scale(base.titleSmall, 14),
      bodyLarge: scale(base.bodyLarge, 16),
      bodyMedium: scale(base.bodyMedium, 14),
      bodySmall: scale(base.bodySmall, 12),
      labelLarge: scale(base.labelLarge, 14),
      labelMedium: scale(base.labelMedium, 12),
      labelSmall: scale(base.labelSmall, 11),
    );
  }
}
