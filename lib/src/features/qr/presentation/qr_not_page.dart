import 'package:bank/src/core/colors/app_colors.dart';
import 'package:bank/src/core/widgets/custom_appbar.dart';
import 'package:bank/src/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrNotPage extends StatefulWidget {
  const QrNotPage({super.key});

  @override
  State<QrNotPage> createState() => _QrNotPageState();
}

class _QrNotPageState extends State<QrNotPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.mainColor,
        appBar: CustomAppBar(
            title: 'QR', backgroundColor: AppColors.mainColor, popAble: true),
        body: MobileScanner(
          controller: MobileScannerController(
              detectionSpeed: DetectionSpeed.noDuplicates),
          onDetect: (capture) {
            final List<Barcode> barcodes = capture.barcodes;
            bool isDialogShown = false;

            if (!isDialogShown && barcodes.isNotEmpty) {
              isDialogShown = true;
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    actions: [
                      SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                          onTap: () {
                            setState(() {
                              isDialogShown = false;
                            });
                            Navigator.of(context).pop();
                          },
                          btnText: 'Pay'),
                    ],
                  );
                },
              );
            }
          },
        ));
  }
}
