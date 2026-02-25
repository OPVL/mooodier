import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mooodier/mooodier.dart';

void main() {
  group('ColourExtensions', () {
    group('darken', () {
      test('darkens a color by default amount (0.1)', () {
        const color = Color(0xFF808080); // Medium gray
        final darkened = color.darken();

        // HSL lightness should be reduced
        final originalHsl = HSLColor.fromColor(color);
        final darkenedHsl = HSLColor.fromColor(darkened);

        expect(darkenedHsl.lightness, lessThan(originalHsl.lightness));
        expect(
          darkenedHsl.lightness,
          closeTo(originalHsl.lightness - 0.1, 0.01),
        );
      });

      test('darkens a color by specified amount', () {
        const color = Color(0xFFFFFFFF); // White
        final darkened = color.darken(0.3);

        final originalHsl = HSLColor.fromColor(color);
        final darkenedHsl = HSLColor.fromColor(darkened);

        expect(
          darkenedHsl.lightness,
          closeTo(originalHsl.lightness - 0.3, 0.01),
        );
      });

      test('clamps lightness to 0.0 minimum', () {
        const color = Color(0xFF202020); // Very dark gray
        final darkened = color.darken(1.0);

        final darkenedHsl = HSLColor.fromColor(darkened);

        expect(darkenedHsl.lightness, greaterThanOrEqualTo(0.0));
      });

      test('preserves hue and saturation', () {
        const color = Color(0xFFFF0000); // Pure red
        final darkened = color.darken(0.2);

        final originalHsl = HSLColor.fromColor(color);
        final darkenedHsl = HSLColor.fromColor(darkened);

        expect(darkenedHsl.hue, closeTo(originalHsl.hue, 0.1));
        expect(darkenedHsl.saturation, closeTo(originalHsl.saturation, 0.01));
      });

      test('throws assertion error for negative amount', () {
        const color = Colors.blue;

        expect(
          () => color.darken(-0.1),
          throwsA(isA<AssertionError>()),
        );
      });

      test('throws assertion error for amount > 1', () {
        const color = Colors.blue;

        expect(
          () => color.darken(1.5),
          throwsA(isA<AssertionError>()),
        );
      });

      test('works with primary colors', () {
        const red = Color(0xFFFF0000);
        const green = Color(0xFF00FF00);
        const blue = Color(0xFF0000FF);

        final darkenedRed = red.darken(0.2);
        final darkenedGreen = green.darken(0.2);
        final darkenedBlue = blue.darken(0.2);

        expect(HSLColor.fromColor(darkenedRed).lightness, lessThan(0.5));
        expect(HSLColor.fromColor(darkenedGreen).lightness, lessThan(0.5));
        expect(HSLColor.fromColor(darkenedBlue).lightness, lessThan(0.5));
      });

      test('returns same color when amount is 0', () {
        const color = Color(0xFF808080);
        final darkened = color.darken(0.0);

        final originalHsl = HSLColor.fromColor(color);
        final darkenedHsl = HSLColor.fromColor(darkened);

        expect(darkenedHsl.lightness, closeTo(originalHsl.lightness, 0.001));
      });
    });

    group('lighten', () {
      test('lightens a color by default amount (0.1)', () {
        const color = Color(0xFF808080); // Medium gray
        final lightened = color.lighten();

        final originalHsl = HSLColor.fromColor(color);
        final lightenedHsl = HSLColor.fromColor(lightened);

        expect(lightenedHsl.lightness, greaterThan(originalHsl.lightness));
        expect(
          lightenedHsl.lightness,
          closeTo(originalHsl.lightness + 0.1, 0.01),
        );
      });

      test('lightens a color by specified amount', () {
        const color = Color(0xFF000000); // Black
        final lightened = color.lighten(0.3);

        final originalHsl = HSLColor.fromColor(color);
        final lightenedHsl = HSLColor.fromColor(lightened);

        expect(
          lightenedHsl.lightness,
          closeTo(originalHsl.lightness + 0.3, 0.01),
        );
      });

      test('clamps lightness to 1.0 maximum', () {
        const color = Color(0xFFF0F0F0); // Very light gray
        final lightened = color.lighten(1.0);

        final lightenedHsl = HSLColor.fromColor(lightened);

        expect(lightenedHsl.lightness, lessThanOrEqualTo(1.0));
      });

      test('preserves hue and saturation', () {
        const color = Color(0xFF0000FF); // Pure blue
        final lightened = color.lighten(0.2);

        final originalHsl = HSLColor.fromColor(color);
        final lightenedHsl = HSLColor.fromColor(lightened);

        expect(lightenedHsl.hue, closeTo(originalHsl.hue, 0.1));
        expect(lightenedHsl.saturation, closeTo(originalHsl.saturation, 0.01));
      });

      test('throws assertion error for negative amount', () {
        const color = Colors.blue;

        expect(
          () => color.lighten(-0.1),
          throwsA(isA<AssertionError>()),
        );
      });

      test('throws assertion error for amount > 1', () {
        const color = Colors.blue;

        expect(
          () => color.lighten(1.5),
          throwsA(isA<AssertionError>()),
        );
      });

      test('works with primary colors', () {
        const red = Color(0xFF8B0000); // Dark red
        const green = Color(0xFF006400); // Dark green
        const blue = Color(0xFF00008B); // Dark blue

        final lightenedRed = red.lighten(0.2);
        final lightenedGreen = green.lighten(0.2);
        final lightenedBlue = blue.lighten(0.2);

        expect(HSLColor.fromColor(lightenedRed).lightness, greaterThan(0.27));
        expect(HSLColor.fromColor(lightenedGreen).lightness, greaterThan(0.2));
        expect(HSLColor.fromColor(lightenedBlue).lightness, greaterThan(0.27));
      });

      test('returns same color when amount is 0', () {
        const color = Color(0xFF808080);
        final lightened = color.lighten(0.0);

        final originalHsl = HSLColor.fromColor(color);
        final lightenedHsl = HSLColor.fromColor(lightened);

        expect(lightenedHsl.lightness, closeTo(originalHsl.lightness, 0.001));
      });
    });

    group('darken and lighten together', () {
      test('darkening then lightening returns approximately original color',
          () {
        const color = Color(0xFF808080);
        final modified = color.darken(0.2).lighten(0.2);

        final originalHsl = HSLColor.fromColor(color);
        final modifiedHsl = HSLColor.fromColor(modified);

        expect(modifiedHsl.lightness, closeTo(originalHsl.lightness, 0.01));
        expect(modifiedHsl.hue, closeTo(originalHsl.hue, 0.1));
        expect(modifiedHsl.saturation, closeTo(originalHsl.saturation, 0.01));
      });

      test('lightening then darkening returns approximately original color',
          () {
        const color = Color(0xFF4080C0);
        final modified = color.lighten(0.15).darken(0.15);

        final originalHsl = HSLColor.fromColor(color);
        final modifiedHsl = HSLColor.fromColor(modified);

        expect(modifiedHsl.lightness, closeTo(originalHsl.lightness, 0.01));
        expect(modifiedHsl.hue, closeTo(originalHsl.hue, 0.5));
        expect(modifiedHsl.saturation, closeTo(originalHsl.saturation, 0.01));
      });
    });

    group('edge cases', () {
      test('black remains black when darkened', () {
        const black = Color(0xFF000000);
        final darkened = black.darken(0.5);

        expect(darkened, black);
      });

      test('white remains white when lightened', () {
        const white = Color(0xFFFFFFFF);
        final lightened = white.lighten(0.5);

        expect(lightened, white);
      });

      test('works with colors with alpha channel', () {
        const color = Color(0x80FF0000); // Semi-transparent red
        final darkened = color.darken(0.1);
        final lightened = color.lighten(0.1);

        // Alpha should be preserved
        expect(darkened.a, color.a);
        expect(lightened.a, color.a);
      });
    });
  });
}
