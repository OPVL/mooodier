import 'package:flutter/material.dart';

import '../tokens/spacings.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final EdgeInsetsGeometry padding;
  final Widget? trailing;

  const SectionHeader({
    super.key,
    required this.title,
    this.trailing,
    this.padding = const EdgeInsets.symmetric(
      horizontal: Spacings.lg,
      vertical: Spacings.sm,
    ),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: padding,
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
