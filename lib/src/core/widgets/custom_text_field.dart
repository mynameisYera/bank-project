import 'package:bank/src/core/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:bank/src/core/theme/text_theme.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscure,
    this.keyboardType,
    this.validator,
  });
  final TextEditingController controller;
  final String hintText;
  final bool obscure;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      style: TextStyles.fieldText,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        hintStyle: const TextStyle(color: Color(0xffB1B1B1)),
        fillColor: AppColors.fieldColor,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.grey),
        ),
      ),
    );
  }
}
