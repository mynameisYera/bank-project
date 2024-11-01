import 'package:flutter/material.dart';
import 'package:bank/src/core/colors/app_colors.dart';
import 'package:bank/src/core/theme/text_theme.dart';

class QuizQuestionWidget extends StatelessWidget {
  const QuizQuestionWidget(
      {super.key, required this.onAnswerChanged, required this.question});
  final ValueChanged<String> onAnswerChanged;

  final String question;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(question, style: TextStyles.headerText),
            const SizedBox(height: 10),
            TextField(
              style: TextStyles.simpleText,
              onChanged: onAnswerChanged,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.mainColor,
                  hintText: 'Text',
                  hintStyle: TextStyles.miniText,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white))),
            ),
          ],
        ),
      ),
    );
  }
}
