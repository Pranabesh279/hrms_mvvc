import 'package:flutter/material.dart';

class FieldDecoration {
  final String? labelText;
  final String? hintText;
  final String? prefixText;
  final String? suffixText;
  final String? helperText;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? prefix;
  final Widget? suffix;
  final TextStyle? hintStyle;

  FieldDecoration({
    this.labelText,
    this.hintText,
    this.prefixText,
    this.suffixText,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.hintStyle,
    this.suffixIcon,
    this.prefix,
    this.suffix,
  });

  InputDecoration get kInputDecoration => InputDecoration(
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.5),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.5),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.5),
        ),
        disabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.5),
        ),
        prefix: prefix,
        suffix: suffix,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        label: labelText != null ? Text(labelText!) : null,
        hintText: hintText,
        helperText: helperText,
        errorText: errorText,
        prefixText: prefixText,
        suffixText: suffixText,
        hintStyle: hintStyle,
      );
}
