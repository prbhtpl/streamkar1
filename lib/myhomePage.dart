// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled/screens/homeScreenRelatedScreens/comentPage.dart';
import 'package:untitled/screens/homeScreenRelatedScreens/notificationScreen.dart';
import 'package:untitled/screens/homeScreenRelatedScreens/searchPage.dart';
import 'package:untitled/screens/prifleRelatedScreens/profileInfoScreen.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:documents_picker/documents_picker.dart';
import 'package:http/http.dart' as http;

import 'helper/helperFunctions.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.blue,
                                Colors.black,
                              ],
                              begin: const FractionalOffset(0.0, 0.0),
                              end: const FractionalOffset(1.0, 0.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 250,
                              child: TabBar(
                                isScrollable: true,
                                indicatorWeight: 2,
                                indicatorColor: Colors.white,
                                indicatorSize: TabBarIndicatorSize.label,
                                tabs: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 5, left: 2, right: 2),
                                    child: Text(
                                      'Fresher',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 5, left: 2, right: 2),
                                    child: Text(
                                      'Popular',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 5, left: 2, right: 2),
                                    child: Text(
                                      'Nearby',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 5, left: 2, right: 2),
                                    child: Text(
                                      'Following',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 5, left: 2, right: 2),
                                    child: Text(
                                      'Suggestion',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SearchScreen()));
                                    },
                                    icon: Icon(
                                      CupertinoIcons.search,
                                      color: Colors.white,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  NotificationScreen()));
                                    },
                                    icon: Icon(
                                      CupertinoIcons.bell_solid,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height,
                        child: TabBarView(
                            dragStartBehavior: DragStartBehavior.start,
                            children: [
                              FresherTabView(),
                              Text('2'),
                              Text('3'),
                              Text('4'),
                              Text('5'),
                            ]),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BannerSlider extends StatefulWidget {
  const BannerSlider({
    Key? key,
  }) : super(key: key);

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  String image = '';

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset('assets/043.jpg', fit: BoxFit.fitWidth),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset('assets/3.jpg', fit: BoxFit.fitWidth),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              'assets/4.jpg',
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ],
      options: CarouselOptions(
        enlargeCenterPage: true,
        height: 120.0,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 0.97,
      ),
    );
  }
}

class FresherTabView extends StatefulWidget {
  @override
  State<FresherTabView> createState() => _FresherTabViewState();
}

class _FresherTabViewState extends State<FresherTabView> {
  TextEditingController postText = TextEditingController();
  String ImagelUrl = '';
  List profile = [];
  bool loading = false;
  bool UserImageloading = false;
  List allFollowersposts = [];
  List allFriendsposts = [];

  bool fill = true;
  Future PostComment(
    int following_id,
    int friend_id,
    int postImage_id,
  ) async {
    var api = Uri.parse("https://vinsta.ggggg.in.net/api/otherUserComment");
    var id1 = await HelperFunctions.getVStarUniqueIdkey();
    Map mapeddate = {
      "user_id": id1.toString(),
      "following_id": following_id.toString(),
      "friend_id": friend_id.toString(),
      "postImage_id": postImage_id.toString(),
      "comment": postText.text.toString()
    };

    final response = await http.post(
      api,
      body: mapeddate,
    );

    var res = await json.decode(response.body);
    print("hererere" + response.body);
    setState(() {});
    postText.clear();
    try {
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Comment added');
      }
    } catch (e) {
      print(e);
    }
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
    setState(() {
      profile = res['response_getUserProfile'];
      print(profile);
      if (profile[0]['userphoto'] == null) {
        ImagelUrl =
            'https://ps.w.org/user-avatar-reloaded/assets/icon-256x256.png?rev=2540745'
                .toString();
      } else {
        ImagelUrl = profile[0]['userphoto'].toString();
      }

      print('Image:' + ImagelUrl.toString());
      UserImageloading = true;
    });

