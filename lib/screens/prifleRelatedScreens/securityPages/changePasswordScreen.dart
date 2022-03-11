import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled/bottomNavigationBar/bottomNavigation.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
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
                child: TextField(
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
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(FontAwesomeIcons.key),
                    border: InputBorder.none,
                    hintText: "New Password",
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
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(FontAwesomeIcons.key),
                    border: InputBorder.none,
                    hintText: "Retype new Password",
                  ),
                  obscureText: true,
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BottomNavigation(screenId: 0)));
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
            Center(
                child: InkWell(
              onTap: () {},
              child: Text(
                'Forget Password?',
                style: TextStyle(color: Colors.blue),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
