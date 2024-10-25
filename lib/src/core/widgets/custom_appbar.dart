import 'package:flutter/material.dart';
import 'package:gradus/src/core/theme/text_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final List<Widget>? actions;
  final bool popAble;
  const CustomAppBar({
    super.key,
    required this.title,
    required this.backgroundColor,
    this.actions,
    required this.popAble,
  });
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyles.headerText,
      ),
      leading: popAble
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
              iconSize: 16,
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          : const SizedBox(),
      centerTitle: true,
      surfaceTintColor: backgroundColor,
      backgroundColor: backgroundColor,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
