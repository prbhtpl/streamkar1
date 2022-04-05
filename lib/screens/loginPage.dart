import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/helper/helperFunctions.dart';
import 'package:untitled/screens/regiterScreen.dart';
import 'package:video_player/video_player.dart';
import '../bottomNavigationBar/bottomNavigation.dart';
import '../helper/storeSecureStorage.dart';
import '../myhomePage.dart';
import '../services/auth.dart';
import '../services/database.dart';
import 'package:http/http.dart' as http;

class LogginScreen extends StatefulWidget {
  const LogginScreen({Key? key, required this.toggle}) : super(key: key);
  final Function toggle;
  @override
  _LogginScreenState createState() => _LogginScreenState();
}

class _LogginScreenState extends State<LogginScreen> {
  late VideoPlayerController _controller;
  AuthMethods authMethods = AuthMethods();
  DataBaseMethods dataBaseMethods = DataBaseMethods();
  final formKey = GlobalKey<FormState>();
  bool loading = false;
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  /*signIn() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      await authMethods
          .signInWithEmailAndPassword(email.text, password.text)
          .then((value) async {
        if (value != null) {
          QuerySnapshot userInfoSnapshot =
              await dataBaseMethods.getUserByUserEmail(email.text);

          HelperFunctions.saveuserLoggedInSharedPreference(true);
          HelperFunctions.saveuserNameSharedPreference(
              userInfoSnapshot.documents[0].data["name"]);
          HelperFunctions.saveuserEmailSharedPreference(
              userInfoSnapshot.documents[0].data["email"]);
          HelperFunctions.saveuserCurrentUserIdSharedPreference(
              userInfoSnapshot.documents[0].documentID);
          String uid = await HelperFunctions.getCurrentUserIdSharedPreference();

          print("asdasdasd::" + uid);
          print(
              "hhere is your document id:${userInfoSnapshot.documents[0].documentID}");
          print(
              "hhere is your name:${userInfoSnapshot.documents[0].data['name']}");
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => BottomNavigation(screenId: 0)));
        }
        else {
          setState(() {
            loading = false;
            //show snackbar
          });
        }
      });
    }
  }*/
  Future loginMethod() async {
    await HelperFunctions.saveuserLoggedInSharedPreference(true);
    if (formKey.currentState!.validate()) {
      EasyLoading.show(status: 'Loading...');

      var api = Uri.parse("https://vinsta.ggggg.in.net/api/userlogin");

      Map mapeddate = {
        'user_email': email.text,
        'password': password.text,
      };

      final response = await http.post(
        api,
        body: mapeddate,
      );

      var res = await json.decode(response.body);
      print("hererere" + response.body);

      var userDetails = await HelperFunctions.getVStarUniqueIdkey();
      print('id1${userDetails.toString()}');
      await HelperFunctions.savePreferenceVStarUniqueIdkey(
          res['response_userLogin'][0]['id']);
      var msg = res['status_message'].toString();

      try {
        if (response.statusCode == 200) {
          if (msg == "User Login Successful") {
            Fluttertoast.showToast(msg: msg.toString());
            EasyLoading.dismiss();
            setState(() {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => BottomNavigation(screenId: 0),
                ),
              );
            });
            setState(() {
              loading = true;
            });

            await authMethods
                .signInWithEmailAndPassword(email.text, password.text)
                .then((value) async {
              if (value != null) {
                QuerySnapshot userInfoSnapshot =
                    await dataBaseMethods.getUserByUserEmail(email.text);

                HelperFunctions.saveuserLoggedInSharedPreference(true);
                HelperFunctions.saveuserNameSharedPreference(
                    userInfoSnapshot.documents[0].data["name"]);
                HelperFunctions.saveuserEmailSharedPreference(
                    userInfoSnapshot.documents[0].data["email"]);
                HelperFunctions.saveuserCurrentUserIdSharedPreference(
                    userInfoSnapshot.documents[0].documentID);
                String uid =
                    await HelperFunctions.getCurrentUserIdSharedPreference();

                print("asdasdasd::" + uid);
                print(
                    "hhere is your document id:${userInfoSnapshot.documents[0].documentID}");
                print(
                    "hhere is your name:${userInfoSnapshot.documents[0].data['name']}");
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BottomNavigation(screenId: 0)));
              } else {
                setState(() {
                  loading = false;
                  //show snackbar
                });
              }
            });
          } else if (msg == "Login Credentials is not correct") {
            EasyLoading.dismiss();
            setState(() {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => RegisterScreen(
                    toggle: widget.toggle,
                  ),
                ),
              );
            });
            return Fluttertoast.showToast(
                msg: 'User Not Register Please Sign Up');
          }
        }
      } catch (e) {
        print(e);
      }
    }
  }
