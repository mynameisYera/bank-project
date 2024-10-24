import 'package:flutter/material.dart';

import '../theme/text_theme.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key,
    required this.title,
    required this.leadingIcon,
  });
  final String title;
  final bool leadingIcon;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leadingIcon
          ? IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.white,
              ))
          : null,
      backgroundColor: Colors.transparent,
      title: Text(
        "Log in or sign Up",
        style: TextStyles.headerText,
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 60);
}
