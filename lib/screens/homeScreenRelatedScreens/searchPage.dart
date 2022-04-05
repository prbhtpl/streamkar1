import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../../helper/helperFunctions.dart';
import '../prifleRelatedScreens/profileInfoScreen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool statusbool = false;
  int status = 0;
  bool loading = false;
  bool suggestion = false;
  List friendList = [];
  List SugeestedFriendList = [];
  TextEditingController Search = TextEditingController();
  Future SearchUsers() async {
    EasyLoading.show(status: 'Searching...');
    var api = Uri.parse(
        "https://vinsta.ggggg.in.net/api/searchFriends/${Search.text.toString()}");

    final response = await http.get(
      api,
    );

    var res = await json.decode(response.body);
    // print("UploadPosts" + response.body);
    setState(() {
      friendList = res['response_search'];
      loading = true;
      suggestion = false;
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

  /*Future AddFriendUnfriend(int followingId, int status) async {
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
    setState(() {});

    try {
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        Fluttertoast.showToast(msg: 'Updated');
      }
    } catch (e) {
      print(e);
    }
  }*/

  Future FollowUnfollow(int followingId, int status) async {
    print('followingId'+followingId.toString());
    print('status'+status.toString());


    EasyLoading.show(status: 'Loading...');
    var api = Uri.parse("https://vinsta.ggggg.in.net/api/follow_Store");
    var id1 = await HelperFunctions.getVStarUniqueIdkey();
    print(followingId);
    print("Status:" + status.toString());
    Map mapeddate = {
      "user_id": id1.toString(),
      "following_id": followingId.toString(),
      "status": status.toString()
    };

    final response = await http.post(api, body: mapeddate);

    var res = await json.decode(response.body);
    // print("UploadPosts1" + response.body);
    setState(() {
      SuggetionList();
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

  Future SuggetionList() async {
    EasyLoading.show(status: 'Loading...');
    var api = Uri.parse("https://vinsta.ggggg.in.net/api/suggestion_list");
    var id1 = await HelperFunctions.getVStarUniqueIdkey();
    Map mapeddate = {"user_id": id1.toString()};

    final response = await http.post(api, body: mapeddate);

    var res = await json.decode(response.body);
    //print("UploadPosts" + response.body);
    setState(() {
      SugeestedFriendList = res['response_Suggestion'];
      loading = true;
      suggestion = true;
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
    SuggetionList();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /*IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              CupertinoIcons.back,
            ),
          ),*/
                Container(
                  height: 30,
                  width: 250,
                  child: TextFormField(
                    controller: Search,
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderSide:
                              const BorderSide(color: Colors.white, width: 0.0),
                        ),
                        contentPadding: EdgeInsets.only(top: 10, left: 10),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            25,
                          ),
                        ),
                        hintText: 'Search by username / v Id',
                        hintStyle: TextStyle(fontSize: 12, color: Colors.grey)),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    SearchUsers();
                  },
                  child: Icon(
                    CupertinoIcons.search,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Divider(),
              Container(
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: friendList == null ? 0 : friendList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            ListTile(
                                leading: InkWell(
                                  onTap: () {
                                 /*   Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProfileInfo()));*/
                                  },
                                  child: ClipOval(
                                    child: loading != true
                                        ? Container(
                                            child: Center(
                                              child:
                                                  CircularProgressIndicator(),
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
                                trailing: friendList[index]['status'] == 0
                                    ? ButtonTheme(
                                        minWidth: 12,
                                        height: 14,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        ),
                                        child: RaisedButton(
                                          elevation: 0.0,
                                          hoverColor: Colors.green,
                                          color: Colors.pink.shade50,
                                          child: Icon(
                                            CupertinoIcons.add,
                                            color: Colors.pinkAccent,
                                            size: 15,
                                          ),
                                          onPressed: () {},
                                        ),
                                      )
                                    : ButtonTheme(
                                        minWidth: 12,
                                        height: 14,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        ),
                                        child: RaisedButton(
                                          elevation: 0.0,
                                          hoverColor: Colors.green,
                                          color: Colors.pink.shade50,
                                          child: Icon(
                                            CupertinoIcons.checkmark_alt,
                                            color: Colors.green,
                                            size: 15,
                                          ),
                                          onPressed: () {},
                                        ),
                                      ),
                                title: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(friendList[index]
                                                    ['user_name']
                                                .toString())),
                                        Row(
                                          children: [
                                            Text(
                                              'Id:  ',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                            Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  friendList[index]['user_code']
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.grey),
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
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Colors.lightGreen)),
                                          child: Text(
                                            'Lv 1',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                              color: Colors.yellow.shade200,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color:
                                                      Colors.yellow.shade200)),
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
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),

                                      ],
                                    ),
                                  ],
                                )),
                            Divider(
                              color: Colors.grey,
                              thickness: 1,
                            )
                          ],
                        );
                      })),
              suggestion != false
                  ? Container(
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: SugeestedFriendList == null
                              ? 0
                              : SugeestedFriendList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                ListTile(
                                    leading: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProfileInfo(user_id:    SugeestedFriendList[index]
                                                    ['id'],)));
                                      },
                                      child: ClipOval(
                                        child: loading != true
                                            ? Container(
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                              )
                                            : Image.network(
                                                SugeestedFriendList[index]
                                                        ['userphoto']
                                                    ==null?'https://ps.w.org/user-avatar-reloaded/assets/icon-256x256.png?rev=2540745':SugeestedFriendList[index]
                                                ['userphoto'].toString(),
                                                width: 50,
                                                height: 50,
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ),
                                    trailing: SugeestedFriendList[index]
                                                ['status'] ==
                                            0
                                        ? ButtonTheme(
                                            minWidth: 12,
                                            height: 14,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                            ),
                                            child: RaisedButton(
                                              elevation: 0.0,
                                              hoverColor: Colors.green,
                                              color: Colors.pink.shade50,
                                              child: Icon(
                                                CupertinoIcons.add,
                                                color: Colors.pinkAccent,
                                                size: 15,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  if (SugeestedFriendList[index]
                                                          ['status'] ==
                                                      0) {
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
                                                FollowUnfollow(
                                                    SugeestedFriendList[index]
                                                        ['id'],
                                                    status);

                                              },
                                            ),
                                          )
                                        : ButtonTheme(
                                            minWidth: 12,
                                            height: 14,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                            ),
                                            child: RaisedButton(
                                              elevation: 0.0,
                                              hoverColor: Colors.green,
                                              color: Colors.pink.shade50,
                                              child: Icon(
                                                CupertinoIcons.checkmark_alt,
                                                color: Colors.green,
                                                size: 15,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  if (SugeestedFriendList[index]
                                                          ['status'] ==
                                                      0) {
                                                    statusbool = false;
                                                  } else {
                                                    statusbool = true;
                                                  }
                                                  print("bool::::" +
                                                      statusbool.toString());
                                                  statusbool = !statusbool;
                                                  if (statusbool == false) {
                                                    status = 0;
                                                  } else {
                                                    status = 1;
                                                  }
                                                });
                                                print(status);
                                                FollowUnfollow(
                                                    SugeestedFriendList[index]
                                                        ['id'],
                                                    status);

                                              },
                                            ),
                                          ),
                                    title: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                    SugeestedFriendList[index]
                                                            ['user_name']
                                                        .toString())),
                                            Row(
                                              children: [
                                                Text(
                                                  'Id:  ',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 12),
                                                ),
                                                Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      SugeestedFriendList[index]
                                                              ['user_code']
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 12),
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
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color:
                                                          Colors.lightGreen)),
                                              child: Text(
                                                'Lv 1',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                  color: Colors.yellow.shade200,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: Colors
                                                          .yellow.shade200)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
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
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),

                                          ],
                                        ),
                                      ],
                                    )),
                                Divider(
                                  color: Colors.grey,
                                  thickness: 1,
                                )
                              ],
                            );
                          }))
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
