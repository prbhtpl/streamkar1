import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../../helper/helperFunctions.dart';
class AllReelsComments extends StatefulWidget {
  const AllReelsComments({Key? key,required this.videoId}) : super(key: key);
  final int videoId;
  @override
  State<AllReelsComments> createState() => _AllReelsCommentsState();
}

class _AllReelsCommentsState extends State<AllReelsComments> {
  TextEditingController Comment = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List Reel = [];
  List profile = [];
  List related_product = [];
  List LikkeStatus = [];
  List PCommentList = [];
  int status = 0;
  int CommentLikestatus = 0;
  var TotalCount = '';
  var TotalCommentCount = '';
  var VideoId = 0;
  String name = '';
  String ImagelUrl = '';
  bool loading = false;
  bool filled = false;
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
  Future CommentLikeUnlike(int CommentId, int statusLike, int videoId) async {
    /* EasyLoading.show(status: 'Loading...');*/
    var id1 = await HelperFunctions.getVStarUniqueIdkey();
    print( "vcomment_id"+ CommentId.toString()+
        "user_id"+ id1.toString()
        +
        "video_id"+
        videoId.toString()+
        "status_comlike"+ statusLike.toString());

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
      "videocomment": Comment.text.toString()
    };

    final response = await http.post(
      api,
      body: mapeddate,
    );

    var res = await json.decode(response.body);
    print("hererere" + response.body);
    setState(() {
      Comment.clear();

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
  Future GetEmojis() async {
    var api = Uri.parse(
        "https://emoji-api.com/emojis?access_key=3aaec15c05716d94805ee9d08e843d140a4cf631");
    final response = await http.get(
      api,
    );

    var res = await json.decode(response.body);

    setState(() {
      related_product = res;
    });
    /* print("hererere  " + related_product[0]['unicodeName'].toString());*/
  }
@override
  void initState() {
 VideoCommentList(widget.videoId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 120,
        color: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 45,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: related_product.length,
                    itemBuilder: (BuildContext, int index) {
                      return IconButton(
                        onPressed: () {
                          setState(() {


                          });
                        },
                        icon: Text(
                          related_product[index]['character'].toString(),
                          style: TextStyle(fontSize: 25),
                        ),
                      );
                    }),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    child: ClipOval(
                      child: loading != true
                          ? Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                          : Image.network(
                        ImagelUrl.toString(),
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 250,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Colors.white54, width: 0),
                    ),
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
                  InkWell(
                    onTap: () async {
                      if (Comment.text.isNotEmpty) {
                        if (_focusNode.hasFocus !=
                            false) {Comment.clear();

                        print('view');
                        } else {
                          await HelperFunctions
                              .saveuserVideoId(widget.videoId);
                          VideoId = await HelperFunctions
                              .getVedioID();
                      /*    print('videoId' +
                              videoId.toString());*/
                          CommentOnPost(widget.videoId);
                          VideoCommentList(widget.videoId);
                        }
                      } else {
                        print('null');
                      }
                    },
                    child: Text(
                      'post',
                      style: TextStyle(color: Colors.lightBlueAccent),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              CupertinoIcons.back,
              color: Colors.black,
            )),
        title: Text(
          'Comments',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
          itemCount: PCommentList == null
              ? 0
              : PCommentList.length,
          itemBuilder:
              (BuildContext context, int index) {
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
                            child:
                            CircularProgressIndicator(),
                          ),
                        )
                            : Image.network(
                          PCommentList[index][
                          'userphoto'] !=
                              null
                              ? PCommentList[
                          index]
                          ['userphoto']
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
                        BorderRadius.circular(
                            18.0),
                      ),
                      child: IconButton(
                        icon: PCommentList[index][
                        'status_comlike'] ==
                            0 ||
                            PCommentList[index][
                            'status_comlike'] ==
                                null
                            ? Icon(
                          CupertinoIcons.heart,
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
                            if (PCommentList[index][
                            'status_like'] ==
                                null ||
                                PCommentList[index][
                                'status_like'] ==
                                    0) {
                              filled == false;
                            } else {
                              filled == true;
                            }

                            filled = !filled;

                            if (filled == false) {
                              CommentLikestatus = 0;
                            } else {
                              CommentLikestatus = 1;
                            }
                            print("status:::::" +
                                CommentLikestatus
                                    .toString());

                          });
                          CommentLikeUnlike(
                              PCommentList[index]
                              ['id'],
                              CommentLikestatus,
                              widget.videoId);
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    title: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Align(
                            alignment:
                            Alignment.centerLeft,
                            child: Text(
                                PCommentList[index]
                                ['user_name'])),
                        Text(
                          PCommentList[index]
                          ['videocomment'],
                          style:
                          TextStyle(fontSize: 12),
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
                                      color:
                                      Colors.grey,
                                      fontSize: 10),
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            TextButton(onPressed: (){
                              setState(() { _focusNode.requestFocus();
                              _focusNode.hasFocus == true;

                              });
                            },
                                child:Text('Reply',
                                  style: TextStyle(
                                      color:
                                      Colors.grey,
                                      fontSize: 10),
                                )),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Fluttertoast.showToast(
                                msg:
                                "View All replies");
                            //alllreply();
                          },
                          child: Align(
                            alignment:
                            Alignment.centerRight,
                            child: Text(
                              'View all replies',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12),
                            ),
                          ),
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
    );
  }
}
