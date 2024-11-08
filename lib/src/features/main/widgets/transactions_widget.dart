import 'package:bank/src/core/colors/app_colors.dart';
import 'package:bank/src/core/theme/text_theme.dart';
import 'package:flutter/material.dart';

class TransactionsWidget extends StatelessWidget {
  final bool isOut;
  final String number;
  final String name;
  final int money;
  const TransactionsWidget({
    super.key,
    required this.isOut,
    required this.number,
    required this.name,
    required this.money,
  });

  @override
  Widget build(BuildContext context) {
    bool isTrue = true;
    if (money < 0) {
      isTrue = false;
    }
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Container(
        width: double.infinity,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 32,
              height: 60,
              child: isOut
                  ? Image.asset('assets/images/outcome.png',
                      width: 32, height: 32)
                  : Image.asset('assets/images/income.png',
                      width: 32, height: 32),
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyles.simpleText.copyWith(
                      color: AppColors.sectionColor,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  number,
                  style: TextStyles.miniText,
                )
              ],
            ),
            Expanded(child: SizedBox()),
            Text(
              '${isTrue ? '+' : ''} $money',
              style: TextStyles.headerText
                  .copyWith(color: isTrue ? AppColors.buttonColor : Colors.red),
            )
          ],
        ),
      ),
    );
  }
}
