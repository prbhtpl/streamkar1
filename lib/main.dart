// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
// @dart=2.9
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/bottomNavigationBar/bottomNavigation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:untitled/screens/loginPage.dart';

import 'helper/authenticate.dart';
import 'helper/helperFunctions.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn;

  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await HelperFunctions.getuserLoggedInSharedPreference().then((value) {
      setState(() {
        userIsLoggedIn = value;
        print("value:${value}");
      });
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimatedSplashScreen(
        splashIconSize: 200,
        duration: 3000,
        nextScreen: userIsLoggedIn != false

                ? BottomNavigation(screenId: 0)
                : Authenticate()
           ,
        splash: Image.asset(
          'assets/logo.jpeg',
          width: double.infinity,
          height: double.infinity,
        ),
        splashTransition: SplashTransition.fadeTransition,
      ),
    );
  }
}
