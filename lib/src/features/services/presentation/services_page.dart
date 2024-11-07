import 'package:bank/src/core/colors/app_colors.dart';
import 'package:bank/src/core/theme/text_theme.dart';
import 'package:bank/src/core/widgets/custom_appbar.dart';
import 'package:bank/src/features/main/widgets/finance_widget.dart';
import 'package:bank/src/features/services/presentation/payment_page.dart';
import 'package:bank/src/features/services/presentation/transfer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
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
      backgroundColor: AppColors.mainColor,
      appBar: const CustomAppBar(
        title: 'Services',
        backgroundColor: AppColors.mainColor,
        popAble: false,
      ),
      body: Column(
        children: [
          Divider(),
          ListTile(
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Icon(
                Icons.person_2,
                color: Colors.white,
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Yernasip',
                  style: TextStyles.headerText,
                ),
                Text(
                  'Settings',
                  style: TextStyles.miniText,
                ),
              ],
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: AppColors.fieldColor,
            ),
          ),
          Divider(),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: 1,
              ),
              itemCount: finance.length,
              itemBuilder: (context, index) {
                return FinanceWidget(
                  onTap: finance[index]['onTap'],
                  color: finance[index]['color'],
                  widget: finance[index]['icon'],
                  name: finance[index]['text'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
