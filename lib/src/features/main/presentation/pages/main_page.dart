import 'package:bank/src/features/qr/presentation/qr_code_page.dart';
import 'package:bank/src/features/services/presentation/services_page.dart';
import 'package:bank/src/features/transactions/presentation/transactions_page.dart';

import 'package:flutter/material.dart';

import 'package:bank/src/core/colors/app_colors.dart';

import 'package:bank/src/core/widgets/custom_appbar.dart';

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
        items: [
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
                    Icons.qr_code,
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
    return Scaffold(
      appBar: const CustomAppBar(
          title: 'Your balance',
          backgroundColor: AppColors.mainColor,
          popAble: false),
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(16.0), child: Container()),
      ),
    );
  }
}
