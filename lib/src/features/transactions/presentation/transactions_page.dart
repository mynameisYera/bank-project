import 'package:bank/src/core/colors/app_colors.dart';
import 'package:bank/src/core/theme/text_theme.dart';
import 'package:bank/src/core/widgets/custom_appbar.dart';
import 'package:bank/src/features/main/widgets/transactions_widget.dart';
import 'package:bank/src/features/unauth/presentation/log_in_page.dart';
import 'package:bank/src/features/unauth/presentation/put_every_pass_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  _TransactionsPageState createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  String _username = "Loading...";
  List<dynamic> _transactions = [];

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentReference userRef =
          FirebaseFirestore.instance.collection('users').doc(user.uid);

      try {
        DocumentSnapshot snapshot = await userRef.get();

        if (snapshot.exists) {
          var userData = snapshot.data() as Map<String, dynamic>;
          setState(() {
            _username = userData['username'];
            _transactions = userData['transactions'] ?? [];
          });
        } else {
          setState(() {
            _username = "User document not found.";
          });
        }
      } catch (e) {
        setState(() {
          _username = "Error fetching user data.";
        });
        print('Error fetching user data: $e');
      }
    } else {
      setState(() {
        _username = "No user is signed in.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return user == null
        ? Scaffold(
            body: Center(child: CircularProgressIndicator()),
          )
        : Scaffold(
            appBar: CustomAppBar(
              title: 'Transactions',
              backgroundColor: AppColors.buttonColor,
              color: Colors.white,
              iconColor: Colors.white,
              popAble: false,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _transactions.length,
                    itemBuilder: (context, index) {
                      final transaction = _transactions[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: TransactionsWidget(
                          name: transaction['to'] ?? 'Unknown',
                          isOut: transaction['money'] < 0,
                          number: transaction['to'] ?? 'Unknown',
                          money: transaction['money'] ?? 0,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
