import 'package:bank/src/core/theme/text_theme.dart';
import 'package:bank/src/features/main/widgets/card_widget.dart';
import 'package:bank/src/features/main/widgets/finance_widget.dart';
import 'package:bank/src/features/main/widgets/transactions_widget.dart';
import 'package:bank/src/features/qr/presentation/qr_code_page.dart';
import 'package:bank/src/features/services/presentation/payment_page.dart';
import 'package:bank/src/features/services/presentation/services_page.dart';
import 'package:bank/src/features/services/presentation/transfer_page.dart';
import 'package:bank/src/features/transactions/presentation/transactions_page.dart';

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
    ProfilePage(),
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

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
        "text": 'News',
        "icon": SvgPicture.asset('assets/icons/statistic.svg'),
        "onTap": () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => TransferPage())),
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
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Your balance',
                      style: TextStyles.simpleText.copyWith(
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
                SizedBox(
                  height: 20,
                ),
                CardWidget(
                  money: 12000,
                  name: 'Yernasip Duisebay',
                  number: '6574',
                ),
                SizedBox(
                  height: 45,
                ),
                Text(
                  'Finance',
                  style: TextStyles.simpleText.copyWith(
                      color: AppColors.sectionColor,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 10,
                ),
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
                            SizedBox(
                              width: 14,
                            )
                          ],
                        );
                      }),
                ),
                SizedBox(
                  height: 30,
                ),
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
                          style: TextStyles.simpleText.copyWith(
                              color: AppColors.sectionColor,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: 50,
                            itemBuilder: (context, index) {
                              return TransactionsWidget(
                                name: '',
                                isOut: false,
                                number: '8-705-744-2222',
                                money: -2300,
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
}
