import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled/screens/prifleRelatedScreens/securityPages/LoginActivityScreen.dart';
import 'package:untitled/screens/prifleRelatedScreens/securityPages/changePasswordScreen.dart';
import 'package:untitled/screens/prifleRelatedScreens/securityPages/savedLoginInfo.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({Key? key}) : super(key: key);

  @override
  _SecurityScreenState createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
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
          'Security',
          style: TextStyle(color: Colors.black),
        ),
        toolbarHeight: 50,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Login Security'),
              ),
              InkWell(
                onTap: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangePassword()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(

                    children: [
                     FaIcon(FontAwesomeIcons.key),
                      SizedBox(width: 10,),
                      Text('Change password'),
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SavedLoginInfoScreen()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(

                    children: [FaIcon(FontAwesomeIcons.shieldAlt),
                      SizedBox(width: 10,),
                      Text(
                        'Saved Login Info',
                      ),

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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginActivityScreen()));

                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:Row(

                    children: [FaIcon(FontAwesomeIcons.unlockAlt),
                      SizedBox(width: 10,),
                      Text(
                        'Login Activity',
                      ),

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
            /*  InkWell(
                onTap: () {
                  *//* Navigator.push(context, MaterialPageRoute(builder: (context)=>LanguageScreen()));*//*
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:Row(

                    children: [FaIcon(CupertinoIcons.checkmark_shield),
                      SizedBox(width: 10,),
                      Text(
                        'Email Sended',
                      ),

                    ],
                  ),
                ),
              ),*/



            ],
          ),
        ),
      ),
    );
  }
}
