import 'package:flutter/widgets.dart';
import 'package:gradus/src/core/colors/app_colors.dart';
import 'package:gradus/src/core/theme/text_theme.dart';

class MessageTileWidget extends StatelessWidget {
  final String username;
  final String message;
  const MessageTileWidget(
      {super.key, required this.username, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColors.notBlack,
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: TextStyles.headerText
                      .copyWith(color: AppColors.buttonColor),
                ),
                Text(
                  message,
                  style: TextStyles.simpleText,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