    try {
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Updated');
      }
    } catch (e) {
      print(e);
    }
  }

  Future GetFollowingAllPost() async {
    EasyLoading.show(status: 'Updating');
    var api = Uri.parse("https://vinsta.ggggg.in.net/api/followingImages");
    var id1 = await HelperFunctions.getVStarUniqueIdkey();
    Map mapeddate = {
      "user_id": id1.toString(),
    };

    final response = await http.post(
      api,
      body: mapeddate,
    );
    var res = await json.decode(response.body);
    // print("UploadPosts2" + response.body);
    setState(() {
      allFollowersposts = res['response_f_image'];
      loading = true;
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

  Future GetFriedsAllPost() async {
    EasyLoading.show(status: 'Updating');
    var api = Uri.parse("https://vinsta.ggggg.in.net/api/friendsImages");
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
      allFriendsposts = res['response_friend_img'];
      loading = true;
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

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title');
  }

  Future<void> shareFile() async {
    List<dynamic> docs = await DocumentsPicker.pickDocuments;
    if (docs == null || docs.isEmpty) return null;

    await FlutterShare.shareFile(
      title: 'Example share',
      text: 'Example share text',
      filePath: docs[0] as String,
    );
  }

  Future<void> _pullRefresh() async {
    setState(() {
      GetFriedsAllPost();
      GetFollowingAllPost();
    });
  }

  @override
  void initState() {
    GetFriedsAllPost();
    getUserDetails();
    GetFollowingAllPost();
    super.initState();
  }

  @override
  void dispose() {
    postText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: RefreshIndicator(
        onRefresh: _pullRefresh,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              height: 5,
            ),
            BannerSlider(),
            SizedBox(
              height: 5,
            ),
            Container(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount:
                      allFollowersposts == null ? 0 : allFollowersposts.length,
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
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return ProfileInfo();
                                      }));
                                    },
                                    child: ClipOval(
                                      child: loading != true
                                          ? Container(
                                              height: 20,
                                              width: 20,
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : InteractiveViewer(
                                              panEnabled:
                                                  false, // Set it to false
                                              boundaryMargin:
                                                  EdgeInsets.all(100),
                                              minScale: 0.5,
                                              maxScale: 2,
                                              child: Image.network(
                                                allFollowersposts[index]
                                                            ['userphoto'] !=
                                                        null
                                                    ? allFollowersposts[index]
                                                            ['userphoto']
                                                        .toString()
                                                    : "No Image Found",
                                                width: 40,
                                                height: 40,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  // name
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        allFollowersposts[index]['user_name'],
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
                                  onoptionsBottomSheet();
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
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    allFollowersposts[index]['post_image'])),
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
                                  /* fill == false
                                      ? Fluttertoast.showToast(
                                      msg: 'Added to wishlist',
                                      fontSize: 18,
                                      gravity: ToastGravity.BOTTOM)
                                      : Fluttertoast.showToast(
                                      msg: 'Removed from wishlist',
                                      fontSize: 18,
                                      gravity: ToastGravity.BOTTOM);*/
                                });
                              },
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CommentScreen(
                                              id: allFollowersposts[index]
                                                  ['id'],
                                              followingId:
                                                  allFollowersposts[index]
                                                      ['following_id'],
                                              friendId: 0,
                                            )));
                              },
                              icon: Icon(Icons.chat_bubble_outline),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  onshareBottomSheet();
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
                                    text:
                                        '${allFollowersposts[index]['user_name']}  ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: allFollowersposts[index]['content']),
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
                              ClipOval(
                                child: UserImageloading != true
                                    ? Container(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(),
                                      )
                                    : Image.network(
                                        ImagelUrl != null
                                            ? ImagelUrl.toString()
                                            : 'NoImage found',
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              Container(
                                height: 30,
                                width: 260,
                                child: TextFormField(
                                  controller: postText,
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
                              TextButton(
                                onPressed: () {
                                  postText.text.toString().isNotEmpty
                                      ? PostComment(
                                          allFollowersposts[index]
                                              ['following_id'],
                                          0,
                                          allFollowersposts[index]['id'])
                                      : print('null');
                                },
                                child: Text(
                                  'post',
                                  style:
                                      TextStyle(color: Colors.lightBlueAccent),
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
                        )
                      ],
                    );
                  }),
            ),
            /*Friends Post List Starting*/
            Container(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount:
                      allFriendsposts == null ? 0 : allFriendsposts.length,
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
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return ProfileInfo();
                                      }));
                                    },
                                    child: InteractiveViewer(constrained: false,
                                      panEnabled:
                                      false, // Set it to false
                                      boundaryMargin:
                                      EdgeInsets.all(100),
                                      minScale: 0.5,
                                      maxScale: 2,
                                      child: ClipOval(
                                        child: loading != true
                                            ? Container(
                                                height: 20,
                                                width: 20,
                                                child:
                                                    CircularProgressIndicator(),
                                              )
                                            : InteractiveViewer(constrained: false,
                                                panEnabled:
                                                    false, // Set it to false
                                                boundaryMargin:
                                                    EdgeInsets.all(100),
                                                minScale: 0.5,
                                                maxScale: 2,
                                                child: Image.network(
                                                  allFriendsposts[index]
                                                              ['userphoto'] !=
                                                          null
                                                      ? allFriendsposts[index]
                                                              ['userphoto']
                                                          .toString()
                                                      : "No Image Found",
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        allFriendsposts[index]['user_name'],
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
                                  onoptionsBottomSheet();
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
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    allFriendsposts[index]['post_image'])),
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
                                  /* fill == false
                                      ? Fluttertoast.showToast(
                                      msg: 'Added to wishlist',
                                      fontSize: 18,
                                      gravity: ToastGravity.BOTTOM)
                                      : Fluttertoast.showToast(
                                      msg: 'Removed from wishlist',
                                      fontSize: 18,
                                      gravity: ToastGravity.BOTTOM);*/
                                });
                              },
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CommentScreen(
                                              id: allFriendsposts[index]['id'],
                                              friendId: allFriendsposts[index]
                                                  ['friend_id'],
                                              followingId: 0,
                                            )));
                              },
                              icon: Icon(Icons.chat_bubble_outline),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  onshareBottomSheet();
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
                                    text:
                                        '${allFriendsposts[index]['user_name']}  ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: allFriendsposts[index]['content']),
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
                              ClipOval(
                                child: UserImageloading != true
                                    ? Container(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(),
                                      )
                                    : Image.network(
                                        ImagelUrl != null
                                            ? ImagelUrl.toString()
                                            : "No Image Found",
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              Container(
                                height: 30,
                                width: 260,
                                child: TextFormField(
                                  controller: postText,
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
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    /* print('allFollowersposts[index][]:' +
                                        allFollowersposts[index]
                                            ['following_id']);*/
                                    PostComment(
                                        0,
                                        allFriendsposts[index]['friend_id'],
                                        allFriendsposts[index]['id']);
                                  });
                                  /*    postText.clear();*/
                                },
                                child: Text(
                                  'post',
                                  style:
                                      TextStyle(color: Colors.lightBlueAccent),
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
                        )
                      ],
                    );
                  }),
            ),
            /*Friends Post List Ending*/
            SizedBox(
              height: 180,
            ),
          ],
        ),
      ),
    );
  }

  void onoptionsBottomSheet() {
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
                                    child: Icon(
                                      CupertinoIcons.exclamationmark_bubble,
                                      color: Colors.red,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Report',
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

  void onshareBottomSheet() {
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
                    height: MediaQuery.of(context).size.height * 0.75,
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(25.0),
                        topRight: const Radius.circular(25.0),
                      ),
                    ),
                    child: Column(
                      children: [
                        Divider(
                          thickness: 5,
                          indent: 160,
                          endIndent: 160,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10.0, top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage('assets/2.jpg')),
                                ),
                              ),
                              Container(
                                height: 45,
                                width: 300,
                                child: TextField(
                                  maxLines: 5,
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
                                      hintText: 'Write a message',
                                      hintStyle: TextStyle(
                                          fontSize: 12, color: Colors.grey)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.face_rounded,
                                color: Colors.orange,
                              ),
                              Icon(
                                CupertinoIcons.heart_solid,
                                color: Colors.red,
                              ),
                              Icon(
                                Icons.face_rounded,
                                color: Colors.orange,
                              ),
                              Icon(
                                CupertinoIcons.heart_solid,
                                color: Colors.red,
                              ),
                              Icon(
                                Icons.face_rounded,
                                color: Colors.orange,
                              ),
                              Icon(
                                CupertinoIcons.heart_solid,
                                color: Colors.red,
                              ),
                              Icon(
                                Icons.face_rounded,
                                color: Colors.orange,
                              ),
                              Icon(
                                Icons.face_rounded,
                                color: Colors.orange,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width,
                          child: TextField(
                            decoration: InputDecoration(
                                prefixIcon: Icon(CupertinoIcons.search),
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
                                hintText: 'Search',
                                hintStyle: TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage('assets/2.jpg')),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {},
                                child: Text(
                                  'Add reel to your story',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                            child: ListView.builder(
                                itemCount: 50,
                                itemBuilder: (BuildContext, int index) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ProfileInfo()));
                                                  },
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey[300],
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: AssetImage(
                                                              'assets/2.jpg')),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      'name',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      'name',
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                                height: 25,
                                                child: ElevatedButton(
                                                    onPressed: () {},
                                                    child: Text('Send')))
                                          ],
                                        ),
                                      )
                                    ],
                                  );
                                }))
                      ],
                    ),
                  );
                });
              });
        });
  }
}
