import 'package:bank/src/core/colors/app_colors.dart';
import 'package:bank/src/core/widgets/number_widget.dart';
import 'package:bank/src/features/main/presentation/pages/main_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EveryCheckPage extends StatefulWidget {
  const EveryCheckPage({super.key});

  @override
  State<EveryCheckPage> createState() => _EveryCheckPageState();
}

class _EveryCheckPageState extends State<EveryCheckPage> {
  String output = '';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void delete() {
    setState(() {
      output = output.isNotEmpty ? output.substring(0, output.length - 1) : '';
    });
  }

  Future<void> buttonPressed(String btnText) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    if (user != null) {
      final userKey = await _firestore.collection('users').doc(user.uid).get();
      String otp = userKey['otp'];

      if (output.length == 4) {
        if (output == otp) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const NavPage()),
          );
        } else {
          delete();
        }
      } else {
        setState(() {
          output += btnText;
        });
      }
    }
  }

  Widget buildButtonRow(List<String> buttonLabels) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: buttonLabels.map((label) {
        return GestureDetector(
          onTap: () => label == 'DEL' ? delete() : buttonPressed(label),
          child: label == 'DEL'
              ? Container(
                  alignment: Alignment.center,
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: AppColors.fieldColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(Icons.arrow_back_ios_new),
                )
              : Number(number: int.tryParse(label) ?? 0),
        );
      }).toList(),
    );
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
              Text(
                output,
                style: const TextStyle(fontSize: 48, wordSpacing: 50),
                overflow: TextOverflow.ellipsis,
              ),
              Column(
                children: [
                  const SizedBox(height: 20),
                  buildButtonRow(['7', '8', '9']),
                  const SizedBox(height: 20),
                  buildButtonRow(['4', '5', '6']),
                  const SizedBox(height: 20),
                  buildButtonRow(['1', '2', '3']),
                  const SizedBox(height: 20),
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
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Icon(Icons.arrow_back_ios_new),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => buttonPressed('0'),
                        child: Number(number: 0),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (output.length == 4) {
                            buttonPressed(output);
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: AppColors.fieldColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            'OK',
                            style: TextStyle(
                              color: AppColors.notBlack,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
