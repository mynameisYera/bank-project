import 'package:flutter/material.dart';
import 'package:bank/src/core/colors/app_colors.dart';
import 'package:bank/src/core/theme/text_theme.dart';

class CurrentBookWidget extends StatelessWidget {
  final String image;
  final String bookName;
  final int page;
  const CurrentBookWidget(
      {super.key,
      required this.image,
      required this.bookName,
      required this.page});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 77,
      decoration: BoxDecoration(
        color: AppColors.blueColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Container(
            width: 77,
            height: 77,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                image: DecorationImage(
                    image: NetworkImage(image), fit: BoxFit.cover)),
          ),
          SizedBox(
            width: 15,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                bookName,
                style: TextStyles.headerText,
              ),
              Text(
                '$page pages',
                style: TextStyles.miniText.copyWith(color: Colors.white),
              )
            ],
          )
        ],
      ),
    );
  }
}
