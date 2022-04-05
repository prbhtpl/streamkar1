// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:marquee_widget/marquee_widget.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:untitled/screens/homeScreenRelatedScreens/notificationScreen.dart';
import 'package:untitled/screens/reelSectionPages/reelsComment.dart';

import 'package:untitled/screens/reelSectionPages/songSection.dart';

import 'package:video_player/video_player.dart';

import '../../bottomNavigationBar/bottomNavigation.dart';
import '../../helper/helperFunctions.dart';

class ReelVideos extends StatefulWidget {
  const ReelVideos({Key? key}) : super(key: key);

  @override
  _ReelVideosState createState() => _ReelVideosState();
}

class _ReelVideosState extends State<ReelVideos> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => BottomNavigation(
                      screenId: 0,
                    )));

        return true;
      },
      child: DefaultTabController(
        length: 1,
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
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
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
      'https://vinsta.ggggg.in.net/public/videosfile/1648799290.mp4';
  List Reel = [];
  List profile = [];
  List LikkeStatus = [];
  List PCommentList = [];
  List VideoGiftList = [];
  List LevelList = [];
  List getReplyComments = [];
  int status = 0;
  int CommentLikestatus = 0;
  var TotalCount = '';
  String giftDetails = '';
  var TotalCommentCount = '';
  var VideoId = 0;
  String name = '';
  String ImagelUrl = '';
  bool loading = false;
  int Index = 0;
  String GiftImage = "";
  String Giftname = '';
  int GiftedBeans = 0;
  int TotalNumberOfGiftedBeans = 0;
  int numberOfSendingBeans = 0;
  int TotalNumberOfBeansWanted = 0;
  double calculatedValue = 0;
  double calculatedGiftValue = 0;
  int Total_Amount = 0;
  bool totalAmount = false;

  int? response_totalBeans;
  final FocusNode _focusNode = FocusNode();
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
    print("hererere123123" + response.body);

    try {
      if (response.statusCode == 200) {
        EasyLoading.dismiss();

        setState(() {
          Reel = res['response_videoList'];
          loading = true;

          firstVideoUrl = Reel[0]['video'];
          print("firstVideoUrl" + firstVideoUrl);
        });
        await HelperFunctions.saveuserVideoId(Reel[0]['id']);
        //  initVideo();
        LikeCount();
        GetLikeUnLike();
        VideoCommentList(VideoId);

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

  Future CommentLikeUnlike(int CommentId, int statusLike, int videoId) async {
    /* EasyLoading.show(status: 'Loading...');*/
    var id1 = await HelperFunctions.getVStarUniqueIdkey();
    print("vcomment_id" +
        CommentId.toString() +
        "user_id" +
        id1.toString() +
        "video_id" +
        videoId.toString() +
        "status_comlike" +
        statusLike.toString());

    var api = Uri.parse("https://vinsta.ggggg.in.net/api/videoCommentLike");

    /*  var id1 = await HelperFunctions.getVStarUniqueIdkey();*/

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
      VideoCommentList(videoId.toInt());
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

  void initVideo() {
    _controller = VideoPlayerController.network(firstVideoUrl)
      ..initialize().then((_) {
        _controller?.play();
        _controller?.setLooping(true);
        // Ensure the first frame is shown after the video is initialized
        setState(() {});
      });
  }

  Future VideoCommentList(
    int video_ID,
  ) async {
    var id1 = await HelperFunctions.getVStarUniqueIdkey();

    EasyLoading.show(status: 'Loading...');
    var api = Uri.parse("https://vinsta.ggggg.in.net/api/videoCommentList");

    /*  print("id1" + id1.toString());
    print("video_id" + video_ID.toString());
    print("status_vilike" + statusLike.toString());*/

    Map mapeddate = {"video_id": video_ID.toString()};

    final response = await http.post(
      api,
      body: mapeddate,
    );

    var res = await json.decode(response.body);
    print("hererere" + response.body);
    setState(() {
      PCommentList = res['response_videocommentlist'];
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

  Future GetReplyComments(int commentId) async {
    var api =
        Uri.parse("https://vinsta.ggggg.in.net/api/replycommentVideolist");

    Map mapeddate = {"comment_id": commentId.toString()};

    final response = await http.post(
      api,
      body: mapeddate,
    );

    var res = await json.decode(response.body);
    print("hererere1111" + response.body);
    setState(() {
      getReplyComments = res['response_replycommentvideoList'];

      loading = true;
    });
// getLikeDisLikeStatus(commentList[0]['id']);
    try {
      if (response.statusCode == 200) {
        /* Fluttertoast.showToast(msg: 'Updated');*/
      }
    } catch (e) {
      print(e);
    }
  }

  Future GetCommentsLikeStatus() async {
    var api = Uri.parse("https://vinsta.ggggg.in.net/api/videoCommentLikelist");
    var id1 = await HelperFunctions.getVStarUniqueIdkey();
    Map mapeddate = {"user_id": id1.toString(), "vcomment_id": 1};

    final response = await http.post(
      api,
      body: mapeddate,
    );

    var res = await json.decode(response.body);
    print("hererere" + response.body);
    setState(() {});

    try {
      if (response.statusCode == 200) {}
    } catch (e) {
      print(e);
    }
  }

  Future deleteVideoComment(
    int commentID,
  ) async {
    var api = Uri.parse("https://vinsta.ggggg.in.net/api/videoCommentDelete");
    var id1 = await HelperFunctions.getVStarUniqueIdkey();
    Map mapeddate = {
      "id": commentID.toString(),
    };

    final response = await http.post(
      api,
      body: mapeddate,
    );

    var res = await json.decode(response.body);
    print("hererere" + response.body);
    setState(() {
      VideoCommentList(VideoId);
    });

    try {
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Deleted');
      }
    } catch (e) {
      print(e);
    }
  }

  Future deleteReplyVideoComment(
    int commentID,
  ) async {
    var api =
        Uri.parse("https://vinsta.ggggg.in.net/api/replyVideoCommentDelete");
    var id1 = await HelperFunctions.getVStarUniqueIdkey();
    Map mapeddate = {
      "id": commentID.toString(),
    };

    final response = await http.post(
      api,
      body: mapeddate,
    );

    var res = await json.decode(response.body);
    print("hererere" + response.body);
    setState(() {
      VideoCommentList(VideoId);
    });

    try {
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Deleted');
      }
    } catch (e) {
      print(e);
    }
  }

  Future SendGiftOnVideos(
    String image,
    String Giftname,
    int NoOfBeansSend,
  ) async {
    print("all" +
        VideoId.toString() +
        Giftname +
        NoOfBeansSend.toString() +
        image);
    print(Giftname);
    print(NoOfBeansSend);
    print(image);
    var api = Uri.parse("https://vinsta.ggggg.in.net/api/usergiftonVideos");
    var id1 = await HelperFunctions.getVStarUniqueIdkey();
    EasyLoading.show(status: 'Sending');
    Map mapeddate = {
      "user_id": id1.toString(),
      "video_id": VideoId.toString(),
      "giftname": Giftname.toString(),
      "giftbeans": NoOfBeansSend.toString(),
      "icongift": image.toString(),
    };

    final response = await http.post(
      api,
      body: mapeddate,
    );

    var res = await json.decode(response.body);
    String msg = res['status_message'];
    print("hererere" + response.body);
    setState(() {
      VideoCommentList(VideoId);
      GetUserLevelBeanAmount();
      GiftLevelList();
    });

    try {
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: msg);
        EasyLoading.dismiss();
      } else {
        EasyLoading.dismiss();
      }
    } catch (e) {
      print(e);
    }
  }

  Future GetUserLevelBeanAmount() async {
    var api = Uri.parse("https://vinsta.ggggg.in.net/api/totalBeansViedo");

    var id1 = await HelperFunctions.getVStarUniqueIdkey();
    Map mapeddate = {"user_id": id1.toString()};
    final response = await http.post(api, body: mapeddate);

    var res = await json.decode(response.body);
    print("hererere1::@" + response.body);
    setState(() {
      TotalNumberOfGiftedBeans = int.parse('${res['response_beantotal']}');
      TotalNumberOfGiftedBeans = Total_Amount;
    });

    try {
      if (response.statusCode == 200) {}
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
      loading = true;
      profile = res['response_getUserProfile'];
      print(profile);
      if (profile[0]['userphoto'] == null) {
        ImagelUrl =
            'https://ps.w.org/user-avatar-reloaded/assets/icon-256x256.png?rev=2540745'
                .toString();
      } else {
        ImagelUrl = profile[0]['userphoto'].toString();
      }

      name = profile[0]['user_name'].toString();
    });

    try {
      if (response.statusCode == 200) {}
    } catch (e) {
      print(e);
    }
  }

  Future<void> _showMyDialog(BuildContext context, int commentID) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete message ? '),
          actions: <Widget>[
            Row(
              children: [
                TextButton(
                  child: const Text(
                    'Cancel',
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child:
                      const Text('delete', style: TextStyle(color: Colors.red)),
                  onPressed: () {
                    deleteVideoComment(commentID);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> _showMyReplyDialog(BuildContext context, int commentID) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete message ? '),
          actions: <Widget>[
            Row(
              children: [
                TextButton(
                  child: const Text(
                    'Cancel',
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child:
                      const Text('delete', style: TextStyle(color: Colors.red)),
                  onPressed: () {
                    deleteReplyVideoComment(commentID);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future InserCommentReply(int commentId) async {
    var id1 = await HelperFunctions.getVStarUniqueIdkey();
    print("asdasdasd" + commentId.toString());
    print("asdasdasd" + id1.toString());
    print("asdasdasd" + Comment.text.toString());
    var api = Uri.parse("https://vinsta.ggggg.in.net/api/replycommentsVideo");

    Map mapeddate = {
      "user_id": id1.toString(),
      "comment_id": commentId.toString(),
      "replycomment": Comment.text
    };

    final response = await http.post(
      api,
      body: mapeddate,
    );

    var res = await json.decode(response.body);
    print("hererere1::" + response.body);
    setState(() {
      /*commentList = res['response_commentslist'];*/
      Comment.clear();
      loading = true;
    });
// getLikeDisLikeStatus(commentList[0]['id']);
    try {
      if (response.statusCode == 200) {
        /* Fluttertoast.showToast(msg: 'Updated');*/
      }
    } catch (e) {
      print(e);
    }
  }

  Future GiftList() async {
    var api = Uri.parse("https://vinsta.ggggg.in.net/api/giftlist");

    final response = await http.get(
      api,
    );

    var res = await json.decode(response.body);
    print("hererere1::@1" + response.body);
    setState(() {
      VideoGiftList = res['response_giftlist'];
      loading = true;
    });

    try {
      if (response.statusCode == 200) {}
    } catch (e) {
      print(e);
    }
  }

  Future GiftLevelList() async {
    var api = Uri.parse("https://vinsta.ggggg.in.net/api/levelList");

    final response = await http.get(
      api,
    );

    var res = await json.decode(response.body);
    print("hererere1::@" + response.body);
    setState(() {
      LevelList = res['response_notifylist'];
      loading = true;
    });

    try {
      if (response.statusCode == 200) {}
    } catch (e) {
      print(e);
    }
  }

  void Calclulations() {
    int i = 1;
    for (i; i <= LevelList.length; i++) {
      TotalNumberOfBeansWanted = int.parse('${LevelList[i]['point']}');
      if (TotalNumberOfGiftedBeans > TotalNumberOfBeansWanted) {
        TotalNumberOfBeansWanted = int.parse('${LevelList[i + 1]['point']}');

        print(
            'TotalNumberOfBeansWanted1' + TotalNumberOfBeansWanted.toString());
      } else {
        TotalNumberOfBeansWanted = int.parse('${LevelList[i]['point']}');
      }
      calculatedValue = (TotalNumberOfGiftedBeans / TotalNumberOfBeansWanted);
      _initialVlaueofLevel = calculatedValue;
      break;
    }
  }

  Future GetTotalNo_ofBeans() async {
    var api = Uri.parse("https://vinsta.ggggg.in.net/api/totalbeans");
    var id1 = await HelperFunctions.getVStarUniqueIdkey();
    Map mapeddate = {"user_id": id1.toString()};

    final response = await http.post(
      api,
      body: mapeddate,
    );

    var res = await json.decode(response.body);
    print("hererere" + response.body);
    setState(() {
      response_totalBeans = res['response_totalBeans'];
    });

    try {
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Updated');
        loading = true;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    GetTotalNo_ofBeans();
    GetUserLevelBeanAmount();
    GiftLevelList();
    GiftList();
    CommentCount();
    getUserDetails();
    initVideo();
    ReelsList();
    super.initState();
  }

  bool fill = false;
  bool filled = true;
  double _initialVlaueofLevel = 0.0;
  @override
  Widget build(BuildContext context) {
    return PreloadPageView.builder(
      onPageChanged: (index) async {
        setState(() {
          firstVideoUrl = Reel[index]['video'];
          print('firstVideoUrl' + firstVideoUrl.toString());
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
                                      LikkeStatus == null ||
                                              LikkeStatus[0]["status_vilike"] ==
                                                  0
                                          ? fill = false
                                          : fill = true;

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
                                          null /*||
                                          LikkeStatus[0]["status_vilike"] == 0*/
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
                                    VideoCommentList(Reel[index]["id"]);
                                    onCommentBottomSheet(Reel[index]["id"]);
                                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>AllReelsComments(videoId: Reel[index]["id"])));
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
                                InkWell(
                                  onTap: () {
                                    GiftBottomSheet();
                                    Calclulations();
                                  },
                                  child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              colors: [
                                                Colors.white,
                                                Colors.pinkAccent,
                                              ],
                                              begin: const FractionalOffset(
                                                  0.0, 0.0),
                                              end: const FractionalOffset(
                                                  1.0, 0.0),
                                              stops: [0.0, 1.0],
                                              tileMode: TileMode.clamp),
                                          border: Border.all(
                                              color: Colors.pink, width: 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(100))),
                                      child: Icon(
                                        CupertinoIcons.gift_fill,
                                        color: Colors.white,
                                      )),
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

  void GiftBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              Navigator.pop(context, true);
              return true;
            },
            child: BottomSheet(
                onClosing: () {},
                builder: (BuildContext context) {
                  return StatefulBuilder(
                      builder: (BuildContext context, StateSetter State) {
                    return Container(
                      color: Colors.black,
                      height: 600,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(
                              thickness: 5,
                              indent: 180,
                              endIndent: 180,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            LevelIndicator(),
                            Divider(
                              color: Colors.white,
                            ),
                            Container(
                              height: 230,
                              child: GridView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: VideoGiftList == null
                                    ? 0
                                    : VideoGiftList.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 0.9,
                                        mainAxisSpacing: 10,
                                        crossAxisCount: 5),
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      State(() {
                                        GiftImage = VideoGiftList[index]
                                                ['icongift']
                                            .toString();
                                        Giftname = VideoGiftList[index]
                                                ['giftname']
                                            .toString();
                                        GiftedBeans =
                                            VideoGiftList[index]['giftbeans'];
                                        giftDetails =
                                            '${VideoGiftList[index]['giftname']}, ${VideoGiftList[index]['giftbeans']} Beans';
                                        numberOfSendingBeans = int.parse(
                                            '${VideoGiftList[index]['giftbeans']}');

                                        calculatedGiftValue =
                                            (numberOfSendingBeans /
                                                TotalNumberOfBeansWanted);
                                        double total = calculatedValue +
                                            calculatedGiftValue;
                                        _initialVlaueofLevel = total;
                                        Total_Amount =
                                            TotalNumberOfGiftedBeans +
                                                numberOfSendingBeans;
                                        print(Total_Amount);
                                        totalAmount = true;
                                      });
                                    },
                                    child: Card(
                                        color: Colors.black,
                                        elevation: 1,
                                        child: GridTile(
                                          child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                gradient: LinearGradient(
                                                    colors: [
                                                      Colors.black26,
                                                      Colors.black,
                                                    ],
                                                    begin:
                                                        const FractionalOffset(
                                                            0.0, 0.0),
                                                    end: const FractionalOffset(
                                                        1.0, 0.0),
                                                    stops: [0.0, 1.0],
                                                    tileMode: TileMode.clamp),
                                              ),
                                              child: Center(
                                                  child: ClipOval(
                                                child: loading != true
                                                    ? Container(
                                                        height: 40,
                                                        width: 40,
                                                        child:
                                                            CircularProgressIndicator(),
                                                      )
                                                    : Image.network(
                                                        VideoGiftList[index][
                                                                    'icongift'] !=
                                                                null
                                                            ? VideoGiftList[
                                                                        index]
                                                                    ['icongift']
                                                                .toString()
                                                            : "No Image Found",
                                                        width: 30,
                                                        height: 30,
                                                        fit: BoxFit.cover,
                                                      ),
                                              ))),
                                          footer: Column(
                                            children: [
                                              SizedBox(height: 20),
                                              Text(
                                                VideoGiftList[index]
                                                    ['giftname'],
                                                style: GoogleFonts.lato(
                                                    color: Colors.white,
                                                    fontSize: 12),
                                              ),
                                              Text(
                                                  '${VideoGiftList[index]['giftbeans']} Beans',
                                                  style: GoogleFonts.lato(
                                                    color: Colors.white,
                                                    fontSize: 8,
                                                  ))
                                            ],
                                          ),
                                        )),
                                  );
                                },
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 40,
                                  width:
                                      MediaQuery.of(context).size.width / 1.30,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 0.2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '$giftDetails',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.pinkAccent.shade200),
                                  onPressed: () {
                                    print(response_totalBeans);
                                    if (numberOfSendingBeans <=
                                        response_totalBeans!) {
                                      SendGiftOnVideos(
                                          GiftImage, Giftname, Total_Amount);
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: 'InSufficient Beans');
                                    }
                                  },
                                  child: Text('Send'),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  });
                }),
          );
        });
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
                  return loading != false
                      ? Container(
                          height: MediaQuery.of(context).size.height * 0.75,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
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
                                          child: ClipOval(
                                            child: loading != true
                                                ? Container(
                                                    child: Center(
                                                      child:
                                                          CircularProgressIndicator(),
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                          child: TextFormField(
                                            focusNode: _focusNode,
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
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    15,
                                                  ),
                                                ),
                                                hintText: 'Comment as $name',
                                                hintStyle: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey)),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            if (Comment.text.isNotEmpty) {
                                              if (_focusNode.hasFocus !=
                                                  false) {
                                                Navigator.pop(context);
                                                print('view');
                                                InserCommentReply(
                                                    PCommentList[Index]['id']);
                                                print('view' +
                                                    PCommentList[Index]['id']
                                                        .toString());
                                              } else {
                                                await HelperFunctions
                                                    .saveuserVideoId(videoId);
                                                VideoId = await HelperFunctions
                                                    .getVedioID();
                                                print('videoId' +
                                                    videoId.toString());
                                                CommentOnPost(videoId);
                                                VideoCommentList(videoId);
                                                Navigator.pop(context);
                                              }
                                            } else {
                                              print('null');
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
                              Container(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: PCommentList == null
                                        ? 0
                                        : PCommentList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            InkWell(
                                              onLongPress: () {
                                                _showMyDialog(context,
                                                    PCommentList[index]['id']);
                                              },
                                              child: ListTile(
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
                                                                child:
                                                                    CircularProgressIndicator(),
                                                              ),
                                                            )
                                                          : Image.network(
                                                              PCommentList[index]
                                                                          [
                                                                          'userphoto'] !=
                                                                      null
                                                                  ? PCommentList[
                                                                          index]
                                                                      [
                                                                      'userphoto']
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
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18.0),
                                                    ),
                                                    child: IconButton(
                                                      icon: PCommentList[index][
                                                                      'status_comlike'] ==
                                                                  0 ||
                                                              PCommentList[
                                                                          index]
                                                                      [
                                                                      'status_comlike'] ==
                                                                  null
                                                          ? Icon(
                                                              CupertinoIcons
                                                                  .heart,
                                                              size: 18,
                                                            )
                                                          : Icon(
                                                              CupertinoIcons
                                                                  .heart_solid,
                                                              color: Colors.red,
                                                              size: 18,
                                                            ),
                                                      onPressed: () {
                                                        setState(() {
                                                          if (PCommentList[
                                                                          index]
                                                                      [
                                                                      'status_like'] ==
                                                                  null ||
                                                              PCommentList[
                                                                          index]
                                                                      [
                                                                      'status_like'] ==
                                                                  0) {
                                                            filled == false;
                                                          } else {
                                                            filled == true;
                                                          }

                                                          filled = !filled;

                                                          if (filled == false) {
                                                            CommentLikestatus =
                                                                0;
                                                          } else {
                                                            CommentLikestatus =
                                                                1;
                                                          }
                                                          print("status:::::" +
                                                              CommentLikestatus
                                                                  .toString());
                                                        });
                                                        CommentLikeUnlike(
                                                            PCommentList[index]
                                                                ['id'],
                                                            CommentLikestatus,
                                                            videoId);
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ),
                                                  title: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                              PCommentList[
                                                                      index][
                                                                  'user_name'])),
                                                      Text(
                                                        PCommentList[index]
                                                            ['videocomment'],
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            '$index h',
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
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
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        10),
                                                              )),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          TextButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  _focusNode
                                                                      .requestFocus();
                                                                  _focusNode
                                                                          .hasFocus ==
                                                                      true;
                                                                  Index = index;
                                                                  print('Index' +
                                                                      Index
                                                                          .toString());
                                                                });
                                                              },
                                                              child: Text(
                                                                'Reply',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        10),
                                                              )),
                                                        ],
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  "View All replies");
                                                          setState(() {
                                                            GetReplyComments(
                                                                PCommentList[
                                                                        index]
                                                                    ['id']);
                                                            alllreply();
                                                          });
                                                        },
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Text(
                                                            'View all replies',
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 12),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                            ),
                                            Divider(
                                              color: Colors.grey,
                                              thickness: 1,
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                              )
                            ],
                          ),
                        )
                      : Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                });
              });
        });
  }

  Widget LevelIndicator() {
    return Column(
      children: [
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
            ),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    height: 10,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: LinearProgressIndicator(
                        value: _initialVlaueofLevel,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xff00ff00)),
                        backgroundColor: Color(0xffD6D6D6),
                      ),
                    ),
                  )),
            ),
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: Colors.lightGreen,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.lightGreen)),
              child: Text(
                'Lv 2',
                style: TextStyle(fontSize: 10, color: Colors.white),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              totalAmount != true
                  ? TotalNumberOfGiftedBeans.toString()
                  : Total_Amount.toString(),
              style: TextStyle(color: Colors.white),
            ),
            Text(
              TotalNumberOfBeansWanted.toString(),
              style: TextStyle(color: Colors.white),
            ),
          ],
        )
      ],
    );
  }

  Widget alllreply() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: getReplyComments == null ? 0 : getReplyComments.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onLongPress: () =>
                _showMyReplyDialog(context, getReplyComments[index]['id']),
            child: Column(
              children: [
                ListTile(
                    leading: InkWell(
                      onTap: () {
/*Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfileInfo()));*/
                      },
                      child: ClipOval(
                        child: loading != true
                            ? Container(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : Image.network(
                                getReplyComments[index]['userphoto'] != null
                                    ? getReplyComments[index]['userphoto']
                                    : 'https://ps.w.org/user-avatar-reloaded/assets/icon-256x256.png?rev=2540745'
                                        .toString(),
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    /*  trailing: ButtonTheme(
                      minWidth: 12,
                      height: 14,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: IconButton(
                        icon: commentList[index]['status_like'] == null ||
                            commentList[index]['status_like'] == 0
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
                            if (commentList[index]['status_like'] == null ||
                                commentList[index]['status_like'] == 0) {
                              fill = false;
                            } else {
                              fill = true;
                            }
                            print("bool::::" + fill.toString());
                            fill = !fill;

                            if (fill == false) {
                              status = 0;
                            } else {
                              status = 1;
                            }
                            print("status:::::" + status.toString());
                            print(status);
                            LikeUnlikeComments(
                                commentList[index]['id'], status);
                          });
                        },
                      ),
                    ),*/
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(getReplyComments[index]['user_name'])),
                        InkWell(
                            child: Text(
                          getReplyComments[index]['replycomment'],
                          style: TextStyle(fontSize: 15),
                        )),
                        /*       Row(
                          children: [
                           */ /* Text(
                              commentList[index]['created_at'],
                              style:
                              TextStyle(color: Colors.grey, fontSize: 10),
                            ),*/ /*
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                                onTap: () {},
                                child: Text(
                                  'Likes',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10),
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                                onTap: () {
                                  print('lol');
                                  _focusNode.requestFocus();
                                  setState(() {
                                    _focusNode.hasFocus==true;
                                  });

                                },
                                child: Text(
                                  'Reply',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10),
                                )),
                          ],
                        ),*/
                        /*  InkWell(onTap: (){
                         // alllreply();
                        },
                          child:  Align(alignment: Alignment.center,child:Text(
                            'View all replies',
                            style:
                            TextStyle(color: Colors.grey, fontSize: 12),
                          ),),
                        ),*/
                      ],
                    )),
              ],
            ),
          );
        });
  }
}
