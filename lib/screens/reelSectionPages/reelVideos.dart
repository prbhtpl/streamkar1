// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:marquee_widget/marquee_widget.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:untitled/screens/homeScreenRelatedScreens/notificationScreen.dart';

import 'package:untitled/screens/reelSectionPages/songSection.dart';

import 'package:video_player/video_player.dart';

import '../../helper/helperFunctions.dart';

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
  TextEditingController Comment = TextEditingController();
  String firstVideoUrl =
      'https://vinsta.ggggg.in.net/public/videosfile/1648020077.mp4';
  List Reel = [];
  List profile = [];
  List LikkeStatus = [];
  List PCommentList=[];
  int status = 0;
  int CommentLikestatus = 0;
  var TotalCount = '';
  var TotalCommentCount = '';
  var VideoId = 0;
  String name = '';
  String ImagelUrl = '';
  bool loading = false;

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title');
  }

  Future PostLikeUnlike(int video_ID, int statusLike) async {
    var id1 = await HelperFunctions.getVStarUniqueIdkey();

    /* EasyLoading.show(status: 'Loading...');*/
    var api = Uri.parse("https://vinsta.ggggg.in.net/api/likeVideo");

    /*  print("id1" + id1.toString());
    print("video_id" + video_ID.toString());
    print("status_vilike" + statusLike.toString());*/

    Map mapeddate = {
      "userlike_id": id1.toString(),
      "video_id": video_ID.toString(),
      "status_vilike": statusLike.toString()
    };

    final response = await http.post(
      api,
      body: mapeddate,
    );

    var res = await json.decode(response.body);
    /*print("hererere" + response.body);*/
    setState(() {
      ReelsList();
    });

    try {
      if (response.statusCode == 200) {
        /*  EasyLoading.dismiss();*/
        Fluttertoast.showToast(msg: 'Updated');
      }
    } catch (e) {
      print(e);
    }
  }

  Future GetLikeUnLike() async {
    VideoId = await HelperFunctions.getVedioID();

    EasyLoading.show(status: 'Loading...');

    var api = Uri.parse("https://vinsta.ggggg.in.net/api/likeOnVideo");
    /*print("id"+PostLikeCount.toString());*/
    var id1 = await HelperFunctions.getVStarUniqueIdkey();
    Map mapeddate = {
      "id": VideoId.toString(),
      "user_id": id1.toString(),
    };

    final response = await http.post(
      api,
      body: mapeddate,
    );

    var res = await json.decode(response.body);
    print("hererere" + response.body);
    setState(() {
      LikkeStatus = res['response_likeonvideo'];
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

  Future<void> _initController(int index) async {
    /* var controller = VideoPlayerController.network(_urls.elementAt(index));
    _controllers[_urls.elementAt(index)] = controller;*/ /*
    await controller.initialize();*/
  }
  Future ReelsList() async {
    EasyLoading.show(status: 'Loading...');
    var api = Uri.parse("https://vinsta.ggggg.in.net/api/videoList");
    var id1 = await HelperFunctions.getVStarUniqueIdkey();
    Map mapeddate = {
      "user_id": id1.toString(),
    };

    final response = await http.post(
      api,
      body: mapeddate,
    );

    var res = await json.decode(response.body);
    /* print("hererere" + response.body);*/

    try {
      if (response.statusCode == 200) {
        EasyLoading.dismiss();

        setState(() {
          Reel = res['response_videoList'];
          loading = true;

           // firstVideoUrl=Reel[0]['video'];
          //print("firstVideoUrl"+firstVideoUrl);
        });
        await HelperFunctions.saveuserVideoId(Reel[0]['id']);
      //  initVideo();
        LikeCount();
        GetLikeUnLike();PostCommentList(VideoId);

        print('id' + Reel[0]['id']);
        Fluttertoast.showToast(msg: 'Updated');
      }
    } catch (e) {
      print(e);
    }
  }

  Future CommentOnPost(
    int video_ID,
  ) async {
    print("video_ID" + video_ID.toString());
    var id1 = await HelperFunctions.getVStarUniqueIdkey();
    print("video_ID" + id1.toString());

    /* EasyLoading.show(status: 'Loading...');*/
    var api = Uri.parse("https://vinsta.ggggg.in.net/api/commentVideo");

    Map mapeddate = {
      "usercomment_id": id1.toString(),
      "video_id": video_ID.toString(),
      "videocomment": Comment.text
    };

    final response = await http.post(
      api,
      body: mapeddate,
    );

    var res = await json.decode(response.body);
    print("hererere" + response.body);
    setState(() {
      Comment.clear();
     CommentCount();
    });

    try {
      if (response.statusCode == 200) {
        /*  EasyLoading.dismiss();*/
        Fluttertoast.showToast(msg: 'Updated');
      }
    } catch (e) {
      print(e);
    }
  }

  Future LikeCount() async {
    VideoId = await HelperFunctions.getVedioID();

    EasyLoading.show(status: 'Loading...');

    var api = Uri.parse("https://vinsta.ggggg.in.net/api/videoLikecount");
    /*print("id"+PostLikeCount.toString());*/
    // var id1 = await HelperFunctions.getVStarUniqueIdkey();
    Map mapeddate = {"id": VideoId.toString()};

    final response = await http.post(
      api,
      body: mapeddate,
    );

    var res = await json.decode(response.body);
    // print("hererere" + response.body);
    setState(() {
      TotalCount = res['response_videolikecount'].toString();
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

  Future CommentCount() async {
    VideoId = await HelperFunctions.getVedioID();

    EasyLoading.show(status: 'Loading...');

    var api = Uri.parse("https://vinsta.ggggg.in.net/api/videoCommentcount");
    /*print("id"+PostLikeCount.toString());*/
    // var id1 = await HelperFunctions.getVStarUniqueIdkey();
    Map mapeddate = {"id": VideoId.toString()};
    print("VideoId::" + VideoId.toString());
    final response = await http.post(
      api,
      body: mapeddate,
    );

    var res = await json.decode(response.body);
    print("hererere" + response.body);
    setState(() {
      TotalCommentCount = res['response_videocommentcount'].toString();
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

  Future CommentLikeUnlike(int CommentId, int statusLike,int videoId) async {
    /* EasyLoading.show(status: 'Loading...');*/
    var api = Uri.parse("https://vinsta.ggggg.in.net/api/videoCommentLike");

    var id1 = await HelperFunctions.getVStarUniqueIdkey();

    Map mapeddate = {
      "vcomment_id": CommentId.toString(),
      "user_id": id1.toString(),
      "video_id": videoId.toString(),
      "status_comlike": statusLike.toString()
    };

    final response = await http.post(
      api,
      body: mapeddate,
    );

    var res = await json.decode(response.body);
    print("laparwah" + response.body);
    setState(() {

    });

    try {
      if (response.statusCode == 200) {
        /*  EasyLoading.dismiss();*/
        Fluttertoast.showToast(msg: 'Updated');
      }
    } catch (e) {
      print(e);
    }
  }
void initVideo()
{
  _controller = VideoPlayerController.network(firstVideoUrl)
    ..initialize().then((_) {
      _controller?.play();
      _controller?.setLooping(true);
      // Ensure the first frame is shown after the video is initialized
      setState(() {});
    });
}

  Future PostCommentList(int video_ID, ) async {
    var id1 = await HelperFunctions.getVStarUniqueIdkey();

    /* EasyLoading.show(status: 'Loading...');*/
    var api = Uri.parse("https://vinsta.ggggg.in.net/api/videoCommentList");

    /*  print("id1" + id1.toString());
    print("video_id" + video_ID.toString());
    print("status_vilike" + statusLike.toString());*/

    Map mapeddate = {
      "id":video_ID.toString()
    };

    final response = await http.post(
      api,
      body: mapeddate,
    );

    var res = await json.decode(response.body);
    /*print("hererere" + response.body);*/
    setState(() {
     PCommentList=res['response_videocommentlist'];
     loading=true;
    });

    try {
      if (response.statusCode == 200) {
        /*  EasyLoading.dismiss();*/
        Fluttertoast.showToast(msg: 'Updated');
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
    setState(() { loading = true;
    profile = res['response_getUserProfile'];
    print(profile);
    if( profile[0]['userphoto']==null){
      ImagelUrl= 'https://ps.w.org/user-avatar-reloaded/assets/icon-256x256.png?rev=2540745'.toString();
    }else{ ImagelUrl = profile[0]['userphoto'].toString();


    }

    name = profile[0]['user_name'].toString();


    });

    try {
      if (response.statusCode == 200) {

      }
    } catch (e) {
      print(e);
    }
  }
  @override
  void initState() {

    CommentCount();
    getUserDetails();
    initVideo();
    ReelsList();
    super.initState();
  }

  bool fill = false;
  bool filled = true;
  @override
  Widget build(BuildContext context) {
    return PreloadPageView.builder(
      onPageChanged: (index) async {
        setState(() {
          firstVideoUrl=Reel[index]['video'];
          print('firstVideoUrl'+firstVideoUrl.toString());
        });
        await HelperFunctions.saveuserVideoId(Reel[index]['id']);
        VideoId = await HelperFunctions.getVedioID();
        print("id" + VideoId.toString());
        GetLikeUnLike();
        ReelsList();
        LikeCount();
        CommentCount();
        initVideo();
      },
      scrollDirection: Axis.vertical,
      itemCount: Reel == null ? 0 : Reel.length,
      preloadPagesCount: 5,
      itemBuilder: (BuildContext context, int index) {

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
                                InkWell(
                                  onTap: () {},
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
                                InkWell(
                                  onTap: () async {
                                    await HelperFunctions.saveuserVideoId(
                                        Reel[index]['id']);

                                    setState(() {
                                     LikkeStatus ==
                                              null ||
                                          LikkeStatus[0]["status_vilike"] == 0
                                          ?
                                        fill = false:
                                        fill = true;

                                      print("bool::::" + fill.toString());
                                      fill = !fill;

                                      if (fill == false) {
                                        status = 0;
                                      } else {
                                        status = 1;
                                      }
                                      print("fill:" + fill.toString());
                                      PostLikeUnlike(Reel[index]["id"], status);
                                    });

                                  },
                                  child: LikkeStatus ==
                                          null ||
                                      LikkeStatus[0]["status_vilike"] == 0
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
                                  TotalCount.toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                InkWell(
                                  onTap: () {
                                    /* print(Reel[index]["id"]);*/
                                    PostCommentList(Reel[index]["id"]);
                                    onCommentBottomSheet(Reel[index]["id"]);
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
                                  TotalCommentCount.toString(),
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
                                  child: ClipOval(
                                    child: loading != true
                                        ? Container(
                                            height: 10,
                                            width: 10,
                                            child: CircularProgressIndicator(),
                                          )
                                        : Image.network(
                                            Reel[index]['userphoto'] != null
                                                ? Reel[index]['userphoto']
                                                : "https://ps.w.org/user-avatar-reloaded/assets/icon-256x256.png?rev=2540745",
                                            width: 40,
                                            height: 40,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  Reel[index]['user_name'],
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
                        padding: const EdgeInsets.only(
                            top: 10, left: 10.0, right: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              Reel[index]['content'] != null
                                  ? Reel[index]['content']
                                  : 'No Content!!!!',
                              style: TextStyle(color: Colors.white),
                            ),
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
                                        Reel[index]['songname'] != null
                                            ? Reel[index]['songname']
                                            : 'No Song Selected!!',
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
                                  Reel[index]['location'],
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Songscreen()));
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
                                      image: NetworkImage(Reel[index]
                                                  ['userphoto'] !=
                                              null
                                          ? Reel[index]['userphoto']
                                          : "https://ps.w.org/user-avatar-reloaded/assets/icon-256x256.png?rev=2540745")),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 130,
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

  void onCommentBottomSheet(int videoId) {
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
                  return loading!=false?Container(
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
                                child:ClipOval(
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
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                  ),
                                  Container(
                                    height: 45,
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    child: TextFormField(
                                      controller: Comment,
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
                                  TextButton(
                                    onPressed: () async{
                                      if (Comment.text.isEmpty) {
                                        print('null');
                                      } else {
                                        await HelperFunctions.saveuserVideoId(videoId);
                                        VideoId = await HelperFunctions.getVedioID();
                                        print('videoId' + videoId.toString());
                                        CommentOnPost(videoId);
                                        PostCommentList(videoId);
                                        Navigator.pop(context);

                                      }
                                    },
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
                              itemCount:PCommentList==null?0:PCommentList.length,
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
                                          child: ClipOval(
                                            child: loading != true
                                                ? Container(
                                              child: Center(
                                                child: CircularProgressIndicator(),
                                              ),
                                            )
                                                : Image.network( PCommentList[index]['userphoto']!= null
                                                ? PCommentList[index]['userphoto']
                                                : 'https://ps.w.org/user-avatar-reloaded/assets/icon-256x256.png?rev=2540745',

                                              width: 50,
                                              height: 50,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        trailing: ButtonTheme(
                                          minWidth: 12,
                                          height: 14,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                          ),
                                          child: IconButton(
                                            icon: filled
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


                                              setState(() {
                                            /*    LikkeStatus ==
                                                    null ||
                                                    LikkeStatus[0]["status_vilike"] == 0
                                                    ?
                                                filled = false:
                                                filled = true;*/

                                                print("bool::::" + fill.toString());
                                                filled = !filled;

                                                if (filled == false) {
                                                  CommentLikestatus = 0;
                                                } else {
                                                  CommentLikestatus = 1;
                                                }
                                                print("fill:" + CommentLikestatus.toString());
                                               CommentLikeUnlike(PCommentList[index]['usercomment_id'], CommentLikestatus,videoId);
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
                                                child: Text(PCommentList[index]['user_name'])),
                                            Text(
                                                PCommentList[index]['videocomment'],style: TextStyle(fontSize: 12),
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
                  ):Container(child: Center(child: CircularProgressIndicator(),),);
                });
              });
        });
  }
}
