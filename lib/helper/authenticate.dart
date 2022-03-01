
import 'package:flutter/material.dart';
import 'package:untitled/screens/loginPage.dart';

import '../screens/regiterScreen.dart';
class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

 bool showSignIn=true;

void toggleView(){
  setState(() {
    showSignIn=!showSignIn;
  });
}

  @override
  Widget build(BuildContext context) {

    if (showSignIn) {
      return LogginScreen(toggle: toggleView,);
    } else {
      return RegisterScreen(toggle: toggleView,);
    }
}
}
