import 'package:flutter/material.dart';
import 'package:gradus/src/core/colors/app_colors.dart';
import 'package:gradus/src/core/theme/text_theme.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onTap,
    required this.btnText,
    this.width,
  });
  final Function()? onTap;
  final String btnText;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(
          color: AppColors.buttonColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          btnText,
          style: TextStyles.simpleText,
        ),
      ),
    );
  }
}
