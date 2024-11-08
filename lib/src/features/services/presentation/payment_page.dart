import 'package:bank/src/core/colors/app_colors.dart';
import 'package:bank/src/core/theme/text_theme.dart';
import 'package:bank/src/core/widgets/custom_appbar.dart';
import 'package:bank/src/features/main/presentation/pages/profile_page.dart';
import 'package:bank/src/features/qr/presentation/qr_not_page.dart';
import 'package:bank/src/features/services/presentation/communal_page.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: 'Payment', backgroundColor: Colors.transparent, popAble: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
            child: Container(
              width: MediaQuery.of(context).size.width - 30,
              height: 35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.fieldColor),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.5),
                child: Row(
                  children: [
                    Container(
                      color: Colors.white,
                      height: 30,
                      width: (MediaQuery.of(context).size.width - 40) / 2,
                      child: Center(child: Text('My Transfers')),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage()));
                      },
                      child: Container(
                        color: Colors.transparent,
                        height: 30,
                        width: (MediaQuery.of(context).size.width - 40) / 2,
                        child: Center(child: Text('History')),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CommunalPage()));
            },
            child: ListTile(
              leading: Container(
                width: 50,
                height: 50,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.fieldColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(
                  Icons.home_outlined,
                  color: AppColors.buttonColor,
                ),
              ),
              title: Text(
                'Communal apartment',
                style: TextStyles.headerText
                    .copyWith(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 10,
                color: AppColors.fieldColor,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {},
            child: ListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.fieldColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(
                  Icons.phone_android_outlined,
                  color: AppColors.buttonColor,
                ),
              ),
              title: Text(
                'Mobile',
                style: TextStyles.headerText
                    .copyWith(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: AppColors.fieldColor,
              ),
            ),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => QrNotPage()));
            },
            child: ListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.fieldColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(
                  Icons.phone_android_outlined,
                  color: AppColors.buttonColor,
                ),
              ),
              title: Text(
                'Internet services',
                style: TextStyles.headerText
                    .copyWith(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: AppColors.fieldColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
