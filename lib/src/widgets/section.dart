import 'package:flutter/material.dart';

import '../tokens/spacings.dart';
import 'section_header.dart';

class Section extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final EdgeInsetsGeometry padding;
  final Widget? trailing;

  const Section({
    super.key,
    required this.title,
    required this.children,
    this.padding = Spacings.sectionPadding,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: title, trailing: trailing),
          ...children,
        ],
      ),
    );
  }
}
