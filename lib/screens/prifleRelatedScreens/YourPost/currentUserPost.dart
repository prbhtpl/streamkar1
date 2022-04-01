

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/bottomNavigationBar/bottomNavigation.dart';
import '../../../helper/helperFunctions.dart';
import '../../homeScreenRelatedScreens/Post RelatedPages/comentPage.dart';
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
  bool loading =false; bool fill = true;
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
  Future deletePost(int picId) async {
    var api = Uri.parse("https://vinsta.ggggg.in.net/api/imagepostDelete");
 /*   EasyLoading.show(status: 'Updating');*/
    var id1 = await HelperFunctions.getVStarUniqueIdkey();
    Map mapeddate = {"user_id": id1.toString(),"id":picId.toString()
    };

    final response = await http.post(
      api,
      body: mapeddate,
    );

    var res = await json.decode(response.body);
    /*print("UploadPosts" + response.body);*/
    setState(() {
     getAllPost();
    });

    try {
      if (response.statusCode == 200) {
      /*  EasyLoading.dismiss();*/
    /*    Fluttertoast.showToast(msg: 'Updated');*/
      }else{
            Fluttertoast.showToast(msg: 'Something went wrong');
      }
    } catch (e) {
      print(e);
    }
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
    /*print("UploadPosts" + response.body);*/
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
  Future<void> share() async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title');
  }

  @override
  void initState() {getAllPost();
  getUserDetails();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: ()async{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavigation(screenId: 4)));
      return Future.value(false);
    },
      child: Scaffold(
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
                            IconButton(icon:  Icon(Icons.more_vert),onPressed: (){
                              onoptionsBottomSheet(Postlist[index]['id']);
                            },)
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
                          /*IconButton(
                            onPressed: () {
                              setState(() {
                                //onshareBottomSheet();
                              });
                            },
                            icon: Icon(
                              CupertinoIcons.paperplane,
                            ),
                          ),*/
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
      ),
    );
  }
  void onoptionsBottomSheet(int imageId) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (context) {
          return BottomSheet(
              onClosing: () {},
              builder: (BuildContext context) {
                return StatefulBuilder(
                    builder: (BuildContext context, setState) {
                      return Container(
                        height: 300,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(
                              thickness: 5,
                              indent: 160,
                              endIndent: 160,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, bottom: 8.0, left: 50, right: 50),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100),
                                          border: Border.all(
                                              color: Colors.grey, width: 1),
                                        ),
                                        child: IconButton(
                                            icon: Icon(CupertinoIcons.link),
                                            onPressed: () {
                                              Fluttertoast.showToast(
                                                  gravity: ToastGravity.CENTER,
                                                  msg: 'Link Copied!');
                                            }),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text('Link')
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100),
                                          border: Border.all(
                                              color: Colors.grey, width: 1),
                                        ),
                                        child: IconButton(
                                            icon: Icon(Icons.share),
                                            onPressed: () {
                                              share();
                                            }),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text('Share')
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100),
                                          border: Border.all(
                                              color: Colors.red, width: 1),
                                        ),
                                        child: IconButton(onPressed: (){
Navigator.pop(context);deletePost(imageId);

                                        },
                                        icon: Icon(
                                          CupertinoIcons.delete,
                                          color: Colors.red,
                                        ),),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Delete',
                                        style: TextStyle(color: Colors.red),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 35,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 10, top: 5, bottom: 5),
                                  child: Text("Why your're seeing this post"),
                                ),
                              ),
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 35,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 10, top: 5, bottom: 5),
                                  child: Text("Hide"),
                                ),
                              ),
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 35,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 10, top: 5, bottom: 5),
                                  child: Text("Unfollow"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              });
        });
  }
}
