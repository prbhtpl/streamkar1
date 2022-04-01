// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:untitled/screens/prifleRelatedScreens/selectedProfileInfo.dart';
import 'package:http/http.dart' as http;
import '../../helper/helperFunctions.dart';

import 'followersList.dart';
import 'followingList.dart';
import 'friendList.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({Key? key,required this.user_id}) : super(key: key);
final int user_id;
  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  List profile = [];  bool UserImageloading = false;
  String ImagelUrl = '';
  String name = '';
  String vId = '';
  String region = '';
  int followersCount = 0;
  int friendsCount = 0;
  int followingCount = 0;
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
                      children: [
                        Image.asset(
                          'assets/badge3.png',
                          scale: 9,
                        ),
                        Text(
                          'Badge no: $index',
                          style: TextStyle(fontSize: 11),
                        )
                      ],
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
  Future getUserDetails() async {
    var api = Uri.parse("https://vinsta.ggggg.in.net/api/profileGet");
    var id1 = await HelperFunctions.getVStarUniqueIdkey();
    Map mapeddate = {"user_id": widget.user_id.toString()};
    print(widget.user_id);

    final response = await http.post(
      api,
      body: mapeddate,
    );

    var res = await json.decode(response.body);
    print("hererere" + response.body);
    setState(() {
      profile = res['response_getUserProfile'];
      print(profile);
      if (profile[0]['userphoto'] == null) {
        ImagelUrl =
            'https://ps.w.org/user-avatar-reloaded/assets/icon-256x256.png?rev=2540745'
                .toString();
      } else {
        ImagelUrl = profile[0]['userphoto'].toString();
      }
      name = profile[0]['user_name'].toString();
      region = profile[0]['region'].toString();
      vId = profile[0]['user_code'].toString();
      print('Image:' + ImagelUrl.toString());
      UserImageloading = true;
    });

    try {
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Updated');
      }
    } catch (e) {
      print(e);
    }
  }
  Future GetFollowingCount() async {
    EasyLoading.show(status: 'Updating');
    var api = Uri.parse("https://vinsta.ggggg.in.net/api/following_count");
    var id1 = await HelperFunctions.getVStarUniqueIdkey();
    Map mapeddate = {
      "user_id":  widget.user_id.toString(),
    };

    final response = await http.post(
      api,
      body: mapeddate,
    );
    var res = await json.decode(response.body);
    print("UploadPosts2" + response.body);
    setState(() {
      followingCount = res['response_following_count'];
    });

    try {
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        Fluttertoast.showToast(msg: 'Updated');
      }
    } catch (e) {
      print(e);
    }
  }
  Future GetFollowersCount() async {
    EasyLoading.show(status: 'Searching...');
    var api = Uri.parse("https://vinsta.ggggg.in.net/api/FollowersCount");
    var id1 = await HelperFunctions.getVStarUniqueIdkey();
    Map mapeddate = {
      "user_id": widget.user_id.toString(),
    };

    final response = await http.post(
      api,
      body: mapeddate,
    );
    var res = await json.decode(response.body);
    print("UploadPosts2" + response.body);
    setState(() {
      followersCount = res['response_FollowersCount'];
    });

    try {
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        Fluttertoast.showToast(msg: 'Updated');
      }
    } catch (e) {
      print(e);
    }
  }
  Future GetFriendsCount() async {
    EasyLoading.show(status: 'Searching...');
    var api = Uri.parse("https://vinsta.ggggg.in.net/api/friendListCount");
    var id1 = await HelperFunctions.getVStarUniqueIdkey();
    Map mapeddate = {
      "user_id": widget.user_id.toString(),
    };

    final response = await http.post(
      api,
      body: mapeddate,
    );
    var res = await json.decode(response.body);
    print("UploadPosts1" + response.body);
    setState(() {
      friendsCount = res['response_friendCount'];
    });

    try {
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        Fluttertoast.showToast(msg: 'Updated');
      }
    } catch (e) {
      print(e);
    }
  }
  @override
  void initState() {
    getUserDetails();
    GetFollowingCount();
    GetFriendsCount();
    GetFollowersCount();
    super.initState();
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
                          friendsCount.toString(),
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
                          followersCount.toString(),
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
                            followingCount.toString(),
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
            InkWell(
              onTap: () {
                _showMyDialog();
              },
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
            InkWell(
              onTap: () {
                _showMyDialog();
              },
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
                            onPressed: () {
                              _showMyDialog();
                            },
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
                      colors: [
                        Color(0xFF9D6EF7),
                        Colors.lightBlueAccent.shade200
                      ],
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
                        },
                        icon: Icon(CupertinoIcons.back)),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SelectedProfileInfo()));
                            },
                            icon: Icon(CupertinoIcons.ellipsis))
                      ],
                    )
                  ],
                ),
              ),
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.78,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.lightBlueAccent.shade200,
                        Colors.black12,
                        Color(0xFF9D6EF7),
                        Colors.lightBlueAccent.shade200,
                        Color(0xFF9D6EF7),
                        Colors.black12,
                        Color(0xFF9D6EF7),
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Center(
                            child: ClipOval(
                              child: UserImageloading != true
                                  ? Container(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                                  : Image.network(
                                ImagelUrl != null
                                    ? ImagelUrl.toString()
                                    : 'No Image Found',
                                width: 130,
                                height: 130,
                                fit: BoxFit.cover,
                              ),
                            ),),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          name.toString(),
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                             vId.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                             region.toString(),
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 120.0, right: 120),
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
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10),
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
