// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled/screens/homeScreenRelatedScreens/comentPage.dart';
import 'package:untitled/screens/homeScreenRelatedScreens/notificationScreen.dart';
import 'package:untitled/screens/homeScreenRelatedScreens/searchPage.dart';
import 'package:untitled/screens/prifleRelatedScreens/profileInfoScreen.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:documents_picker/documents_picker.dart';

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

  bool fill = true;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                itemCount: 5,
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
                                  child: Container(
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
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                // name
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "name",
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
                        height: 260,
                        //color: Colors.grey[300],
                        decoration: BoxDecoration(
                          //color: Colors.grey[300],
                          //shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/2.jpg')),
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
                                      builder: (context) => CommentScreen()));
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
                                  text: "name",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text:
                                      ' i turn the dirt they throwing into riches til im filthy'),
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
                                    image: AssetImage('assets/2.jpg')),
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
                      )
                    ],
                  );
                }),
          ),
          SizedBox(
            height: 180,
          ),
        ],
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
