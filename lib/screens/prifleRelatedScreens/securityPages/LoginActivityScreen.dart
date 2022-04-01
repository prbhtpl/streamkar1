import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import '../../../helper/helperFunctions.dart';

class LoginActivityScreen extends StatefulWidget {
  const LoginActivityScreen({Key? key}) : super(key: key);

  @override
  _LoginActivityScreenState createState() => _LoginActivityScreenState();
}

class _LoginActivityScreenState extends State<LoginActivityScreen> {
  List loginActivity=[];
  Future LoginActivityList() async {
  EasyLoading.show(status: 'Updating');

  var api = Uri.parse("https://vinsta.ggggg.in.net/api/loginActivityList");
  var id1 = await HelperFunctions.getVStarUniqueIdkey();
  Map mapeddate = {
    "user_id":id1.toString(),

  };

  final response = await http.post(
    api,
    body: mapeddate,
  );
  var res = await json.decode(response.body);
  print("toString()" + response.body.toString());
  setState(() {
    loginActivity=res['response_loginActivityList'];
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
    LoginActivityList();
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
        actions: [],
        title: Text(
          'Login Activity',
          style: TextStyle(color: Colors.black),
        ),
        toolbarHeight: 50,
      ),
      body: ListView.builder(itemCount:loginActivity == null ? 0 : loginActivity.length,itemBuilder: (BuildContext,int index){


        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  'Where your are logged In',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(CupertinoIcons.location_solid),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Row(
                        children: [
                          loginActivity[index]['login_status']==1? Text(
                            'Active Now',
                            style: TextStyle(color: Colors.green),
                          ):Text(
                            'Offline Now',
                            style: TextStyle(color: Colors.red),
                          ),SizedBox(width: 5,),
                          Text(
                            'This ${ loginActivity[index]['device_name'].toString()}',
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      )
                    ],
                  ),
                  PopupMenuButton<String>(
                    icon: Icon(
                      CupertinoIcons.ellipsis_vertical,
                      color: Colors.black,
                    ),
                    padding: EdgeInsets.all(0),
                    onSelected: (value) {
                      print(value);
                    },
                    itemBuilder: ( context) {
                      return [
                        PopupMenuItem(
                          child: Text("Log Out"),
                          value: "clear chat",
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ];
                    },
                  ),
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}
