import 'dart:convert';
import 'dart:io';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:untitled/helper/helperFunctions.dart';
import 'package:untitled/screens/prifleRelatedScreens/editphotoScreen.dart';
import 'package:untitled/screens/prifleRelatedScreens/profileInfoScreen.dart';
import 'package:untitled/screens/prifleRelatedScreens/settingPage.dart';
import 'package:untitled/screens/prifleRelatedScreens/topUpScreen.dart';
import '../homeScreenRelatedScreens/Post RelatedPages/comentPage.dart';
import 'YourPost/currentUserPost.dart';
import 'followersList.dart';
import 'followingList.dart';
import 'friendList.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? imageFile;
  String name = '';
  String vId = '';
  String region = '';
  String ImagelUrl = '';
  List profile = [];
  List Postlist = [];
  bool loading = false;
  int followingCount = 0;
  int friendsCount = 0;
  int? id;
  String _name = '';

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

  Future GetFollowingCount() async {
    EasyLoading.show(status: 'Updating');
    var api = Uri.parse("https://vinsta.ggggg.in.net/api/following_count");
    var id1 = await HelperFunctions.getVStarUniqueIdkey();
    Map mapeddate = {
      "user_id": id1.toString(),
    };

    final response = await http.post(
      api,
      body: mapeddate,
    );
    var res = await json.decode(response.body);
    print("UploadPosts2" + response.body);
    setState(() {
      followingCount = res['response_following_count'];
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

  Future GetFriendsCount() async {
    EasyLoading.show(status: 'Searching...');
    var api = Uri.parse("https://vinsta.ggggg.in.net/api/friends_count");
    var id1 = await HelperFunctions.getVStarUniqueIdkey();
    Map mapeddate = {
      "user_id": id1.toString(),
    };

    final response = await http.post(
      api,
      body: mapeddate,
    );
    var res = await json.decode(response.body);
    print("UploadPosts2" + response.body);
    setState(() {
      friendsCount = res['response_friends_count'];
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

  Future<void> _CameraGalleryDialogue(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          actions: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                          this.context,
                          MaterialPageRoute(
                              builder: (context) => EditPic(
                                  imageFile: imageFile,
                                  source: ImageSource.camera)));
                      // pickImage(ImageSource.camera);
                    });
                  },
                  child: Row(
                    children: [
                      Text(
                        'Camera',
                        style: TextStyle(color: Colors.black),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              Navigator.push(
                                  this.context,
                                  MaterialPageRoute(
                                      builder: (context) => EditPic(
                                          imageFile: imageFile,
                                          source: ImageSource.camera)));
                              // pickImage(ImageSource.camera);
                            });
                          },
                          icon: Icon(
                            Icons.add_a_photo,
                            color: Colors.grey,
                          ))
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white, elevation: 0),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                          this.context,
                          MaterialPageRoute(
                              builder: (context) => EditPic(
                                  imageFile: imageFile,
                                  source: ImageSource.gallery)));
                      // pickImage(ImageSource.gallery);
                    });
                  },
                  child: Row(
                    children: [
                      Text(
                        'Choose From Gallery',
                        style: TextStyle(color: Colors.black),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              Navigator.push(
                                  this.context,
                                  MaterialPageRoute(
                                      builder: (context) => EditPic(
                                          imageFile: imageFile,
                                          source: ImageSource.gallery)));

                              //  pickImage(ImageSource.gallery);
                            });
                          },
                          icon: Icon(
                            CupertinoIcons.camera_on_rectangle_fill,
                            color: Colors.grey,
                          ))
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white, elevation: 0),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  Future getUserDetails() async {
    var api = Uri.parse("https://vinsta.ggggg.in.net/api/profileGet");
    var id1 = await HelperFunctions.getVStarUniqueIdkey();
    Map mapeddate = {"user_id": id1.toString()};

    final response = await http.post(
      api,
      body: mapeddate,
    );

    var res = await json.decode(response.body);
    print("hererere" + response.body);
    setState(() { loading = true;
      profile = res['response_getUserProfile'];
      print(profile);
    if( profile[0]['userphoto']==null){
      ImagelUrl= 'https://ps.w.org/user-avatar-reloaded/assets/icon-256x256.png?rev=2540745'.toString();
    }else{ ImagelUrl = profile[0]['userphoto'].toString();


    }
   /*  ImagelUrl = profile[0]['userphoto'].toString();*/
     name = profile[0]['user_name'].toString();
     region = profile[0]['region'].toString();
      vId = profile[0]['user_code'].toString();

    });

    try {
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Updated');
      }
    } catch (e) {
      print(e);
    }
  }

  Future getPostPics() async {
    var api = Uri.parse("https://vinsta.ggggg.in.net/api/ImageTextGet");
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
      Postlist = res['response_getImagetext'];
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
    getPostPics();
    getallPreferences();
    GetFollowingCount();
    GetFriendsCount();
    getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SlidingUpPanel(
          renderPanelSheet: true,
          maxHeight: MediaQuery.of(context).size.height,
          minHeight: MediaQuery.of(context).size.height * 0.455,
          panel: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 80.0),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/nuts.png',
                          scale: 6.5,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '0',
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, right: 80.0),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/diamond.png',
                          scale: 8,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '0',
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FriendListScreen()));
                    },
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, right: 8.0, left: 25.0),
                          child: Text(
                            friendsCount.toString(),
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 18.0, right: 8.0, left: 25.0),
                          child: Text(
                            'Friends',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FollowersScreen()));
                    },
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, right: 8.0, left: 8.0),
                          child: Text(
                            '489',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 18.0, right: 8.0, left: 8.0),
                          child: Text(
                            'Followers',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FollowingScreen()));
                      },
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, right: 25.0, left: 8.0),
                            child: Text(
                              followingCount.toString(),
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 18.0, right: 25.0, left: 8.0),
                            child: Text(
                              'Following',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.orange.shade500,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.white),
                                    ),
                                    child: IconButton(
                                      icon: Icon(
                                        CupertinoIcons.bitcoin_circle_fill,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TopUpScreen()));
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 80,
                                    child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      TopUpScreen()));
                                        },
                                        child: Text('Top Up')),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.yellow.shade500,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.white),
                                    ),
                                    child: Icon(
                                      CupertinoIcons.suit_diamond_fill,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(width: 80, child: Text('earings')),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade200,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.white),
                                    ),
                                    child: Icon(
                                      CupertinoIcons.calendar_badge_minus,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(width: 80, child: Text('My Tasks')),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.deepPurpleAccent.shade200,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.white),
                                    ),
                                    child: Icon(
                                      CupertinoIcons
                                          .square_stack_3d_down_dottedline,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(width: 80, child: Text('Vip')),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),
              Text(
                'Moments',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                          width: 80,
                          height: 80,
                          color: Colors.grey.shade200,
                          child: IconButton(
                            icon: Icon(
                              CupertinoIcons.add,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              _CameraGalleryDialogue(context);
                            },
                          )),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          child: ListView.builder(
                              itemCount: Postlist == null ? 0 : Postlist.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CurrentUserAllPostScreens()));
                                        },
                                        child: Container(
                                            width: 80,
                                            height: 80,
                                            color: Colors.grey.shade200,
                                            child: Image(
                                              image: NetworkImage(
                                                  Postlist[index]
                                                      ['post_image']),
                                              fit: BoxFit.fill,
                                            )),
                                      ),
                                    ],
                                  ),
                                );
                              })),
                    ],
                  ),
                ),
              ),
              //StorLine(context)
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF9D6EF7),
                        Colors.lightBlueAccent.shade200
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(0.9, 0.2),
                      stops: [0.0, 1.0],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SettingScreen()));
                          },
                          icon: Icon(
                            CupertinoIcons.settings_solid,
                            color: Colors.white,
                          ))
                    ],
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.78,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Colors.lightBlueAccent.shade200,
                              Colors.black12,
                              Color(0xFF9D6EF7),
                              Colors.lightBlueAccent.shade200,
                              Color(0xFF9D6EF7),
                              Color(0xFF9D6EF7),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Center(
                              child: ClipOval(
                                child: loading != true
                                    ? Container(
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      )
                                    : Image.network(
                                        ImagelUrl != null
                                            ? ImagelUrl.toString()
                                            : 'No Image Found',
                                        width: 130,
                                        height: 130,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            name.toString(),
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                vId.toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                region.toString(),
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 120.0, right: 120),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      color: Colors.lightGreen,
                                      borderRadius: BorderRadius.circular(5),
                                      border:
                                          Border.all(color: Colors.lightGreen)),
                                  child: Text(
                                    'Lv 1',
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.white),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      color: Colors.yellow.shade200,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Colors.yellow.shade200)),
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
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    CupertinoIcons.forward_end_alt_fill,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    //   Navigator.push(context, MaterialPageRoute(builder: (context)=>DeepAr()));
                                  },
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}
