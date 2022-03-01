// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/bottomNavigationBar/bottomNavigation.dart';
import 'package:untitled/screens/chatBox.dart';

import 'package:untitled/screens/inboxPages/inboxSettingScreen.dart';
import 'package:untitled/screens/inboxPages/searchScreent.dart';
import 'package:untitled/screens/prifleRelatedScreens/friendList.dart';
import 'package:untitled/screens/prifleRelatedScreens/profileInfoScreen.dart';

import '../../helper/constants.dart';
import '../../helper/helperFunctions.dart';
import '../../services/auth.dart';
import '../../services/database.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({Key? key}) : super(key: key);

  @override
  _InboxScreenState createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  AuthMethods authMethods = AuthMethods();
  DataBaseMethods dataBaseMethods = DataBaseMethods();
  Stream<QuerySnapshot>? chatRoomStream;
  Widget chatRoomList() {
    return StreamBuilder<QuerySnapshot>(
        stream: chatRoomStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data?.documents.length,
                  itemBuilder: (context, int index) {
                    return chatRoomTile(
                        chatroomId:
                            snapshot.data?.documents[index].data['chatroomid'],
                        otherUserName: snapshot
                            .data?.documents[index].data['chatroomid']
                            .replaceAll("_", "")
                            .replaceAll(Constants.myname, ""));
                  })
              : Container();
        });
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    Constants.myname = await HelperFunctions.getuserNameSharedPreference();
print(Constants.myname);
    dataBaseMethods.getChatRooms(Constants.myname).then((val) {
      setState(() {
        chatRoomStream = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(
            CupertinoIcons.search,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SearchScreen()));
          }),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [ Colors.blue,Colors.black,],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>BottomNavigation(screenId: 0,)));
                      },
                      icon: Icon(CupertinoIcons.back)),
                  Text(
                    'Inbox',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FriendListScreen()));
                        },
                        icon: Icon(CupertinoIcons.person_2_alt,
                            color: Colors.white),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InboxSettingPage()));
                        },
                        icon: Icon(CupertinoIcons.settings_solid,
                            color: Colors.white),
                      )
                    ],
                  )
                ],
              ),
            ),

            Expanded(child: chatRoomList())
          ],
        ),
      ),
    );
  }
}

class chatRoomTile extends StatelessWidget {
  const chatRoomTile(
      {Key? key, required this.otherUserName, required this.chatroomId})
      : super(key: key);
  final String otherUserName;
  final String chatroomId;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatBox(
                    otherUserName: otherUserName, chatRoomId: chatroomId)));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(   gradient: LinearGradient(
                  colors: [Colors.orangeAccent, Colors.blue],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(0.5, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
                   borderRadius: BorderRadius.circular(50)),
              child: Text("${otherUserName.substring(0, 1).toUpperCase()}"),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              otherUserName,
            )
          ],
        ),
      ),
    );
  }
}
