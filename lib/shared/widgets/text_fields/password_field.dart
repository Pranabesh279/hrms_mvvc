import 'package:flutter/material.dart';

import 'package:growit/infrastructure/theme/colors_data.dart';
import 'package:growit/shared/input_style.dart';

class PasswoardField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;

  const PasswoardField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.validator});

  @override
  State<PasswoardField> createState() => _PasswoardFieldState();
}

class _PasswoardFieldState extends State<PasswoardField> {
  bool isVisiable = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      controller: widget.controller,
      obscureText: !isVisiable,
      keyboardType: TextInputType.visiblePassword,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: kTextColor,
            fontWeight: FontWeight.w600,
          ),
      validator: widget.validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter email';
            }

            return null;
          },
      decoration: FieldDecoration(
        hintText: widget.hintText,
        hintStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
        suffixIcon: isVisiable == false
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isVisiable = true;
                  });
                },
                icon: const Icon(Icons.visibility_off),
              )
            : IconButton(
                onPressed: () {
                  setState(() {
                    isVisiable = false;
                  });
                },
                icon: const Icon(Icons.visibility),
              ),
      ).kInputDecoration,
    );
  }
}
