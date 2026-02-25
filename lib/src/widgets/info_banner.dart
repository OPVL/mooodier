import 'package:flutter/material.dart';

import '../tokens/radii.dart';
import '../tokens/spacings.dart';

class InfoBanner extends StatelessWidget {
  final String title;
  final String message;
  final Color? backgroundColor;
  final Color? borderColor;
  final IconData? icon;

  const InfoBanner({
    super.key,
    required this.title,
    required this.message,
    this.backgroundColor,
    this.borderColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.all(Spacings.lg),
      padding: const EdgeInsets.all(Spacings.lg),
      decoration: BoxDecoration(
        color: backgroundColor ??
            theme.colorScheme.primaryContainer.withValues(alpha: 0.35),
        borderRadius: Radii.medium,
        border: Border.all(
          color:
              borderColor ?? theme.colorScheme.primary.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, color: theme.colorScheme.primary, size: 20),
                const SizedBox(width: Spacings.sm),
              ],
              Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: Spacings.sm),
          Text(
            message,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.85),
            ),
          ),
        ],
      ),
    );
  }
}
