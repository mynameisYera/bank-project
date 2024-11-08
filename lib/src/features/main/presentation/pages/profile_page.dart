import 'package:bank/src/core/colors/app_colors.dart';
import 'package:bank/src/core/theme/text_theme.dart';
import 'package:bank/src/core/widgets/custom_appbar.dart';
import 'package:bank/src/features/main/widgets/transactions_widget.dart';
import 'package:bank/src/features/unauth/presentation/log_in_page.dart';
import 'package:bank/src/features/unauth/presentation/put_every_pass_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
              title: 'Profile',
              backgroundColor: AppColors.buttonColor,
              color: Colors.white,
              iconColor: Colors.white,
              actions: [
                IconButton(
                  icon: Icon(Icons.logout),
                  color: AppColors.mainColor,
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LogInPage()));
                    } catch (e) {
                      print('Error logging out: $e');
                    }
                  },
                )
              ],
              popAble: true,
            ),
            body: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 90,
                      color: AppColors.buttonColor,
                    ),
                    Positioned(
                        bottom: -45,
                        left: MediaQuery.of(context).size.width / 2 - 45,
                        child: CircleAvatar(
                          radius: 45,
                          backgroundImage:
                              AssetImage('assets/images/profile.jpg'),
                        )),
                    Container(
                      width: double.infinity,
                      height: 50,
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  _username,
                  style: TextStyles.headerText,
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PutEveryPassPage()));
                  },
                  title: Text(
                    'Change access code',
                    style: TextStyles.tileText.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                Divider(),
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
