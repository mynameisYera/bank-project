import 'package:bank/src/core/colors/app_colors.dart';
import 'package:flutter/material.dart';

class Number extends StatelessWidget {
  const Number({super.key, required this.number});

  final int number;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 70,
      height: 70,
      decoration: BoxDecoration(
          color: AppColors.fieldColor, borderRadius: BorderRadius.circular(50)),
      child: Text(
        '$number',
        style: const TextStyle(color: AppColors.notBlack, fontSize: 32),
      ),
    );
  }
}
