import 'package:bank/src/core/theme/text_theme.dart';
import 'package:flutter/material.dart';

class FinanceWidget extends StatelessWidget {
  final Widget widget;
  final String name;
  final Color color;
  final VoidCallback onTap;
  const FinanceWidget(
      {super.key,
      required this.widget,
      required this.name,
      required this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(right: 0),
        child: Container(
          padding: EdgeInsets.all(16),
          width: 100,
          height: 100,
          decoration: BoxDecoration(
              color: Color(0xffDBDBDB),
              borderRadius: BorderRadius.circular(26)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.all(7),
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), color: color),
                  child: widget),
              Text(
                name,
                style: TextStyles.miniText.copyWith(color: Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }
}
