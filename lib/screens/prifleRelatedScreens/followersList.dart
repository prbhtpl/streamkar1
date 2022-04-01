import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/screens/prifleRelatedScreens/profileInfoScreen.dart';
import 'package:http/http.dart' as http;
import '../../helper/helperFunctions.dart';


class FollowersScreen extends StatefulWidget {
  const FollowersScreen({Key? key}) : super(key: key);

  @override
  _FollowersScreenState createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {

  bool loading=false;
  List followersList=[];
  Future GetFollowersList() async {
    EasyLoading.show(status: 'Searching...');
    var api = Uri.parse(
        "https://vinsta.ggggg.in.net/api/FollowersList");
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
      followersList = res['response_FollowersList'];
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
  @override
  void initState() {
    GetFollowersList();
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
          'Followers ',
          style: TextStyle(color: Colors.black),
        ),
        toolbarHeight: 50,
      ),
      body:  ListView.builder(
          itemCount:followersList == null ? 0 : followersList.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                InkWell(onTap: (){   Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileInfo(user_id: followersList[index]['user_id'] ,)));},
                  child: ListTile(
                      leading: ClipOval(
                        child: loading != true
                            ? Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                            : Image.network(
                          followersList[index]['userphoto']
                              .toString(),
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),

                      title:Column(
                        children: [
                          Align(alignment: Alignment.centerLeft,child: Text( followersList[index]['user_name'])),
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
