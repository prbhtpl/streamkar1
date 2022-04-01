import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/screens/prifleRelatedScreens/profileInfoScreen.dart';

import '../../helper/helperFunctions.dart';

class FollowingScreen extends StatefulWidget {
  const FollowingScreen({Key? key}) : super(key: key);

  @override
  _FollowingScreenState createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  bool statusbool = false;
  int status = 0;
  bool loading=false;
  List followingList=[];
  Future GetFollowingList() async {
    EasyLoading.show(status: 'Searching...');
    var api = Uri.parse(
        "https://vinsta.ggggg.in.net/api/following_list");
    var id1 = await HelperFunctions.getVStarUniqueIdkey();
    Map mapeddate = {"user_id": id1.toString(),
    };

    final response = await http.post(
      api,
      body: mapeddate,
    );
    var res = await json.decode(response.body);
 print("UploadPosts" + response.body);
    setState(() {
      followingList = res['response_following'];
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
  Future FollowUnfollow(int followingId, int status) async {
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
    setState(() {});

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
  GetFollowingList();
  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar:
      AppBar(
        backgroundColor: Colors.white,
        bottomOpacity: 0.0,
        elevation: 2.0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(CupertinoIcons.left_chevron,color: Colors.black,)),
        actions: [

        ],
        title: Text('Following',style: TextStyle(color: Colors.black),),
        toolbarHeight: 50,
      ),
      body: ListView.builder(
          itemCount:followingList == null ? 0 : followingList.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                InkWell(onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileInfo(user_id: followingList[index]['following_id'] ,)));
                },
                  child: ListTile(
                      leading: ClipOval(
                        child: loading != true
                            ? Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                            : Image.network(
                          followingList[index]['userphoto']
                              .toString(),
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    /*  trailing: followingList[index]['status'] == 0
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
                          Align(alignment: Alignment.centerLeft,child: Text( followingList[index]['user_name'])),
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
                ),
                Divider(color: Colors.grey,thickness: 1,),

              ],
            );

          }),
    );
  }
}
