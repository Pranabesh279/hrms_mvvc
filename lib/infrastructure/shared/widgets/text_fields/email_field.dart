import 'package:flutter/material.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:growit/infrastructure/theme/colors_data.dart';

class EmailField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  const EmailField({super.key, required this.controller, this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: kTextColor,
            fontWeight: FontWeight.w600,
          ),
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter email';
            }
            if (!GetUtils.isEmail(value)) {
              return 'Please enter valid email';
            }
            return null;
          },
      decoration: InputDecoration(
        hintText: 'ex : @growit.com',
        hintStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
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
      ),
    );
  }
}
