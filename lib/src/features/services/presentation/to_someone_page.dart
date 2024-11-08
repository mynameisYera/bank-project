import 'package:bank/src/core/colors/app_colors.dart';
import 'package:bank/src/core/widgets/custom_appbar.dart';
import 'package:bank/src/core/widgets/custom_button.dart';
import 'package:bank/src/core/widgets/custom_text_field.dart';
import 'package:bank/src/features/main/presentation/pages/success_page.dart';
import 'package:bank/src/features/main/widgets/card_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ToSomeonePage extends StatefulWidget {
  ToSomeonePage({super.key});

  @override
  State<ToSomeonePage> createState() => _ToSomeonePageState();
}

class _ToSomeonePageState extends State<ToSomeonePage> {
  Map<String, dynamic>? userData;
  List<dynamic> transactions = [];

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final data = await getUserData();
    if (data != null) {
      setState(() {
        userData = data;
        transactions = userData?['transactions'] ?? []; // Fetch transactions
      });
    }
  }

  Future<Map<String, dynamic>?> getUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print('User is not authenticated');
        return null;
      }

      final userUid = user.uid;
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userUid)
          .get();

      if (userDoc.exists) {
        return userDoc.data() as Map<String, dynamic>?;
      } else {
        print('User document does not exist in Firestore');
        return null;
      }
    } catch (e) {
      print('Error retrieving user data: $e');
      return null;
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'To Someone',
        backgroundColor: AppColors.mainColor,
        popAble: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
            child: Column(
              children: [
                CardWidget(
                  money: userData?['money'] ?? 0,
                  name: userData?['username'] ?? 'User',
                  number: userData?['phoneNumber'] ?? '0000',
                ),
                SizedBox(
                  height: 40,
                ),
                CustomTextField(
                  controller: _phoneController,
                  hintText: '+7 705 740 2142',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone number is required';
                    } else if (value == userData?['phoneNumber']) {
                      return 'Its your number';
                    }
                    final regex = RegExp(r'^(?:\+7|8)?7\d{9}$');
                    if (!regex.hasMatch(value)) {
                      return 'Enter a valid phone number';
                    }
                    return null;
                  },
                  obscure: false,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: _amountController,
                  hintText: 'Amount',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Amount is required';
                    }
                    int? amount = int.tryParse(value);
                    if (amount == null || amount < 100) {
                      return 'Minimum amount is 100';
                    }
                    return null;
                  },
                  obscure: false,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      int amount = int.parse(_amountController.text);
                      makeTransaction(context, _phoneController.text, amount);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SuccessPage()));
                    }
                  },
                  btnText: 'Send',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> makeTransaction(
      BuildContext context, String recipientPhone, int amount) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        showErrorDialog(context, 'User not authenticated');
        return;
      }

      final userUid = user.uid;
      final currentUserDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userUid)
          .get();

      if (!currentUserDoc.exists) {
        showErrorDialog(context, 'Sender not found');
        return;
      }

      final senderPhone = currentUserDoc['phoneNumber'];
      final senderBalance = currentUserDoc['money'];

      final recipientDoc = await FirebaseFirestore.instance
          .collection('users')
          .where('phoneNumber', isEqualTo: recipientPhone)
          .limit(1)
          .get();

      if (recipientDoc.docs.isEmpty) {
        showErrorDialog(
            context, 'Recipient with this phone number does not exist.');
        return;
      }

      final recipientData = recipientDoc.docs.first;
      int recipientBalance = recipientData['money'];

      if (senderBalance < amount) {
        showErrorDialog(context, 'Insufficient balance.');
        return;
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserDoc.id)
          .update({
        'money': senderBalance - amount,
        'transactions': FieldValue.arrayUnion([
          {'to': recipientPhone, 'money': -amount}
        ]),
      });

      await FirebaseFirestore.instance
          .collection('users')
          .doc(recipientData.id)
          .update({
        'money': recipientBalance + amount,
        'transactions': FieldValue.arrayUnion([
          {'from': senderPhone, 'money': amount}
        ]),
      });
    } catch (e) {
      showErrorDialog(context, 'An error occurred: ${e.toString()}');
    }
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.buttonColor,
        title: Text('Money sended succesfully'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
