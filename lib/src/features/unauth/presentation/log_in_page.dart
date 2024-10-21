import 'package:flutter/material.dart';
import 'package:gradus/src/core/colors/app_colors.dart';
import 'package:gradus/src/core/widgets/custom_appbar.dart';
import 'package:gradus/src/core/widgets/custom_button.dart';
import 'package:gradus/src/core/widgets/custom_text_field.dart';
import 'package:gradus/src/features/unauth/presentation/sign_up_page.dart';

import '../../../core/theme/text_theme.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final TextEditingController _teamController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _teamController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar:
          const CustomAppbar(title: 'Log in or sign Up', leadingIcon: false),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // name of the team
              Text(
                'Name of the Team',
                style: TextStyles.headerText,
              ),
              const SizedBox(height: 5),
              CustomTextField(
                controller: _teamController,
                hintText: 'F troishniki',
                obscure: false,
              ),
              const SizedBox(height: 10),

              // password
              Text(
                'Password',
                style: TextStyles.headerText,
              ),
              const SizedBox(height: 5),
              CustomTextField(
                controller: _passwordController,
                hintText: 'Password',
                obscure: true,
              ),
              const SizedBox(height: 5),
              Text(
                'Forgot your password?',
                style: TextStyles.miniText,
              ),
              const SizedBox(height: 20),

              // continue button
              CustomButton(onTap: () {}, btnText: 'Continue'),
              const SizedBox(height: 20),

              Row(
                children: [
                  Text(
                    'You are not registered, ',
                    style: TextStyles.miniText,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpPage()));
                    },
                    child: Text(
                      'Regisration',
                      style: TextStyles.underlineText,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
