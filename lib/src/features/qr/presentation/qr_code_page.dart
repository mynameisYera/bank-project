import 'package:bank/src/core/colors/app_colors.dart';
import 'package:bank/src/core/widgets/custom_button.dart';
import 'package:bank/src/features/main/presentation/pages/success_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrCodePage extends StatefulWidget {
  const QrCodePage({super.key});

  @override
  State<QrCodePage> createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
  bool isDialogShown = false;

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
        onDetect: (capture) async {
          final List<Barcode> barcodes = capture.barcodes;
          if (!isDialogShown && barcodes.isNotEmpty) {
            isDialogShown = true;
            String recipientPhoneNumber = 'Qaz Svet';

            if (recipientPhoneNumber.isNotEmpty) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Pay 500'),
                    content: Text('Send 500 to: $recipientPhoneNumber?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                      ),
                      CustomButton(
                        onTap: () {
                          makePayment(context, recipientPhoneNumber, 500);
                        },
                        btnText: 'Pay',
                      ),
                    ],
                  );
                },
              );
            }
          }
        },
      ),
    );
  }

  Future<void> makePayment(
      BuildContext context, String recipientPhoneNumber, int amount) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        showErrorDialog(context, 'User not authenticated');
        return;
      }

      final userUid = user.uid;
      final currentUserDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userUid)
          .get();

      if (!currentUserDoc.exists) {
        showErrorDialog(context, 'Sender not found');
        return;
      }

      final senderPhone = currentUserDoc['phoneNumber'];
      final senderBalance = currentUserDoc['money'];

      if (senderBalance < amount) {
        showErrorDialog(context, 'Insufficient balance.');
        return;
      }

      final recipientDoc = await FirebaseFirestore.instance
          .collection('users')
          .where('phoneNumber', isEqualTo: recipientPhoneNumber)
          .limit(1)
          .get();

      if (recipientDoc.docs.isEmpty) {
        showErrorDialog(context, 'Recipient not found.');
        return;
      }

      final recipientData = recipientDoc.docs.first;
      final recipientBalance = recipientData['money'];

      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserDoc.id)
          .update({
        'money': senderBalance - amount,
        'transactions': FieldValue.arrayUnion([
          {
            'to': recipientPhoneNumber,
            'money': -amount,
            'date': Timestamp.now(),
            'description': 'Payment via QR code',
          }
        ]),
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(recipientData.id)
          .update({
        'money': recipientBalance + amount,
        'transactions': FieldValue.arrayUnion([
          {
            'from': senderPhone,
            'money': amount,
            'date': Timestamp.now(),
            'description': 'Payment received via QR code',
          }
        ]),
      });

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SuccessPage()));
    } catch (e) {
      showErrorDialog(context, 'An error occurred: ${e.toString()}');
    }
  }

  void showErrorDialog(BuildContext context, String message) {
    showBottomSheet(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
