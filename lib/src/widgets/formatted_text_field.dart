import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormattedTextField extends StatefulWidget {
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final InputDecoration? decoration;
  final TextStyle? style;
  final TextInputType? keyboardType;
  final bool obscureText;
  final TextCapitalization textCapitalization;
  final int? maxLines;
  final TextEditingController? controller;
  final bool autofocus;
  final bool autocorrect;
  final List<String>? autofillHints;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;
  final bool forceLowercase;

  const FormattedTextField({
    super.key,
    this.initialValue,
    this.onChanged,
    this.decoration,
    this.style,
    this.keyboardType,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.none,
    this.maxLines = 1,
    this.controller,
    this.autofocus = false,
    this.autocorrect = true,
    this.autofillHints = const [],
    this.maxLength,
    this.inputFormatters,
    this.textInputAction,
    this.onSubmitted,
    this.forceLowercase = false,
  });

  @override
  State<FormattedTextField> createState() => _FormattedTextFieldState();
}

class _FormattedTextFieldState extends State<FormattedTextField> {
  late TextEditingController _controller;
  String _rawValue = '';

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _rawValue = widget.initialValue ?? '';
    _updateDisplayText();
  }

  @override
  void didUpdateWidget(FormattedTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      _rawValue = widget.initialValue ?? '';
      _updateDisplayText();
    }
    // Update display when forceLowercase toggle changes
    if (widget.forceLowercase != oldWidget.forceLowercase) {
      _updateDisplayText();
    }
  }

  void _updateDisplayText() {
    if (widget.controller != null) {
      return;
    }

    final displayText =
        widget.forceLowercase ? _rawValue.toLowerCase() : _rawValue;
    if (_controller.text != displayText) {
      _controller.text = displayText;
      _controller.selection =
          TextSelection.collapsed(offset: displayText.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      enableSuggestions: widget.autofillHints!.isNotEmpty,
      autofillHints: widget.autofillHints,
      autocorrect: widget.autocorrect,
      autofocus: widget.autofocus,
      controller: _controller,
      decoration: widget.decoration,
      style: widget.style,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      obscureText: widget.obscureText,
      textCapitalization: widget.textCapitalization,
      textInputAction: widget.textInputAction,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      onSubmitted: widget.onSubmitted,
      onChanged: (value) {
        _rawValue = value;
        widget.onChanged?.call(_rawValue);

        if (widget.controller == null) {
          final displayText =
              widget.forceLowercase ? _rawValue.toLowerCase() : _rawValue;

          if (_controller.text != displayText) {
            final selection = _controller.selection;
            _controller.text = displayText;
            _controller.selection = selection;
          }
        }
      },
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }
}
