import 'package:flutter/material.dart';

import '../tokens/radii.dart';

enum ActionButtonVariant {
  primary,
  subtle,
}

class ActionButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ActionButtonVariant variant;
  final IconData? icon;

  const ActionButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = ActionButtonVariant.primary,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 18),
          const SizedBox(width: 10),
        ],
        Text(text),
      ],
    );

    switch (variant) {
      case ActionButtonVariant.subtle:
        return TextButton(onPressed: onPressed, child: content);
      case ActionButtonVariant.primary:
        return OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 56),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(Radii.pill)),
            ),
          ),
          child: content,
        );
    }
  }
}
