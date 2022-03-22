// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';

import 'package:marquee_widget/marquee_widget.dart';
import 'package:untitled/screens/homeScreenRelatedScreens/notificationScreen.dart';
import 'package:untitled/screens/prifleRelatedScreens/profileInfoScreen.dart';
import 'package:untitled/screens/reelSectionPages/songSection.dart';

import 'package:video_player/video_player.dart';

class ReelVideos extends StatefulWidget {
  const ReelVideos({Key? key}) : super(key: key);

  @override
  _ReelVideosState createState() => _ReelVideosState();
}

class _ReelVideosState extends State<ReelVideos> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
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
                              colors: [Colors.orangeAccent, Colors.blue],
                              begin: const FractionalOffset(0.0, 0.0),
                              end: const FractionalOffset(0.5, 0.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 280,
                              child: TabBar(
                                isScrollable: true,
                                indicatorWeight: 2,
                                indicatorColor: Colors.white,
                                indicatorSize: TabBarIndicatorSize.label,
                                tabs: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Status',
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Squad',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      CupertinoIcons.search,
                                      color: Colors.white,
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: IconButton(
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationScreen()));
                                        
                                      },
                                      icon: Icon(
                                       CupertinoIcons.bell_solid,
                                        color: Colors.white,
                                      )),
                                ),
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
                              Status(),
                              Text('2'),
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

class Status extends StatefulWidget {
  @override
  State<Status> createState() => _StatusState();
}

class _StatusState extends State<Status> {
  VideoPlayerController? _controller;
  @override
  void initState() {
    _controller = VideoPlayerController.asset('assets/reel.mp4')
      ..initialize().then((_) {
        _controller?.play();
        _controller?.setLooping(true);
        // Ensure the first frame is shown after the video is initialized
        setState(() {});
      });
    super.initState();
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title');
  }

  bool fill = true;
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: 100,
      controller: PageController(
        initialPage: 0,
        keepPage: true,
      ),
      itemBuilder: (BuildContext context, int itemIndex) {
        return SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  SizedBox.expand(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: _controller?.value.size.width,
                        height: _controller?.value.size.height,
                        child: VideoPlayer(_controller!),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          CupertinoIcons.camera,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              children: [
                                InkWell(onTap:(){},
                                  child: Icon(
                                    CupertinoIcons.add_circled_solid,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  'Follow',
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  height: 15,
                                ),


                                InkWell(onTap: (){
                                setState(() {
                                  fill = !fill;
                                });
                                },
                                  child: fill
                                      ? Icon(
                                    CupertinoIcons.heart,
                                   color: Colors.white,
                                  )
                                      : Icon(
                                    CupertinoIcons.heart_solid,
                                    color: Colors.red,

                                  ),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  '149k',
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                InkWell(
                                  onTap: () {
                                    onCommentBottomSheet();
                                  },
                                  child: Icon(
                                    CupertinoIcons.conversation_bubble,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  '149k',
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  height: 15,
                                ),


                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10.0,
                          right: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                  /*  Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProfileInfo()));*/
                                  },
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(100),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage('assets/2.jpg')),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'sheThetTroublemaker_',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                onoptionsBottomSheet();
                              },
                              child: Icon(
                                CupertinoIcons.line_horizontal_3,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10,left: 10.0,right: 10.0),
                        child: Row(mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Content Text',style: TextStyle(color: Colors.white),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10, top: 5, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: [
                                Icon(
                                  CupertinoIcons.chart_bar_alt_fill,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: 150,
                                  child: Marquee(
                                      animationDuration:
                                          const Duration(seconds: 5),
                                      backDuration:
                                          const Duration(milliseconds: 500),
                                      autoRepeat: true,
                                      directionMarguee:
                                          DirectionMarguee.oneDirection,
                                      child: Text(
                                        'Country Songs with a Name in the Title.',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  CupertinoIcons.location_solid,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                Text(
                                  'Manali, Himachal',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            InkWell(onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Songscreen()));
                            },
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(8),
                                  border:
                                      Border.all(color: Colors.white, width: 4),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage('assets/2.jpg')),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 140,
                      )
                    ],
                  ),
                ],
              )),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
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
                    height: 260,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Divider(
                          thickness: 5,
                          indent: 180,
                          endIndent: 180,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 35,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 10, top: 5, bottom: 5),
                              child: Text("Report..."),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 35,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 10, top: 5, bottom: 5),
                              child: Text("Not Interested"),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(

                                height: 35,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 10, top: 5, bottom: 5),
                                  child: Text("Download"),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 10, top: 5, bottom: 5),
                                child: Icon(CupertinoIcons.arrow_down_circle),
                              )
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            share();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 35,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 10, top: 5, bottom: 5),
                              child: Text("Share to..."),
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

  /*void onshareBottomSheet() {
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
  }*/

  void onCommentBottomSheet() {
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
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: TextField(
                                      decoration: InputDecoration(
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            // width: 0.0 produces a thin "hairline" border
                                            borderSide: const BorderSide(
                                                color: Colors.white,
                                                width: 0.0),
                                          ),
                                          contentPadding: EdgeInsets.only(
                                              top: 10, left: 10),
                                          fillColor: Colors.white,
                                          filled: true,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              15,
                                            ),
                                          ),
                                          hintText: 'Comment as prbhhtpl',
                                          hintStyle: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey)),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Text(
                                      'post',
                                      style: TextStyle(
                                          color: Colors.lightBlueAccent),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: 50,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    ListTile(
                                        leading: InkWell(
                                          onTap: () {
                                        /*    Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProfileInfo()));*/
                                          },
                                          child: Stack(children: [
                                            CircleAvatar(
                                                child: Image.asset(
                                                    'assets/person.jpg')),
                                            Container(
                                              width: 10,
                                              height: 10,
                                              decoration: BoxDecoration(
                                                color: Colors.purple,
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                border: Border.all(
                                                    color: Colors.white),
                                              ),
                                              child: Icon(
                                                CupertinoIcons
                                                    .person_alt_circle,
                                                color: Colors.white,
                                                size: 8,
                                              ),
                                            ),
                                          ]),
                                        ),
                                        trailing: ButtonTheme(
                                          minWidth: 12,
                                          height: 14,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                          ),
                                          child: IconButton(
                                            icon: fill
                                                ? Icon(
                                                    CupertinoIcons.heart,
                                                    size: 18,
                                                  )
                                                : Icon(
                                                    CupertinoIcons.heart_solid,
                                                    color: Colors.red,
                                                    size: 18,
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
                                        ),
                                        title: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text("Emil 554")),
                                            Icon(
                                              Icons.face_rounded,
                                              color: Colors.orange,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '$index h',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 10),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                InkWell(
                                                    onTap: () {},
                                                    child: Text(
                                                      'Likes',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 10),
                                                    )),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                InkWell(
                                                    onTap: () {},
                                                    child: Text(
                                                      'Reply',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 10),
                                                    )),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Divider(
                                      color: Colors.grey,
                                      thickness: 1,
                                    )
                                  ],
                                );
                              }),
                        )
                      ],
                    ),
                  );
                });
              });
        });
  }
}
