import 'package:flutter/material.dart';

import '../theme/text_theme.dart';

class CustomButtonGrey extends StatelessWidget {
  const CustomButtonGrey({
    super.key,
    required this.onTap,
    required this.btnText,
    required this.icon,
    this.width,
  });
  final Function()? onTap;
  final String btnText;
  final Widget icon;
  final double? width;

  // it should be changed because icon is not correct
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: double.infinity,
          height: 45,
          decoration: BoxDecoration(
            color: Color(0xff414141),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
                width: 30,
                child: Image.asset(
                  "assets/icons/google_icon.png",
                ),
              ),
              Text(
                btnText,
                style: TextStyles.simpleText,
              )
            ],
          )),
    );
  }
}
