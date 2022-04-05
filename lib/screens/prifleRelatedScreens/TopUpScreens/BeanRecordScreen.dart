import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../../../helper/helperFunctions.dart';
import '../profileInfoScreen.dart';
class SendBeanRecord extends StatefulWidget {
  const SendBeanRecord({Key? key}) : super(key: key);

  @override
  State<SendBeanRecord> createState() => _SendBeanRecordState();
}

class _SendBeanRecordState extends State<SendBeanRecord> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,child:Scaffold(appBar: AppBar(bottom: TabBar(indicatorColor: Colors.red,indicatorWeight: 5,indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(10), // Creates border
        color: Colors.white),
      tabs: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Send Record',style: GoogleFonts.lato(fontSize: 15,fontWeight: FontWeight.bold),),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Receive Record',style: GoogleFonts.lato(fontSize: 15,fontWeight: FontWeight.bold),),
        ),
      ],
    ),toolbarHeight: 40,title: Text('Record'),backgroundColor: Colors.purpleAccent.shade400,),
    body:

    TabBarView(
      children: [
        Send_Record(),
        Receive_Record(),
      ],
    ),),);

  }
}
class Send_Record extends StatefulWidget {
  const Send_Record({Key? key}) : super(key: key);

  @override
  State<Send_Record> createState() => _Send_RecordState();
}

class _Send_RecordState extends State<Send_Record> {

List SendRecord=[];
bool loading=false;
  Future SendBeanRecord() async {

    var api = Uri.parse(
        "https://vinsta.ggggg.in.net/api/userSendHistory");
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
      SendRecord = res['response_send'];
      loading = true;
      /* suggestion = false;*/
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
  SendBeanRecord();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return loading?ListView.builder(
        itemCount:SendRecord == null ? 0 : SendRecord.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(subtitle: Text(SendRecord[index][''] ),
                    leading: ClipOval(
                      child: loading != true
                          ? Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                          : Image.network(
                        SendRecord[index]['userphoto']==null?'https://ps.w.org/user-avatar-reloaded/assets/icon-256x256.png?rev=2540745':
                        SendRecord[index]['userphoto'].toString(),
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),

                    title:Column(
                      children: [
                        Align(alignment: Alignment.centerLeft,child: Text( SendRecord[index]['user_name'])),
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
                            Text(SendRecord[index]['created_at'],style: TextStyle(color: Colors.grey,fontSize: 13),)
                          ],
                        ),
                      ],
                    )
                ),
              ),
              Divider(color: Colors.grey,thickness: 1,),

            ],
          );

        }):Container(child: Center(child: CircularProgressIndicator(),),);
  }
}
class Receive_Record extends StatefulWidget {
  const Receive_Record({Key? key}) : super(key: key);

  @override
  State<Receive_Record> createState() => _Receive_RecordState();
}

class _Receive_RecordState extends State<Receive_Record> {

List ReceiveBean=[];
bool loading=false;
  Future ReceiveBeanRecord() async {

    var api = Uri.parse(
        "https://vinsta.ggggg.in.net/api/userReceivedHistory");
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
      ReceiveBean = res['response_Received'];
      loading = true;
      /* suggestion = false;*/
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
    ReceiveBeanRecord();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return loading?ListView.builder(
        itemCount:ReceiveBean == null ? 0 : ReceiveBean.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              ListTile(
                  leading: ClipOval(
                    child: loading != true
                        ? Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                        : Image.network(
                      ReceiveBean[index]['userphoto']==null?'https://ps.w.org/user-avatar-reloaded/assets/icon-256x256.png?rev=2540745':
          ReceiveBean[index]['userphoto'].toString(),

                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),

                  title:Column(
                    children: [
                      Align(alignment: Alignment.centerLeft,child: Text( ReceiveBean[index]['user_name'])),
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
                          Text(ReceiveBean[index]['created_at'],style: TextStyle(color: Colors.grey,fontSize: 13),)
                        ],
                      ),
                    ],
                  )
              ),
              Divider(color: Colors.grey,thickness: 1,),

            ],
          );

        }):Container(child: Center(child: CircularProgressIndicator(),),);
  }
}
