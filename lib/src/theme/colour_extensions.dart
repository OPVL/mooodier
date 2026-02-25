import 'package:flutter/material.dart';

extension ColourExtensions on Color {
  Color darken([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final adjusted = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return adjusted.toColor();
  }

  Color lighten([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final adjusted = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return adjusted.toColor();
  }
}
