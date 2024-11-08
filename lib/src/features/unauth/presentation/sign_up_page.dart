import 'package:bank/src/features/unauth/presentation/put_every_pass_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:bank/src/core/theme/text_theme.dart';

import 'package:bank/src/core/widgets/custom_button.dart';

import 'package:bank/src/core/widgets/custom_text_field.dart';

import 'package:bank/src/features/unauth/domain/firebase_auth_services.dart';

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
  final TextEditingController _usernameController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
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
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please write your card number';
                          } else if (value.length != 16) {
                            return 'please write your valid card number';
                          }
                          return null;
                        },
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
                      Text('Name', style: TextStyles.headerText),
                      const SizedBox(height: 5),
                      CustomTextField(
                        controller: _usernameController,
                        hintText: 'Vasiya Pupkin',
                        obscure: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please write your name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 5),

                      // Email
                      Text('Email', style: TextStyles.headerText),
                      const SizedBox(height: 5),
                      CustomTextField(
                        controller: _emailController,
                        hintText: 'Email',
                        obscure: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                          final regex = RegExp(
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                          if (!regex.hasMatch(value)) {
                            return 'Enter a valid email address';
                          }

                          return null;
                        },
                      ),

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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          }
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters long';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Password strength: strong \nCan't contain your name or email address \nAt least 8 characters \nContaines a number or symbol",
                        style: TextStyles.miniText,
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                  CustomButton(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _signUp();
                      }
                    },
                    btnText: 'Register',
                  ),
                ],
              ),
            ),
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
    String usernameNumber = _usernameController.text;

    User? user = await _auth.signUpWithEmailAndPassword(
        emailAddress, password, cardNumber, phoneNumber, usernameNumber);

    if (user != null) {
      print('signed in');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PutEveryPassPage()));
    }
  }
}
