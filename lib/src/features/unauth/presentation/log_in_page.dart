import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bank/src/core/colors/app_colors.dart';

import 'package:bank/src/core/widgets/custom_button.dart';
import 'package:bank/src/core/widgets/custom_text_field.dart';
import 'package:bank/src/features/main/presentation/pages/main_page.dart';
import 'package:bank/src/features/unauth/domain/firebase_auth_services.dart';
import 'package:bank/src/features/unauth/presentation/sign_up_page.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Phone number field
                    Text(
                      'Phone number',
                      style: TextStyles.headerText,
                    ),
                    const SizedBox(height: 5),
                    CustomTextField(
                      controller: _teamController,
                      hintText: '+7 (777) 777 77 77',
                      obscure: false,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Phone number is required';
                        }
                        final regex = RegExp(r'^(?:\+7|8)?7\d{9}$');
                        if (!regex.hasMatch(value)) {
                          return 'Enter a valid phone number';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 10),

                    // Password field
                    Text(
                      'Password',
                      style: TextStyles.headerText,
                    ),
                    const SizedBox(height: 5),
                    CustomTextField(
                      controller: _passwordController,
                      hintText: 'Password',
                      obscure: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required line';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Forgot your password?',
                      style: TextStyles.miniText,
                    ),
                    const SizedBox(height: 20),

                    // Continue button
                    CustomButton(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _signIn();
                        }
                      },
                      btnText: 'Continue',
                    ),
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
                                builder: (context) => SignUpPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Registration',
                            style: TextStyles.underlineText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
    if (user != null) {
      print('signed in');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NavPage()),
      );
    } else {
      print("Sign-in failed");
    }
  }
}
