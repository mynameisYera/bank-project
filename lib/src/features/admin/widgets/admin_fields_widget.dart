import 'package:flutter/material.dart';
import 'package:gradus/src/core/colors/app_colors.dart';
import 'package:gradus/src/core/theme/text_theme.dart';

class AdminFieldsWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String hint;
  final TextInputType? keyboard;
  final String title;

  const AdminFieldsWidget(
      {super.key,
      required this.hint,
      required this.title,
      this.controller,
      this.validator,
      this.keyboard});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.headerText,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColors.notBlack,
              borderRadius: BorderRadius.circular(5)),
          child: Form(
            child: TextFormField(
              keyboardType: keyboard,
              validator: validator,
              controller: controller,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: false,
                fillColor: AppColors.notBlack,
                hintText: hint,
                suffixIcon: Icon(
                  Icons.compare_arrows_rounded,
                  color: Color(0xffB3B3B3),
                ),
                hintStyle:
                    TextStyles.miniText.copyWith(color: Color(0xffB3B3B3)),
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
