import 'package:flutter/material.dart';
import 'package:gradus/src/core/colors/app_colors.dart';
import 'package:gradus/src/core/theme/text_theme.dart';

class PostWidget extends StatelessWidget {
  final String hint;
  final String title;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const PostWidget({
    super.key,
    required this.hint,
    required this.title,
    this.controller,
    this.validator,
  });

  Widget _buildTextField() {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.notBlack,
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyles.miniText.copyWith(color: Color(0xffB3B3B3)),
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.headerText,
        ),
        SizedBox(height: 10),
        FormField<String>(
          validator: validator,
          builder: (FormFieldState<String> state) {
            return Column(
              children: [
                _buildTextField(),
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      state.errorText ?? '',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            );
          },
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
