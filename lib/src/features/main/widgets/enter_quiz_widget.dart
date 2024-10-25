import 'package:flutter/material.dart';
import 'package:gradus/src/core/colors/app_colors.dart';
import 'package:gradus/src/core/theme/text_theme.dart';

class EnterQuizWidget extends StatelessWidget {
  final String bookName;
  final int round;
  final int questions;
  final String image;
  const EnterQuizWidget(
      {super.key,
      required this.image,
      required this.bookName,
      required this.round,
      required this.questions});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
          color: AppColors.notBlack, borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: AssetImage(image), fit: BoxFit.cover)),
            ),
            SizedBox(
              width: 18,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  bookName,
                  style: TextStyles.headerText,
                ),
                Text(
                  '$round round · $questions question',
                  style: TextStyles.miniText,
                )
              ],
            ),
            Expanded(child: SizedBox()),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.buttonColor,
            )
          ],
        ),
      ),
    );
  }
}
