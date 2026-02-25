import 'package:flutter/material.dart';

class FormattedText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final bool forceLowercase;

  const FormattedText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.forceLowercase = false,
  });

  @override
  Widget build(BuildContext context) {
    final output = forceLowercase ? text.toLowerCase() : text;
    return Text(output, style: style, textAlign: textAlign);
  }
}
