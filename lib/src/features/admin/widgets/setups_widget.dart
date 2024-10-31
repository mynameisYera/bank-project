import 'package:flutter/material.dart';
import 'package:gradus/src/core/colors/app_colors.dart';
import 'package:gradus/src/core/theme/text_theme.dart';

class SetupsWidget extends StatelessWidget {
  final String title;
  final String text;
  final VoidCallback onTap;
  const SetupsWidget(
      {super.key,
      required this.title,
      required this.onTap,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Column(
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
              width: double.infinity,
              height: 77,
              decoration: BoxDecoration(
                  color: AppColors.notBlack,
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      text,
                      style: TextStyles.headerText,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 18,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ));
  }
}
