import 'package:bank/src/core/colors/app_colors.dart';
import 'package:bank/src/core/theme/text_theme.dart';
import 'package:bank/src/core/widgets/custom_appbar.dart';
import 'package:bank/src/features/qr/presentation/qr_not_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TransferPage extends StatelessWidget {
  const TransferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: 'Transfer',
          backgroundColor: Colors.transparent,
          popAble: true),
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
                                builder: (context) => QrNotPage()));
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
            onTap: () {},
            child: ListTile(
              leading: Container(
                  width: 50,
                  height: 50,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.fieldColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: SvgPicture.asset(
                    'assets/icons/arrow.svg',
                    color: AppColors.buttonColor,
                  )),
              title: Text(
                'My Transfers',
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
                  Icons.person_3_outlined,
                  color: AppColors.buttonColor,
                ),
              ),
              title: Text(
                'To Someone',
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
                  Icons.qr_code_scanner,
                  color: AppColors.buttonColor,
                ),
              ),
              title: Text(
                'QR',
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
