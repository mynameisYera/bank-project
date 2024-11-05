import 'package:flutter/material.dart';
import 'package:bank/src/core/colors/app_colors.dart';
import 'package:bank/src/core/theme/text_theme.dart';

class NewsWidget extends StatelessWidget {
  final List<String> url;
  final String description;

  const NewsWidget({super.key, required this.url, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(width: 1, color: AppColors.notBlack),
                      image: DecorationImage(
                          image: AssetImage('assets/images/logo.png'),
                          fit: BoxFit.cover)),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '451.bank.official',
                      style: TextStyles.headerText.copyWith(fontSize: 20),
                    ),
                    Text(
                      'Suggested for you',
                      style: TextStyles.miniText,
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              description,
              style: TextStyles.simpleText,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              'Alisher Zhunissov',
              style: TextStyles.miniText.copyWith(color: AppColors.buttonColor),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Divider(
            color: Colors.white,
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
