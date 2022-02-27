// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kyahaal/utils/constants.dart';

class InputField extends StatelessWidget {
  final String? hint;
  final bool obscure;
  final IconData? icon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int? maxLength;
  final String? Function(String?)? validator;

  const InputField({
    Key? key,
    this.hint,
    this.obscure = false,
    this.icon,
    this.controller,
    this.keyboardType,
    this.maxLength,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: const EdgeInsets.symmetric(vertical: 16),
      width: context.mediaQuery.size.width * 0.8,
      child: TextFormField(
        validator: validator,
        inputFormatters: [
          if (maxLength != null) LengthLimitingTextInputFormatter(maxLength),
        ],
        controller: controller,
        keyboardType: keyboardType,
        key: key,
        obscureText: obscure,
        decoration: InputDecoration(
          hintText: hint,
          icon: icon != null ? Icon(icon) : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