Future init()async{
    final username=await UserSecureStorage.getUsername()??'';
    final password=await UserSecureStorage.getPassword()??'';
    print("username"+username.toString());
    print("password"+password.toString());
    setState(() {
      this.email.text=username;
      this.password.text=password;
    });
}
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videoplayback.mp4')
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);
        // Ensure the first frame is shown after the video is initialized
        setState(() {});
      });
    init();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : Stack(
              children: <Widget>[
                SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _controller.value.size.width,
                      height: _controller.value.size.height,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                ),
                SingleChildScrollView(
                    child: SafeArea(
                        child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      height: 60,
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
                              border:
                                  Border.all(color: Colors.white54, width: 2)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              color: Colors.black12,
                              width: 300,
                              height: 200,
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
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            validator: (val) {
                                              return RegExp(
                                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                      .hasMatch(val!)
                                                  ? null
                                                  : "Please provide a valid email";
                                            },
                                            controller: email,
                                            style:
                                                TextStyle(color: Colors.white),
                                            decoration: InputDecoration(
                                                hintText: 'Enter your email Id',
                                                hintStyle: TextStyle(
                                                    color: Colors.white)),
                                          ),
                                          TextFormField(
                                            obscureText: true,
                                            validator: (val) {
                                              return val!.length > 6
                                                  ? null
                                                  : "Please provide greater than 6 charater password";
                                            },
                                            controller: password,
                                            style:
                                                TextStyle(color: Colors.white),
                                            decoration: InputDecoration(
                                                hintText: 'Password',
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
                                          "Login",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.teal,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onPressed: () async{
                                          await UserSecureStorage.setUserName(email.text.toString());
                                          await UserSecureStorage.setPassword(password.text.toString());
                                          //  signIn();
                                          loginMethod();



                                        },
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ),
                        ), SizedBox(
                          height: 5,
                        ),
                        InkWell(onTap: (){

                        },
                          child: Text('Forget Paassword?', style: TextStyle(
                              fontSize: 17,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                            'Login means you are agree to our Terms and Privacy Policy',
                            style:
                                TextStyle(fontSize: 12, color: Colors.white)),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: new Container(
                                  margin: const EdgeInsets.only(
                                      left: 10.0, right: 20.0),
                                  child: Divider(
                                    thickness: 1,
                                    color: Colors.white,
                                    indent: 30,
                                    height: 36,
                                  )),
                            ),
                            Text(
                              "OR",
                              style: TextStyle(color: Colors.white),
                            ),
                            Expanded(
                              child: new Container(
                                  margin: const EdgeInsets.only(
                                      left: 20.0, right: 10.0),
                                  child: Divider(
                                      thickness: 1,
                                      color: Colors.white,
                                      height: 36,
                                      endIndent: 30)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text('If you are new here please',
                        style: TextStyle(fontSize: 17, color: Colors.white)),
                    InkWell(
                        onTap: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return RegisterScreen(
                              toggle: widget.toggle,
                            );
                          }));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40.0),
                          child: Text('Sign Up ?',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold)),
                        ))
                  ],
                )))
              ],
            ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
    _controller.dispose();
  }
}
