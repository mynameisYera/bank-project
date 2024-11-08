import 'package:bank/src/core/theme/text_theme.dart';
import 'package:bank/src/features/coins/crypto_list/views/crypto_list_screen.dart';
import 'package:bank/src/features/main/widgets/card_widget.dart';
import 'package:bank/src/features/main/widgets/finance_widget.dart';
import 'package:bank/src/features/main/widgets/transactions_widget.dart';
import 'package:bank/src/features/qr/presentation/qr_code_page.dart';
import 'package:bank/src/features/services/presentation/payment_page.dart';
import 'package:bank/src/features/services/presentation/services_page.dart';
import 'package:bank/src/features/services/presentation/transfer_page.dart';
import 'package:bank/src/features/transactions/presentation/transactions_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:bank/src/core/colors/app_colors.dart';
import 'package:flutter_svg/svg.dart';

class NavPage extends StatefulWidget {
  const NavPage({super.key});

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    const QrCodePage(),
    TransactionsPage(),
    const ServicesPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.mainColor,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.buttonColor,
        unselectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
              icon: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Icon(
                    Icons.home,
                    size: 20,
                  ),
                ],
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Icon(
                    Icons.qr_code_scanner,
                    size: 20,
                  ),
                ],
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Icon(
                    Icons.chat,
                    size: 20,
                  ),
                ],
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Icon(
                    Icons.menu,
                    size: 20,
                  ),
                ],
              ),
              label: ''),
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        transactions = userData?['transactions'] ?? [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> finance = [
      {
        "color": Color(0xffF2FE8D),
        "text": 'Transfer',
        "icon": SvgPicture.asset('assets/icons/arrow.svg'),
        "onTap": () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => TransferPage())),
      },
      {
        "color": Color(0xffB2D0CE),
        "text": 'Budget',
        "icon": SvgPicture.asset('assets/icons/wallet.svg'),
        "onTap": () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => TransferPage())),
      },
      {
        "color": Color(0xffAA9EB7),
        "text": 'Invest',
        "icon": SvgPicture.asset('assets/icons/statistic.svg'),
        "onTap": () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => CryptoListScreen())),
      },
      {
        "color": Color(0xffF2FE8D),
        "text": 'Bonuses',
        "icon": SvgPicture.asset('assets/icons/bonus.svg'),
        "onTap": () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => TransferPage())),
      },
      {
        "color": Color(0xffF2FE8D),
        "text": 'Payments',
        "icon": SvgPicture.asset('assets/icons/payment.svg'),
        "onTap": () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => PaymentPage())),
      },
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Your balance',
                      style: TextStyle(
                          color: AppColors.sectionColor,
                          fontWeight: FontWeight.w400),
                    ),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                          color: AppColors.fieldColor,
                          borderRadius: BorderRadius.circular(40)),
                      child: Center(
                        child: Icon(Icons.search),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                CardWidget(
                  money: userData?['money'] ?? 0,
                  name: userData?['username'] ?? 'User',
                  number: userData?['phoneNumber'] ?? '0000',
                ),
                SizedBox(height: 45),
                Text(
                  'Finance',
                  style: TextStyle(
                      color: AppColors.sectionColor,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: finance.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            FinanceWidget(
                                onTap: finance[index]['onTap'],
                                color: finance[index]['color'],
                                widget: finance[index]['icon'],
                                name: finance[index]['text']),
                            SizedBox(width: 14)
                          ],
                        );
                      }),
                ),
                SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  height: 500,
                  decoration: BoxDecoration(
                      color: Color(0xffDBDBDB),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(26),
                          topRight: Radius.circular(26))),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Transactions',
                          style: TextStyle(
                              color: AppColors.sectionColor,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 20),
                        Expanded(
                          child: ListView.builder(
                            itemCount: transactions.length,
                            itemBuilder: (context, index) {
                              final transaction = transactions[index];
                              return TransactionsWidget(
                                name: transaction['to'] ?? 'Unknown',
                                isOut: transaction['money'] < 0,
                                number: transaction['to'] ?? 'Unknown',
                                money: transaction['money'] ?? 0,
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )),
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
}
