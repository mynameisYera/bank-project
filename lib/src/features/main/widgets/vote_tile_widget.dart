import 'package:flutter/material.dart';
import 'package:bank/src/core/colors/app_colors.dart';
import 'package:bank/src/core/theme/text_theme.dart';

class VoteTileWidget extends StatefulWidget {
  final String bookName;
  final bool isSelected;
  final int page;
  final int vote;
  final VoidCallback onTap;
  const VoteTileWidget(
      {super.key,
      required this.bookName,
      required this.page,
      required this.vote,
      required this.onTap,
      this.isSelected = false});

  @override
  State<VoteTileWidget> createState() => _VoteTileWidgetState();
}

class _VoteTileWidgetState extends State<VoteTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          width: double.infinity,
          height: 77,
          decoration: BoxDecoration(
              border: Border.all(
                  color: widget.isSelected
                      ? AppColors.buttonColor
                      : Colors.transparent,
                  width: 1),
              color: AppColors.notBlack,
              borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.bookName,
                      style: TextStyles.headerText,
                    ),
                    Text(
                      '${widget.vote} vote',
                      style:
                          TextStyles.simpleText.copyWith(color: Colors.white),
                    )
                  ],
                ),
                Text(
                  '${widget.page} pages',
                  style: TextStyles.miniText.copyWith(color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
