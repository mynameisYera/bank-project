import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradus/src/core/colors/app_colors.dart';
import 'package:gradus/src/core/theme/text_theme.dart';
import 'package:gradus/src/core/widgets/custom_appbar.dart';
import 'package:gradus/src/core/widgets/custom_button.dart';
import 'package:gradus/src/core/widgets/custom_button_grey.dart';
import 'package:gradus/src/core/widgets/custom_text_field.dart';
import 'package:gradus/src/features/main/presentation/pages/main_page.dart';
import 'package:gradus/src/features/unauth/domain/firebase_auth_services.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuthServices _auth = FirebaseAuthServices();
  // conrollers
  final TextEditingController _cardController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _cardController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // name of the team
                  Text('Card Number', style: TextStyles.headerText),
                  const SizedBox(height: 5),
                  CustomTextField(
                    controller: _cardController,
                    hintText: '4400 0000 0000 0000',
                    obscure: false,
                  ),
                  const SizedBox(height: 5),
                  Text('Make sure it matches with your real card number.',
                      style: TextStyles.miniText),
                  const SizedBox(height: 10),

                  // phone number
                  Text('Phone Number', style: TextStyles.headerText),
                  const SizedBox(height: 5),
                  CustomTextField(
                    controller: _phoneController,
                    hintText: '+7 (999) 999 99 99',
                    obscure: false,
                  ),
                  const SizedBox(height: 10),

                  // Email
                  Text('Email', style: TextStyles.headerText),
                  const SizedBox(height: 5),
                  CustomTextField(
                      controller: _emailController,
                      hintText: 'Email',
                      obscure: false),
                  const SizedBox(height: 5),
                  Text(
                    "We'll email you to trip confirmations and recepits.",
                    style: TextStyles.miniText,
                  ),
                  const SizedBox(height: 10),

                  //  Password
                  Text('Password', style: TextStyles.headerText),
                  const SizedBox(height: 5),
                  CustomTextField(
                    controller: _passwordController,
                    hintText: 'Password',
                    obscure: true,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Password strength: strong \nCan't contain your name or email address \nAt least 8 characters \nContaines a number or symbol",
                    style: TextStyles.miniText,
                  ),
                  const SizedBox(height: 10),
                ],
              ),

              //
              CustomButton(
                onTap: () {},
                btnText: 'Register',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signUp() async {
    String password = _passwordController.text;
    String emailAddress = _emailController.text;
    String cardNumber = _cardController.text;
    String phoneNumber = _phoneController.text;

    User? user = await _auth.signUpWithEmailAndPassword(
        emailAddress, password, cardNumber, phoneNumber);

    if (user != null) {
      print('signed in');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NavPage()));
    }
  }
}
