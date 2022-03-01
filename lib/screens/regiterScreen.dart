import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../bottomNavigationBar/bottomNavigation.dart';
import '../helper/helperFunctions.dart';
import '../services/auth.dart';
import '../services/database.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key, required this.toggle}) : super(key: key);
  final Function toggle;
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videoplayback.mp4')
      ..initialize().then((_) {
        _controller?.play();
        _controller?.setLooping(true);
        // Ensure the first frame is shown after the video is initialized
        setState(() {});
      });
  }

  bool isloading = false;
  AuthMethods authMethods = new AuthMethods();
  DataBaseMethods dataBaseMethods = new DataBaseMethods();
  final formKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  SignUp() {
    if (formKey.currentState!.validate()) {
      HelperFunctions.saveuserEmailSharedPreference(email.text);
      HelperFunctions.saveuserNameSharedPreference(username.text);
      setState(() {
        isloading = true;
      });
      authMethods.SignUpWithEmailAndPassword(email.text, password.text)
          .then((va) {
        if (va != null) {
          Map<String, String> userInfoMap = {
            'name': username.text,
            'email': email.text
          };
          dataBaseMethods.uploadUserInfo(userInfoMap);

          HelperFunctions.saveuserLoggedInSharedPreference(true);
          HelperFunctions.saveuserNameSharedPreference(username.text);
          HelperFunctions.saveuserEmailSharedPreference(password.text);

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => BottomNavigation(screenId: 0)));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isloading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : Stack(
              children: <Widget>[
                SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _controller?.value.size.width,
                      height: _controller?.value.size.height,
                      child: VideoPlayer(_controller!),
                    ),
                  ),
                ),
                SafeArea(
                    child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: 30,
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Column(
                        children: [
                          Column(
                            children: [
                              Image.asset('assets/logo.jpeg', scale: 15),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'V Star',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                border: Border.all(
                                    color: Colors.white54, width: 2)),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                color: Colors.black12,
                                width: 300,
                                height: 300,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Form(
                                        key: formKey,
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              controller: username,
                                              style: TextStyle(
                                                  color: Colors.white),
                                              decoration: InputDecoration(
                                                  /* prefixIcon: InkWell(
                                             onTap: () {},
                                             child: Container(
                                                 width: 5,
                                                 child: Row(
                                                   children: [
                                                     Text('+91',
                                                         style: TextStyle(
                                                             color: Colors.blue)),
                                                     Icon(Icons.arrow_drop_down)
                                                   ],
                                                 ))),*/
                                                  hintText: 'Enter your name',
                                                  hintStyle: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                            TextFormField(
                                              controller: email,
                                              validator: (val) {
                                                return RegExp(
                                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                        .hasMatch(val!)
                                                    ? null
                                                    : "Please provide a valid email";
                                              },
                                              style: TextStyle(
                                                  color: Colors.white),
                                              decoration: InputDecoration(
                                                  /*  suffixIcon: InkWell(
                                           onTap: () {},
                                           child: Padding(
                                             padding:
                                             const EdgeInsets.only(top: 12.0),
                                             child: Text(
                                               'Send',
                                               style:
                                               TextStyle(color: Colors.blue),
                                             ),
                                           ),
                                         ),*/
                                                  hintText: 'Enter Your Email',
                                                  hintStyle: TextStyle(
                                                      color: Colors.white)),
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                            ),
                                            TextFormField(
                                              obscureText: true,
                                              validator: (val) {
                                                return val!.length > 6
                                                    ? null
                                                    : "Please provide greater than 6 charater password";
                                              },
                                              controller: password,
                                              style: TextStyle(
                                                  color: Colors.white),
                                              decoration: InputDecoration(
                                                  /*    suffixIcon: InkWell(
                                           onTap: () {},
                                           child: Padding(
                                             padding:
                                             const EdgeInsets.only(top: 12.0),
                                             child: Text(
                                               'Send',
                                               style:
                                               TextStyle(color: Colors.blue),
                                             ),
                                           ),
                                         ),*/
                                                  hintText: 'Enter Password',
                                                  hintStyle: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      ButtonTheme(
                                        minWidth: 150.0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: BorderSide(
                                                color: Colors.teal, width: 1)),
                                        child: RaisedButton(
                                          elevation: 5.0,
                                          hoverColor: Colors.green,
                                          color: Colors.white,
                                          child: Text(
                                            "Register",
                                            style: TextStyle(
                                                color: Colors.teal,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          onPressed: () {
                                            SignUp();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ))
              ],
            ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }
}
