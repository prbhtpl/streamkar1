// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
// @dart=2.9
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/bottomNavigationBar/bottomNavigation.dart';

import 'package:untitled/screens/recordVideoScreens/recordVideo.dart';

import 'helper/authenticate.dart';
import 'helper/helperFunctions.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    logError(e.code, e.description);
  }
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
        nextScreen: userIsLoggedIn != null
            ? userIsLoggedIn
                ? BottomNavigation(screenId: 0)
                : Authenticate()
            : Container(
                child: Center(
                  child: Authenticate(),
                ),
              ),
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
