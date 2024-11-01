import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get_it/get_it.dart';
import 'package:bank/src/core/colors/app_colors.dart';
import 'package:bank/src/features/main/presentation/bloc/current_bloc/current_bloc.dart';
import 'package:bank/src/features/main/presentation/bloc/message_bloc/message_bloc.dart';
import 'package:bank/src/features/main/presentation/bloc/news_bloc/news_bloc.dart';
import 'package:bank/src/features/main/presentation/bloc/next_book_bloc/next_book_bloc.dart';
import 'package:bank/src/features/main/presentation/pages/main_page.dart';
import 'package:bank/src/features/unauth/presentation/log_in_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    if (Platform.isAndroid) {
      await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    }
  });

  runApp(MyApp());

  GetIt.instance.registerLazySingleton<MessageBloc>(() => MessageBloc());
  GetIt.instance.registerLazySingleton<NextBookBloc>(() => NextBookBloc());
  GetIt.instance.registerLazySingleton<CurrentBloc>(() => CurrentBloc());
  GetIt.instance.registerLazySingleton<NewsBloc>(() => NewsBloc());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.mainColor,
        ),
        debugShowCheckedModeBanner: false,
        home: InitializationPage(),
      ),
    );
  }
}

class InitializationPage extends StatefulWidget {
  @override
  _InitializationPageState createState() => _InitializationPageState();
}

class _InitializationPageState extends State<InitializationPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _checkUserStatus();
  }

  void _checkUserStatus() async {
    await Future.delayed(Duration(seconds: 2));

    User? user = _auth.currentUser;
    print("User is ${user != null ? "logged in" : "not logged in"}");

    if (user != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => NavPage()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LogInPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: AppColors.buttonColor,
        ),
      ),
    );
  }
}
