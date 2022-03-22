import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../../../helper/helperFunctions.dart';

class allUSerLikesScreen extends StatefulWidget {
  const allUSerLikesScreen({Key? key, required this.postId}) : super(key: key);
  final int postId;
  @override
  State<allUSerLikesScreen> createState() => _allUSerLikesScreenState();
}

class _allUSerLikesScreenState extends State<allUSerLikesScreen> {
  List likeList = [];
  bool loading=false;
  Future AllUsersWhoLikesPost() async {
    var api = Uri.parse("https://vinsta.ggggg.in.net/api/likelistOnimage");
    var id1 = await HelperFunctions.getVStarUniqueIdkey();
    Map mapeddate = {"id": widget.postId.toString()};

    final response = await http.post(
      api,
      body: mapeddate,
    );

    var res = await json.decode(response.body);
    print("hererere1" + response.body);
    setState(() {
      likeList = res['response_likeList'];
      loading=true;
    });

    try {
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Updated');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    AllUsersWhoLikesPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Likes',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 5),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    width: 320,
                    child: TextFormField(
                     /* controller: Search,*/
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
                  /*    SearchUsers();*/
                    },
                    child: Icon(
                      CupertinoIcons.search,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              child: ListView.builder(shrinkWrap: true,
                  itemCount:likeList == null ? 0 : likeList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        ListTile(
                            leading: InkWell(onTap: (){
                              /*   Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileInfo()));*/
                            },
                              child: ClipOval(
                                child: loading != true
                                    ? Container(
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                                    : Image.network(
                                  likeList[index]['userphoto']
                                      .toString(),
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          /*  trailing: likeList[index]['status'] == 0
                                ? FlatButton(minWidth: 30,padding: EdgeInsets.all(5),height: 10,
                                color: Colors.blue,
                                onPressed: () {
                                  setState(() {
                                    if (followingList[index]['status_friend'] == 0) {
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
                                      followingList[index]['following_id'], status);
                                  GetFollowingList();
                                },
                                child: Text('Add Friend',
                                    style:
                                    TextStyle(fontSize: 12, color: Colors.white)))
                                : FlatButton(minWidth: 30,padding: EdgeInsets.all(5),height: 10,
                                color: Colors.blue,
                                onPressed: () {
                                  setState(() {
                                    if (followingList[index]['status'] == 0) {
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
                                      followingList[index]['following_id'], status);
                                  GetFollowingList();
                                },
                                child: Text('Unfollow',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white))),*/
                            title:Column(
                              children: [
                                Align(alignment: Alignment.centerLeft,child: Text( likeList[index]['user_name'])),
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
                                        style: TextStyle(fontSize: 10, color: Colors.white),
                                      ),
                                    ),SizedBox(width: 5,),
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
                                                fontSize: 10, fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),SizedBox(width: 5,),
                                    Text('Last Online :265 days...',style: TextStyle(color: Colors.grey,fontSize: 13),)
                                  ],
                                ),
                              ],
                            )
                        ),
                        Divider(color: Colors.grey,thickness: 1,),

                      ],
                    );

                  }),
            )

          ],
        ),
      ),
    );
  }
}
