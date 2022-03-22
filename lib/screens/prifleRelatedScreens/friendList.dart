import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/screens/prifleRelatedScreens/profileInfoScreen.dart';
import 'package:http/http.dart' as http;
import '../../helper/helperFunctions.dart';

class FriendListScreen extends StatefulWidget {
  const FriendListScreen({Key? key}) : super(key: key);

  @override
  _FriendListScreenState createState() => _FriendListScreenState();
}

class _FriendListScreenState extends State<FriendListScreen> {
  bool loading = false;
  List friendList = [];
  int status = 0;
  bool statusbool = false;
  Future FriendList() async {
    EasyLoading.show(status: 'Searching...');
    var api = Uri.parse("https://vinsta.ggggg.in.net/api/friends_list");
    var id1 = await HelperFunctions.getVStarUniqueIdkey();
    Map mapeddate = {
      "user_id": id1.toString(),
    };

    final response = await http.post(
      api,
      body: mapeddate,
    );
    var res = await json.decode(response.body);
    print("UploadPosts" + response.body);
    setState(() {
      friendList = res['response_friendList'];
      loading = true;
      /* suggestion = false;*/
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

  Future AddFriendUnfriend(int followingId, int status) async {
    EasyLoading.show(status: 'Loading...');
    var api = Uri.parse("https://vinsta.ggggg.in.net/api/addFriends");
    var id1 = await HelperFunctions.getVStarUniqueIdkey();
    print(followingId);
    print("Status:" + status.toString());
    Map mapeddate = {
      "user_id": id1.toString(),
      "friend_id": followingId.toString(),
      "status_friend": status.toString()
    };

    final response = await http.post(api, body: mapeddate);

    var res = await json.decode(response.body);
    // print("UploadPosts1" + response.body);


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
    FriendList();
    super.initState();
  }

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
          'Friend List',
          style: TextStyle(color: Colors.black),
        ),
        toolbarHeight: 50,
      ),
      body: ListView.builder(
          itemCount: friendList == null ? 0 : friendList.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                ListTile(
                   leading: InkWell(onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileInfo(user_id: friendList[index]['friend_id'] ,)));
                    },
                      child: ClipOval(
                        child: loading != true
                            ? Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                            : Image.network(
                          friendList[index]['userphoto']
                              .toString(),
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                  title: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text(friendList[index]['user_name'])),
                          Row(
                            children: [
                              Text(
                                'Id:  ',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    friendList[index]['user_code'].toString(),
                                    style: TextStyle(color: Colors.grey),
                                  )),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: Colors.lightGreen,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.lightGreen)),
                            child: Text(
                              'Lv 1',
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: Colors.yellow.shade200,
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(color: Colors.yellow.shade200)),
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
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Last Online :265 days...',
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                          )
                        ],
                      ),
                    ],
                  ),
                  trailing: friendList[index]['status_friend'] == 0
                      ? FlatButton(minWidth: 30,padding: EdgeInsets.all(5),height: 10,
                          color: Colors.blue,
                          onPressed: () {
                            setState(() {
                              if (friendList[index]['status_friend'] == 0) {
                                statusbool = false;
                              } else {
                                statusbool = true;
                              }
                              statusbool = !statusbool;
                              if (statusbool == false) {
                                status = 0;
                              } else {
                                status = 1;
                              }
                            });
                            print(status);
                            AddFriendUnfriend(
                                friendList[index]['friend_id'], status);
                            FriendList();
                          },
                          child: Text('Add Friend',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white)))
                      : FlatButton(minWidth: 30,padding: EdgeInsets.all(5),height: 10,
                          color: Colors.blue,
                          onPressed: () {
                            setState(() {
                              if (friendList[index]['status_friend'] == 0) {
                                statusbool = false;
                              } else {
                                statusbool = true;
                              }
                              statusbool = !statusbool;
                              if (statusbool == false) {
                                status = 0;
                              } else {
                                status = 1;
                              }
                            });
                            print(status);
                            AddFriendUnfriend(
                                friendList[index]['friend_id'], status);
                            FriendList();
                          },
                          child: Text('Unfriend',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.white))),
                ),
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                )
              ],
            );
          }),
    );
  }
}
