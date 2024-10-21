import 'package:flutter/material.dart';
import 'package:gradus/src/features/unauth/presentation/log_in_page.dart';
import 'package:gradus/src/features/unauth/presentation/sign_up_page.dart';

void main() async {
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LogInPage(),
      ),
    );
  }
}
