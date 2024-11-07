import 'package:bank/src/core/theme/text_theme.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String name;
  final String number;
  final double money;
  const CardWidget(
      {super.key,
      required this.name,
      required this.number,
      required this.money});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        width: double.infinity,
        height: 215,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          gradient: LinearGradient(
            colors: [
              Color(0xFFF5FFA8),
              Color(0xFFEDFC74),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 50,
                  ),
                  Text(
                    '$money ₸',
                    style: TextStyles.headerText
                        .copyWith(color: Color(0xff272A32), fontSize: 20),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset(
                    'assets/images/card.png',
                    width: 27,
                  ),
                  Text(
                    'valid thru',
                    style: TextStyles.miniText.copyWith(
                        color: Color.fromARGB(255, 127, 128, 129),
                        fontSize: 15),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '•••• •••• •••• $number',
                    style: TextStyles.headerText
                        .copyWith(color: Color(0xff272A32), fontSize: 20),
                  ),
                  Text(
                    '12/26',
                    style: TextStyles.headerText
                        .copyWith(color: Color(0xff272A32), fontSize: 20),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                '$name'.toUpperCase(),
                style: TextStyles.miniText.copyWith(
                  color: Color.fromARGB(255, 191, 191, 191),
                  fontSize: 15,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
