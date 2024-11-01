import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gradus/src/core/colors/app_colors.dart';
import 'package:gradus/src/core/widgets/custom_button.dart';
import 'package:gradus/src/core/widgets/custom_text_field.dart';
import 'package:gradus/src/features/admin/presentation/pages/admin_home.dart';
import 'package:gradus/src/features/main/presentation/pages/main_page.dart';
import 'package:gradus/src/features/unauth/domain/firebase_auth_services.dart';
import 'package:gradus/src/features/unauth/presentation/sign_up_page.dart';

import '../../../core/theme/text_theme.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final FirebaseAuthServices _auth = FirebaseAuthServices();

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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 50,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // name of the team
                  Text(
                    'Phone number',
                    style: TextStyles.headerText,
                  ),
                  const SizedBox(height: 5),
                  CustomTextField(
                    controller: _teamController,
                    hintText: '+7 (999) 999 99 99',
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
                  CustomButton(onTap: _signIn, btnText: 'Continue'),
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
        ),
      ),
    );
  }

  void _signIn() async {
    String password = _passwordController.text;
    String email = _teamController.text;

    User? user = await _auth.signInWithEmail(email, password);
    if (email == 'alisher.zhunissov@gmail.com' && password == '12345678') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AdminHome()));
    }
    if (user != null) {
      print('signed in');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NavPage()));
    } else {
      print("Sign-in failed");
    }
  }
}
