import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? leadingIcon;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? iconColor;

  const CustomListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leadingIcon,
    this.trailing,
    this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: theme.colorScheme.onSurface,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
            )
          : null,
      leading: leadingIcon != null
          ? Icon(leadingIcon, color: iconColor ?? theme.colorScheme.primary)
          : null,
      trailing: trailing ??
          Icon(
            Icons.chevron_right,
            color: theme.colorScheme.onSurfaceVariant,
          ),
      onTap: onTap,
    );
  }
}
