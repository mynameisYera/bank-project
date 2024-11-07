import 'package:bank/src/core/colors/app_colors.dart';
import 'package:bank/src/core/widgets/custom_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrCodePage extends StatefulWidget {
  const QrCodePage({super.key});

  @override
  State<QrCodePage> createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.mainColor,
        appBar: AppBar(
          title: Text("Scan QR Code"),
        ),
        body: MobileScanner(
          controller: MobileScannerController(
              detectionSpeed: DetectionSpeed.noDuplicates),
          onDetect: (capture) {
            final List<Barcode> barcodes = capture.barcodes;
            final Uint8List? image = capture.image;
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
