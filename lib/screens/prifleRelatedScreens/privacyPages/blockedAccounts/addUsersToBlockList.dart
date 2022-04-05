import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/screens/prifleRelatedScreens/privacyPages/blockedAccounts/blockedAccountsScreen.dart';
import '../../../../helper/helperFunctions.dart';

class AddUsersToBlockList extends StatefulWidget {
  const AddUsersToBlockList({Key? key}) : super(key: key);

  @override
  State<AddUsersToBlockList> createState() => _AddUsersToBlockListState();
}

class _AddUsersToBlockListState extends State<AddUsersToBlockList> {
  bool loading = false;
  List AllUsersList = [];
  Future UsersList() async {
    EasyLoading.show(status: 'Searching...');
    var api = Uri.parse("https://vinsta.ggggg.in.net/api/unblockedList");
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
      AllUsersList = res['response_unblockList'];
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
      "status_block": 1.toString()
    };

    final response = await http.post(
      api,
      body: mapeddate,
    );
    var res = await json.decode(response.body);
    print("UploadPosts1111" + response.body);
    setState(() {
      UsersList();
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
    UsersList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: ()async{
      
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BlockAccountScreen()));
      return true;
    },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent.shade200,
          toolbarHeight: 40,
          elevation: 0.0,
        ),
        body: ListView.builder(
            itemCount: AllUsersList == null ? 0 : AllUsersList.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    trailing: AllUsersList[index]['status_block'] == 0
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(primary: Colors.blue),
                            onPressed: () {
                              PostBlock(AllUsersList[index]['user_id']);
                            },
                            child: Text(
                              'Block',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(primary: Colors.white),
                            onPressed: () {},
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
                              AllUsersList[index]['userphoto']==null?'https://ps.w.org/user-avatar-reloaded/assets/icon-256x256.png?rev=2540745':  AllUsersList[index]['userphoto'].toString(),
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
                                child: Text(AllUsersList[index]['user_name'])),
                            Row(
                              children: [
                                Text(
                                  'Id:  ',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      AllUsersList[index]['user_code'].toString(),
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
      ),
    );
  }
}
