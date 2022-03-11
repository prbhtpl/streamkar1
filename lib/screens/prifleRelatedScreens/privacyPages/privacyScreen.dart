import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled/screens/prifleRelatedScreens/privacyPages/ActivityStatus/activityStatusScreen.dart';
import 'package:untitled/screens/prifleRelatedScreens/privacyPages/CommentsPages/Comments.dart';
import 'package:untitled/screens/prifleRelatedScreens/privacyPages/Guides/GuidesScreen.dart';
import 'package:untitled/screens/prifleRelatedScreens/privacyPages/blockedAccounts/blockedAccountsScreen.dart';
import 'package:untitled/screens/prifleRelatedScreens/privacyPages/mentionPages/mentionsScreen.dart';
import 'package:untitled/screens/prifleRelatedScreens/privacyPages/mutedAccountsPage/mutedAccountsScreen.dart';

class privacyScreen extends StatefulWidget {
  const privacyScreen({Key? key}) : super(key: key);

  @override
  _privacyScreenState createState() => _privacyScreenState();
}

class _privacyScreenState extends State<privacyScreen> {
  bool status=false;
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
          'Privacy',
          style: TextStyle(color: Colors.black),
        ),
        toolbarHeight: 50,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Account Privacy',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              InkWell(
                onTap: () {
                  /* Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfile()));*/
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          FaIcon(FontAwesomeIcons.lock),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Private Account'),
                        ],
                      ),
                      Container(
                        child: Switch(
                          value: status,
                          onChanged: (value) {
                            setState(() {
                              status = value;
                              status == true
                                  ? Fluttertoast.showToast(
                                      msg:
                                          'Only your followers will be able to see your photos and videos')
                                  : Fluttertoast.showToast(
                                      msg:
                                          'Anyone  will be able to see your photos and videos');
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.grey.shade100,
                thickness: 6,
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Interactions',
                  style: TextStyle(fontSize: 20),
                ),
              ),

              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CommentsPage()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      FaIcon(CupertinoIcons.conversation_bubble),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Comments',
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
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>MentionsScreen()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          FaIcon(CupertinoIcons.at),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Mentions',
                          ),
                        ],
                      ),
                      Text(
                        'Everyone',
                        style: TextStyle(color: Colors.black26),
                      )
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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>GuidesScreen()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      FaIcon(CupertinoIcons.book),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Guides',
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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ActivityStatus()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      FaIcon(FontAwesomeIcons.userCheck),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Activity Status',
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Connections',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>BlockAccountScreen()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      FaIcon(FontAwesomeIcons.ban),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Blocked Accounts',
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MutedAccounts()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      FaIcon(FontAwesomeIcons.bellSlash),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Muted Acccounts',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
