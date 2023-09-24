import 'package:firebase_core/firebase_core.dart';
import 'package:predicther_03/pages/FinalReportPage.dart';
import 'package:predicther_03/pages/Forgot_pass.dart';
import 'package:predicther_03/pages/HomePage.dart';
import 'package:predicther_03/pages/HormonalReportsPage.dart';
import 'package:predicther_03/pages/LoginPage.dart';
import 'package:predicther_03/pages/LoginPagenew.dart';
import 'package:predicther_03/pages/NoHormonalReportsPage.dart';
import 'package:predicther_03/pages/ReportsUploadedPage.dart';
import 'package:predicther_03/pages/SignUpPage.dart';
import 'package:predicther_03/pages/SignUpPagenew.dart';
import 'package:predicther_03/pages/WelcomePage.dart';
import 'package:predicther_03/pages/cycle.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink, // Choose a color theme
      ),
      routes: {
        '/': (context) => LoginPage(), // The initial route is the LoginPage
        '/homepage': (context) => HomePage(), // Define your homepage route
        '/resetpassword': (context) => Forgot_pass(), // Define reset password route
        '/signup': (context) => SignUpScreen(), // Define signup route
        '/login': (context) => LoginPage(), // login route
        '/cycle': (context) => cycle(), // mentrual cycle data taker
        '/hormonal_reports': (context) => HormonalReportsPage(),
        '/no_hormonal_reports': (context) => NoHormonalReportsPage(),
        '/reports_uploaded': (context) => ReportsUploadedPage(),
        '/resultpage': (context) => FinalReportPage(),
      },
    );
  }
}

