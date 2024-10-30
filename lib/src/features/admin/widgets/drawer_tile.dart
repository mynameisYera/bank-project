import 'package:flutter/material.dart';
import 'package:gradus/src/core/colors/app_colors.dart';
import 'package:gradus/src/core/theme/text_theme.dart';

class DrawerTile extends StatelessWidget {
  final bool isCurrent;
  final String text;
  final Widget icon;
  final VoidCallback onTap;
  const DrawerTile(
      {super.key,
      required this.isCurrent,
      required this.onTap,
      required this.text,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color:
                      isCurrent ? AppColors.buttonColor : Colors.transparent),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    icon,
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      text,
                      style: TextStyles.simpleText,
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
