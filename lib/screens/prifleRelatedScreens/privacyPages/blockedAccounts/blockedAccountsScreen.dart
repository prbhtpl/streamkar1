import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/screens/prifleRelatedScreens/privacyPages/blockedAccounts/addUsersToBlockList.dart';
import 'package:http/http.dart' as http;
import '../../../../helper/helperFunctions.dart';
import '../../profileInfoScreen.dart';
class BlockAccountScreen extends StatefulWidget {
  const BlockAccountScreen({Key? key}) : super(key: key);

  @override
  _BlockAccountScreenState createState() => _BlockAccountScreenState();
}

class _BlockAccountScreenState extends State<BlockAccountScreen> {
  bool loading = false;
  List AllBlockUsersList = [];
  Future UsersList() async {
    EasyLoading.show(status: 'Searching...');
    var api = Uri.parse("https://vinsta.ggggg.in.net/api/blockedList");
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
      AllBlockUsersList = res['response_blockList'];
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

  Future PostBlock(int followingId) async {
    EasyLoading.show(status: 'Searching...');
    var api = Uri.parse("https://vinsta.ggggg.in.net/api/blockUnblock");
    var id1 = await HelperFunctions.getVStarUniqueIdkey();
    Map mapeddate = {
      "following_id": followingId.toString(),
      "user_id": id1.toString(),
      "status_block": 0.toString()
    };

    final response = await http.post(
      api,
      body: mapeddate,
    );
    var res = await json.decode(response.body);
    print("UploadPosts111" + response.body);

    try {
      if (response.statusCode == 200) {
        setState(() {

          UsersList();
        });

        EasyLoading.dismiss();
        Fluttertoast.showToast(msg: 'Updated');
      }
    } catch (e) {
      print(e);
    }
  }
@override
  void initState() {
  UsersList();
    super.initState();
  }

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
        actions: [IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>AddUsersToBlockList()));}, icon: Icon(CupertinoIcons.add,color: Colors.black,))],
        title: Text(
          'Blocked Accounts',
          style: TextStyle(color: Colors.black),
        ),
        toolbarHeight: 50,
      ),
      body: ListView.builder(
          itemCount: AllBlockUsersList == null ? 0 : AllBlockUsersList.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  trailing: AllBlockUsersList[index]['status_block'] == 0
                      ? ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                    onPressed: () {
                    /*  PostBlock(AllBlockUsersList[index]['user_id']);*/
                    },
                    child: Text(
                      'Block',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                      : ElevatedButton(
                    style:
                    ElevatedButton.styleFrom(primary: Colors.white),
                    onPressed: () {
                      PostBlock(AllBlockUsersList[index]['user_id']);
                    },
                    child: Text(
                      'Unblock',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  leading: ClipOval(
                    child: loading != true
                        ? Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                        : Image.network(
                      AllBlockUsersList[index]['userphoto']==null?'https://ps.w.org/user-avatar-reloaded/assets/icon-256x256.png?rev=2540745':  AllBlockUsersList[index]['userphoto'].toString(),
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text(AllBlockUsersList[index]['user_name'])),
                          Row(
                            children: [
                              Text(
                                'Id:  ',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    AllBlockUsersList[index]['user_code'].toString(),
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
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
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
