import 'package:bank/src/core/colors/app_colors.dart';
import 'package:bank/src/core/widgets/custom_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.mainColor,
        appBar: const CustomAppBar(
          title: 'Services',
          backgroundColor: AppColors.mainColor,
          popAble: false,
        ),
        body: Container());
  }
}
