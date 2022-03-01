// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:untitled/screens/prifleRelatedScreens/selectedProfileInfo.dart';

import '../chatBox.dart';
import 'followersList.dart';
import 'followingList.dart';
import 'friendList.dart';


class ProfileInfo extends StatefulWidget {
  const ProfileInfo({Key? key}) : super(key: key);

  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Badges'),
          content: Container(
              // Specify some width
              width: MediaQuery.of(context).size.width * .7,
              child: GridView.builder(
                  itemCount: 60,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1),
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [Image.asset('assets/badge3.png',scale: 9,),Text('Badge no: $index',style: TextStyle(fontSize: 11),)],
                    );
                  })),
          actions: [
            Stack(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      CupertinoIcons.clear_circled_solid,
                      color: Colors.red,
                    ))
              ],
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var _collapsedHeight = 380.0;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ButtonTheme(
              minWidth: 150.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.pinkAccent)),
              child: RaisedButton(
                elevation: 5.0,
                hoverColor: Colors.green,
                color: Colors.pinkAccent,
                child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.add,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Follow",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                onPressed: () {},
              ),
            ),
            ButtonTheme(
              minWidth: 150.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.pinkAccent, width: 1)),
              child: RaisedButton(
                elevation: 5.0,
                hoverColor: Colors.green,
                color: Colors.white,
                child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.ellipses_bubble,
                      color: Colors.pinkAccent,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Chat",
                      style: TextStyle(
                        color: Colors.pinkAccent,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                 /* Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChatBox()));*/
                },
              ),
            ),
          ],
        ),
      ),

      body: SlidingUpPanel(
        renderPanelSheet: true,
        maxHeight: MediaQuery.of(context).size.height,
        minHeight: _collapsedHeight,
        panel: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FriendListScreen()));
                  },
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, right: 8.0, left: 8.0),
                        child: Text(
                          '66',
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 18.0, right: 8.0, left: 8.0),
                        child: Text(
                          'Friends',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FollowersScreen()));
                  },
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, right: 8.0, left: 8.0),
                        child: Text(
                          '489',
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 18.0, right: 8.0, left: 8.0),
                        child: Text(
                          'Followers',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FollowingScreen()));
                    },
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, right: 8.0, left: 8.0),
                          child: Text(
                            '66',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 18.0, right: 8.0, left: 8.0),
                          child: Text(
                            'Following',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
            InkWell(onTap: (){_showMyDialog();},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.pinkAccent.shade200,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.white),
                          ),
                          child: Icon(
                            CupertinoIcons.bag_fill,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Baggage'),
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/chirag.png',
                          scale: 5.5,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                _showMyDialog();
                              });
                            },
                            icon: Icon(CupertinoIcons.right_chevron))
                      ],
                    )
                  ],
                ),
              ),
            ),
            InkWell(onTap: (){_showMyDialog();},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.deepOrangeAccent.shade100,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.white),
                          ),
                          child: Icon(
                            Icons.emoji_events,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Badges'),
                      ],
                    ),

                    Row(
                      children: [
                        Image.asset(
                          'assets/badge1.png',
                          scale: 11,
                        ),
                        Image.asset(
                          'assets/badge2.png',
                          scale: 11,
                        ),
                        Image.asset(
                          'assets/badge3.png',
                          scale: 11,
                        ),
                        Image.asset(
                          'assets/chirag.png',
                          scale: 11,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        IconButton(
                            onPressed: () {   _showMyDialog();},
                            icon: Icon(CupertinoIcons.right_chevron))
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              indent: 15,
              color: Colors.grey,
              thickness: 2,
              endIndent: 15,
            )
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.orangeAccent, Colors.blue],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(0.5, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        }, icon: Icon(CupertinoIcons.back)),

                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectedProfileInfo()));
                            }, icon:Icon(CupertinoIcons.ellipsis))
                      ],
                    )
                  ],
                ),
              ),
              Stack(
                children: [
                  Container(
                    width:  MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.78,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.red, Colors.blue, Colors.yellow],

                      ),
                    ),
                  ),

                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Center(
                              child: Container(
                            width: 125,
                            height: 125,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: Colors.blue, width: 4),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/2.jpg')),
                            ),
                          )),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Pal Prabhat',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        Text(
                          "id:622636",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "India",
                          style: TextStyle(color: Colors.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 120.0, right: 120),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    color: Colors.lightGreen,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: Colors.lightGreen,
                                    )),
                                child: Text(
                                  'Lv 1',
                                  style: TextStyle(color: Colors.white, fontSize: 10),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    color: Colors.yellow.shade200,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: Colors.yellow.shade200,
                                    )),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      CupertinoIcons.heart_solid,
                                      color: Colors.red,
                                      size: 10,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '1',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 10),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                CupertinoIcons.forward_end_alt_fill,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
