import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradus/src/core/colors/app_colors.dart';
import 'package:gradus/src/core/theme/text_theme.dart';
import 'package:gradus/src/core/widgets/custom_appbar.dart';
import 'package:gradus/src/core/widgets/custom_button.dart';
import 'package:gradus/src/core/widgets/custom_button_grey.dart';
import 'package:gradus/src/core/widgets/custom_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // conrollers
  final TextEditingController _teamController = TextEditingController();
  final TextEditingController _firstPersonController = TextEditingController();
  final TextEditingController _secondPersonController = TextEditingController();
  final TextEditingController _thirdPersonController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _teamController.dispose();
    _firstPersonController.dispose();
    _secondPersonController.dispose();
    _thirdPersonController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: const CustomAppbar(title: 'Finish signing up', leadingIcon: true),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // name of the team
                Text('Name of the Team', style: TextStyles.headerText),
                const SizedBox(height: 5),
                CustomTextField(
                  controller: _teamController,
                  hintText: 'F troishniki',
                  obscure: false,
                ),
                const SizedBox(height: 5),
                Text('Make sure it matches the name from previous games.',
                    style: TextStyles.miniText),
                const SizedBox(height: 10),

                // name of competitors
                Text('Name of', style: TextStyles.headerText),
                const SizedBox(height: 5),
                CustomTextField(
                    controller: _firstPersonController,
                    hintText: 'First person',
                    obscure: false),
                const SizedBox(height: 7),
                CustomTextField(
                    controller: _secondPersonController,
                    hintText: 'Second person',
                    obscure: false),
                const SizedBox(height: 7),
                CustomTextField(
                    controller: _thirdPersonController,
                    hintText: 'Third person',
                    obscure: false),
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

                // button
                CustomButtonGrey(
                  onTap: () {},
                  btnText: 'Pay',
                  icon: SizedBox(
                    height: 20,
                    width: 20,
                    child: SvgPicture.asset(
                      'assets/icons/google_icon.svg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 5),

                RichText(
                  text: TextSpan(
                      text: "By selecting ",
                      style: TextStyles.miniText,
                      children: [
                        TextSpan(
                          text: "Agree and Continue ",
                          style: TextStyles.boldMiniText,
                        ),
                        TextSpan(
                            text: "below, I agree to 451's ",
                            style: TextStyles.miniText),
                        TextSpan(
                            text: "Terms of Service,",
                            style: TextStyles.underlineText),
                        const TextSpan(text: " "),
                        TextSpan(
                            text: "Payments Terms of Service",
                            style: TextStyles.underlineText),
                        const TextSpan(text: " "),
                        TextSpan(
                            text: "Privacy Policy",
                            style: TextStyles.underlineText),
                        const TextSpan(text: " and "),
                        TextSpan(
                            text: "Nondiscrimination Policy.",
                            style: TextStyles.underlineText),
                      ]),
                ),
                const SizedBox(height: 10),

                // button
                CustomButton(onTap: () {}, btnText: "Agree to continue")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
