import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled/bottomNavigationBar/bottomNavigation.dart';
import 'package:http/http.dart' as http;

import '../../../helper/helperFunctions.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController CurrentPassword = TextEditingController();
  TextEditingController NewPassword = TextEditingController();
  TextEditingController RetypePassword = TextEditingController();
  Future UpdatePassword() async {
    EasyLoading.show(status: 'Loading...');
    var api = Uri.parse("https://vinsta.ggggg.in.net/api/changepassword");
    var id1 = await HelperFunctions.getVStarUniqueIdkey();
    Map mapeddate = {
      "id": id1.toString(),
      "oldpassword": CurrentPassword.text,
      "password": NewPassword.text,
      "confirm_password": RetypePassword.text
    };

    final response = await http.post(api, body: mapeddate);

    var res = await json.decode(response.body);
    print("UploadPosts1" + response.body);
    setState(() {

      CurrentPassword.clear();
       NewPassword.clear();
       RetypePassword.clear();

    });

    try {
      if (response.statusCode == 200 &&
          res['status_message'] == "Change Password Successful") {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => BottomNavigation(screenId: 0)));
        EasyLoading.dismiss();
        Fluttertoast.showToast(msg: 'Updated');
      } else {
        EasyLoading.dismiss();
        Fluttertoast.showToast(msg: res['response_changepassword'].toString());
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              CupertinoIcons.left_chevron,
              color: Colors.black,
            )),
        actions: [],
        title: Text(
          'Change Password',
          style: TextStyle(color: Colors.black),
        ),
        toolbarHeight: 50,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 12.0, right: 12, top: 5, bottom: 5),
              child: Container(
                height: 45,
                padding: EdgeInsets.fromLTRB(8, 1, 8, 1),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey)),
                child: TextFormField(
                  controller: CurrentPassword,
                  decoration: InputDecoration(
                    prefixIcon: Icon(FontAwesomeIcons.shieldAlt),
                    border: InputBorder.none,
                    hintText: "Current Password",
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 12.0, right: 12, top: 5, bottom: 5),
              child: Container(
                height: 45,
                padding: EdgeInsets.fromLTRB(8, 1, 8, 1),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey)),
                child: TextFormField(
                  controller: NewPassword,
                  decoration: InputDecoration(
                    prefixIcon: Icon(FontAwesomeIcons.key),
                    border: InputBorder.none,
                    hintText: "Password",
                  ),
                  obscureText: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 12.0, right: 12, top: 5, bottom: 5),
              child: Container(
                height: 45,
                padding: EdgeInsets.fromLTRB(8, 1, 8, 1),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey)),
                child: TextFormField(
                  controller: RetypePassword,
                  decoration: InputDecoration(
                    prefixIcon: Icon(FontAwesomeIcons.key),
                    border: InputBorder.none,
                    hintText: "Confirm Password",
                  ),
                  obscureText: true,
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                UpdatePassword();
                },
                child: Text(
                  'Update Password',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.white30),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                )),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
