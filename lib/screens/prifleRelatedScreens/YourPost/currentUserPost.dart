

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import '../../../helper/helperFunctions.dart';
import '../../homeScreenRelatedScreens/comentPage.dart';
import '../profileInfoScreen.dart';
class CurrentUserAllPostScreens extends StatefulWidget {
  const CurrentUserAllPostScreens({Key? key}) : super(key: key);

  @override
  State<CurrentUserAllPostScreens> createState() => _CurrentUserAllPostScreensState();
}

class _CurrentUserAllPostScreensState extends State<CurrentUserAllPostScreens> {
  int? id;
  String name = '';
  String vId = '';
  String region = '';
  String ImagelUrl = '';
  bool loading =false;
  String _name = ''; List Postlist = [];List profile = [];
  Future getUserDetails() async {
    EasyLoading.show(status: 'Updating');
    var api = Uri.parse("https://vinsta.ggggg.in.net/api/profileGet");
    var id1 = await HelperFunctions.getVStarUniqueIdkey();
    Map mapeddate = {"user_id": id1.toString()};

    final response = await http.post(
      api,
      body: mapeddate,
    );

    var res = await json.decode(response.body);
    print("hererere" + response.body);
    setState(() {
      profile = res['response_getUserProfile'];
      print(profile);
      ImagelUrl=profile[0]['userphoto'].toString();
      name = profile[0]['user_name'].toString();
      region = profile[0]['region'].toString();
      vId = profile[0]['user_code'].toString();
 loading=true;
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
  getallPreferences() async {
    var userDetails = await HelperFunctions.getVStarUniqueIdkey();
    var name = await HelperFunctions.getuserNameSharedPreference();
    setState(() {
      id = userDetails;
      print(id.toString());

      _name = name;
      print(_name.toString());
    });
  }
  Future getAllPost() async {
    var api = Uri.parse("https://vinsta.ggggg.in.net/api/ImageTextGet");
    EasyLoading.show(status: 'Updating');
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
      Postlist=res['response_getImagetext'];
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
  Future<void> _pullRefresh() async {
   setState(() {
     getAllPost();
   });
  }

  bool fill = true;
  @override
  void initState() {getAllPost();
  getUserDetails();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.deepPurple,
        title: Text('Posts'),centerTitle: true,
      ),
      body:    RefreshIndicator(child:   Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: ListView.builder(
              shrinkWrap: true,

              itemCount: Postlist == null
                  ? 0
                  : Postlist.length,
              itemBuilder: (BuildContext, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 16, top: 5, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              // profile photo
                              InkWell(
                                onTap: () {
                                  /* Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                        return ProfileInfo();
                                      }));*/
                                },
                                child:   Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Center(
                                    child: ClipOval(
                                      child:loading!=true?Container(height:20,width:20,child: CircularProgressIndicator(),): Image.network(
                                        ImagelUrl!=null?ImagelUrl.toString():"No Image Found",
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              // name
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Lucknow, Uttar Pradesh",
                                    style: TextStyle(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          InkWell(
                            child: Icon(Icons.more_vert),
                            onTap: () {
                              // onoptionsBottomSheet();
                            },
                          )
                        ],
                      ),
                    ),

                    // post
                    Container(
                      height: 450,
                      //color: Colors.grey[300],
                      decoration: BoxDecoration(
                        //color: Colors.grey[300],
                        //shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.fitHeight,
                            image: NetworkImage( Postlist[index]['post_image'])),
                      ),
                    ),

                    // below the post -> buttons and comments
                    Row(
                      children: [
                        IconButton(
                          icon: fill
                              ? FaIcon(FontAwesomeIcons.heart)
                              : FaIcon(
                            FontAwesomeIcons.solidHeart,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            fill = !fill;

                            setState(() {

                            });
                          },
                        ),
                        IconButton(
                          onPressed: () {
                          /*  Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CommentScreen()));*/
                          },
                          icon: Icon(Icons.chat_bubble_outline),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              //onshareBottomSheet();
                            });
                          },
                          icon: Icon(
                            CupertinoIcons.paperplane,
                          ),
                        ),
                      ],
                    ),

                    // like by...
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Row(children: [
                        Text('Liked by '),
                        Text(
                          'mitchkoko',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(' and '),
                        Text(
                          '10,980 others',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ]),
                    ),

                    // caption
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 8),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                                text: name.toString(),
                                style:
                                TextStyle(fontWeight: FontWeight.bold)),

                            TextSpan(
                                text:
                                "   "+Postlist[index]['content']),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 8),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                                text: "view all 95 comments",
                                style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(ImagelUrl)),
                            ),
                          ),
                          Container(
                            height: 30,
                            width: 280,
                            child: TextField(
                              decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    // width: 0.0 produces a thin "hairline" border
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 0.0),
                                  ),
                                  contentPadding:
                                  EdgeInsets.only(top: 10, left: 10),
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      15,
                                    ),
                                  ),
                                  hintText: 'Add a comment',
                                  hintStyle: TextStyle(
                                      fontSize: 12, color: Colors.grey)),
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              'post',
                              style: TextStyle(color: Colors.lightBlueAccent),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, top: 2, bottom: 10),
                      child: Text(
                        '41 minutes ago',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                    Divider(indent: 20,endIndent: 20,),
                    SizedBox(height: 10,)
                  ],
                );
              }),
        ),
      ),onRefresh: _pullRefresh,),
    );
  }
}
