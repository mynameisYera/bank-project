import 'package:bank/src/core/colors/app_colors.dart';
import 'package:bank/src/core/widgets/custom_appbar.dart';
import 'package:bank/src/core/widgets/custom_button.dart';
import 'package:bank/src/core/widgets/custom_text_field.dart';
import 'package:bank/src/features/main/presentation/pages/success_page.dart';
import 'package:bank/src/features/main/widgets/card_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CommunalPage extends StatefulWidget {
  CommunalPage({super.key});

  @override
  State<CommunalPage> createState() => _CommunalPageState();
}

class _CommunalPageState extends State<CommunalPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();

  Map<String, dynamic>? userData;
  List<dynamic> transactions = [];
  final int fixedExpenseAmount = 200;

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
        transactions = userData?['transactions'] ?? [];
      });
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Pay for Utilities',
        backgroundColor: AppColors.mainColor,
        popAble: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              CardWidget(
                money: userData?['money'] ?? 0,
                name: userData?['username'] ?? 'User',
                number: userData?['phoneNumber'] ?? '0000',
              ),
              SizedBox(height: 40),
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
              SizedBox(height: 20),
              CustomButton(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    int amount = int.parse(_amountController.text);
                    _makeUtilityPayment(context, amount);
                  }
                },
                btnText: 'Pay Now',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _makeUtilityPayment(BuildContext context, int amount) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        _showErrorDialog(context, 'User not authenticated');
        return;
      }

      final userUid = user.uid;
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userUid)
          .get();

      if (!userDoc.exists) {
        _showErrorDialog(context, 'Sender not found');
        return;
      }

      final senderPhone = userDoc['phoneNumber'];
      final senderBalance = userDoc['money'];

      if (senderBalance < amount) {
        _showErrorDialog(context, 'Insufficient balance.');
        return;
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userDoc.id)
          .update({
        'money': senderBalance - amount,
        'transactions': FieldValue.arrayUnion([
          {'to': 'utilities', 'money': -amount, 'date': Timestamp.now()}
        ]),
      });

      await FirebaseFirestore.instance.collection('utilities').doc('main').set({
        'money': FieldValue.increment(amount),
        'transactions': FieldValue.arrayUnion([
          {'from': senderPhone, 'money': amount, 'date': Timestamp.now()}
        ]),
      }, SetOptions(merge: true));

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SuccessPage()));
    } catch (e) {
      _showErrorDialog(context, 'An error occurred: ${e.toString()}');
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Success'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<Map<String, dynamic>?> getUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print('User is not authenticated');
        return null;
      }

      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      return userDoc.exists ? userDoc.data() as Map<String, dynamic>? : null;
    } catch (e) {
      print('Error retrieving user data: $e');
      return null;
    }
  }
}
