import 'package:bank/src/core/colors/app_colors.dart';
import 'package:bank/src/core/widgets/number_widget.dart';
import 'package:bank/src/features/main/presentation/pages/main_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PutEveryPassPage extends StatefulWidget {
  const PutEveryPassPage({super.key});

  @override
  State<PutEveryPassPage> createState() => _PutEveryPassPageState();
}

class _PutEveryPassPageState extends State<PutEveryPassPage> {
  // calculator stuff
  String output = '';
  int num1 = 0;
  int num2 = 0;
  String operand = "";
  void delete() {
    if (output.isNotEmpty) {
      setState(() {
        output = output.substring(0, output.length - 1);
      });
    } else {
      output = '';
    }
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void sendCode(String code) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    await _firestore.collection('users').doc(user?.uid).update({'otp': code});
  }

  void buttonPressed(String btnText) {
    if (output.length == 4) {
      sendCode(output);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NavPage()));
    } else {
      setState(() {
        output = output + btnText;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.mainColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      output,
                      style: const TextStyle(fontSize: 48),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),

                    // 7 8 9 -
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () => buttonPressed('7'),
                            child: Number(number: 7)),
                        GestureDetector(
                            onTap: () => buttonPressed('8'),
                            child: Number(number: 8)),
                        GestureDetector(
                            onTap: () => buttonPressed('9'),
                            child: Number(number: 9)),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // 4 5 6
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () => buttonPressed('4'),
                            child: Number(number: 4)),
                        GestureDetector(
                            onTap: () => buttonPressed('5'),
                            child: Number(number: 5)),
                        GestureDetector(
                            onTap: () => buttonPressed('6'),
                            child: Number(number: 6)),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // 1 2 3
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () => buttonPressed('1'),
                            child: Number(number: 1)),
                        GestureDetector(
                            onTap: () => buttonPressed('2'),
                            child: Number(number: 2)),
                        GestureDetector(
                            onTap: () => buttonPressed('3'),
                            child: Number(number: 3)),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    // 0 . =
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () => delete(),
                            child: Container(
                                alignment: Alignment.center,
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                    color: AppColors.fieldColor,
                                    borderRadius: BorderRadius.circular(50)),
                                child: Icon(Icons.arrow_back_ios_new))),
                        GestureDetector(
                            onTap: () => buttonPressed('0'),
                            child: Number(number: 0)),
                        GestureDetector(
                            onTap: () => buttonPressed(''),
                            child: Container(
                                alignment: Alignment.center,
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                    color: AppColors.fieldColor,
                                    borderRadius: BorderRadius.circular(50)),
                                child: Text('OK',
                                    style: TextStyle(
                                        color: AppColors.notBlack,
                                        fontSize: 22)))),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
