import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:untitled/screens/inboxPages/inboxSettingScreen.dart';
import 'package:untitled/screens/loginPage.dart';
import 'package:untitled/screens/prifleRelatedScreens/editProfileScreen.dart';
import 'package:untitled/screens/prifleRelatedScreens/lnguagesScreen.dart';
import 'package:untitled/screens/prifleRelatedScreens/privacyPages/privacyScreen.dart';
import 'package:untitled/screens/prifleRelatedScreens/securityPages/securityPage.dart';

import '../../helper/authenticate.dart';
import '../../services/auth.dart';
import 'AboutPage/aboutScreen.dart';
import 'FaQPageScreen/FaQScreen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  AuthMethods authMethods = AuthMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottomOpacity: 0.0,
        elevation: 2.0,
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
          'Settings',
          style: TextStyle(color: Colors.black),
        ),
        toolbarHeight: 50,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [  InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfile()));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Edit Profile',

                  ),
                  Icon(CupertinoIcons.right_chevron)
                ],
              ),
            ),
          ),
            Divider(
              color: Colors.grey.shade100,

              thickness: 6,
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SecurityScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Security',

                    ),
                    Icon(CupertinoIcons.right_chevron)
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.grey.shade100,

              thickness: 6,
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>privacyScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Privacy',

                    ),
                    Icon(CupertinoIcons.right_chevron)
                  ],
                ),
              ),
            ),

        /*    InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>InboxSettingPage()));

              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Inbox',

                    ),
                    Icon(CupertinoIcons.right_chevron)
                  ],
                ),
              ),
            ),*/
            Divider(
              color: Colors.grey.shade100,

              thickness: 6,
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>LanguageScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Language',

                    ),
                    Icon(CupertinoIcons.right_chevron)
                  ],
                ),
              ),
            ),

         /*   InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'App Alerts',

                    ),
                    Icon(CupertinoIcons.right_chevron)
                  ],
                ),
              ),
            ),*/
            Divider(
              color: Colors.grey.shade100,

              thickness: 6,
              height: 10,
            ),


         InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Review Us!',

                    ),
                    Icon(CupertinoIcons.right_chevron)
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.grey.shade100,

              thickness: 6,
              height: 10,
            ),


            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>FaQScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'FAQ',

                    ),
                    Icon(CupertinoIcons.right_chevron)
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.grey.shade100,

              thickness: 6,
              height: 10,
            ),
            /*InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Check for update',

                    ),
                 Text('Current Version',style: TextStyle(fontSize: 13,color: Colors.grey),)
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.grey,


              height: 10,
            ),*/
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Connect With Us',

                    ),
                    Icon(CupertinoIcons.right_chevron)
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.grey.shade100,

              thickness: 6,
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutUsPage()));


              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'About Us',

                    ),
                    Icon(CupertinoIcons.right_chevron)
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.grey.shade100,

              thickness: 6,
              height: 10,
            ),
            InkWell(
              onTap: () {

               setState(() {
                 authMethods.SignOut();
                 Navigator.pushReplacement(
                     context,
                     MaterialPageRoute(
                         builder: (context) => Authenticate()));
               });
              },
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(height:40,

                    child: Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Text(
                        'Log Out',

                      ),
                    ),
                  ),
                ],
              ),
            ), Divider(
              color: Colors.grey.shade100,

              thickness: 6,
              height: 10,
            ),


          ],
        ),
      ),
    );
  }
}
