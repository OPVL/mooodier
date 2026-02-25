import 'package:flutter/material.dart';

import '../tokens/radii.dart';
import '../tokens/spacings.dart';
import 'frosted_glass_container.dart';

enum SurfaceVariant {
  elevated,
  outlined,
  glass,
}

class SurfaceCard extends StatelessWidget {
  final Widget child;
  final SurfaceVariant variant;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius borderRadius;

  const SurfaceCard({
    super.key,
    required this.child,
    this.variant = SurfaceVariant.elevated,
    this.padding = Spacings.cardPadding,
    this.margin,
    this.borderRadius = Radii.large,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (variant == SurfaceVariant.glass) {
      return Container(
        margin: margin,
        child: FrostedGlassContainer(
          borderRadius: borderRadius,
          padding: padding,
          opacity: 0.12,
          color: theme.colorScheme.surface.withValues(alpha: 0.16),
          child: child,
        ),
      );
    }

    final border = variant == SurfaceVariant.outlined
        ? Border.all(color: theme.colorScheme.outline.withValues(alpha: 0.25))
        : null;

    final boxShadow = variant == SurfaceVariant.elevated
        ? [
            BoxShadow(
              color: theme.shadowColor.withValues(alpha: 0.08),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ]
        : null;

    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.94),
        borderRadius: borderRadius,
        border: border,
        boxShadow: boxShadow,
      ),
      child: child,
    );
  }
}
