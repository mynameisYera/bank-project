import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:gradus/src/core/colors/app_colors.dart';
import 'package:gradus/src/features/main/presentation/bloc/message_bloc/message_bloc.dart';
import 'package:gradus/src/features/unauth/presentation/log_in_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  try {
    await Firebase.initializeApp();
    print('success');
    runApp(MyApp());
  } catch (e) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: 'AIzaSyCxvRrP1HzqRvhwg9FzAluR2zqFDTAFpko',
        appId: '1:660203016448:web:706d920decec3e5ab7a3e5',
        messagingSenderId: '660203016448',
        projectId: 'gradus-1eb02',
        authDomain: 'gradus-1eb02.firebaseapp.com',
        storageBucket: 'gradus-1eb02.appspot.com',
      ),
    );
    print("Error initializing Firebase: $e");
  }

  GetIt.instance.registerLazySingleton<MessageBloc>(() => MessageBloc());
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
        home: LogInPage(),
      ),
    );
  }
}
