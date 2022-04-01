import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import '../../../helper/helperFunctions.dart';
import '../../prifleRelatedScreens/profileInfoScreen.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({
    Key? key,
    required this.id,
    required this.followingId,
    required this.friendId,
  }) : super(key: key);
  final int id;
  final int followingId;
  final int friendId;
  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  TextEditingController postText = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool loading = false;
  List related_product = [];
  List commentList = [];
  List getReplyComments = [];
  List profile = [];
  List getListLikeDisLikeStatus = [];
  String ImagelUrl = '';
  int Index = 0;

  int status = 0;
  Future PostComment(
    int following_id,
    int friend_id,
    int postImage_id,
  ) async {
    var api = Uri.parse("https://vinsta.ggggg.in.net/api/otherUserComment");
    var id1 = await HelperFunctions.getVStarUniqueIdkey();
    Map mapeddate = {
      "user_id": id1.toString(),
     /* "following_id": following_id.toString(),
      "friend_id": friend_id.toString(),*/
      "postImage_id": postImage_id.toString(),
      "comment": postText.text.toString()
    };

    final response = await http.post(
      api,
      body: mapeddate,
    );

    var res = await json.decode(response.body);
    print("hererere1" + response.body);
    setState(() {
      GetComments();
    });
    postText.clear();
    try {
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Comment added');
      }
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
                    deleteComment(commentID);
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
                    deleteReplyComment(commentID);
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

  Future deleteReplyComment(
    int commentID,
  ) async {
    var api =
        Uri.parse("https://vinsta.ggggg.in.net/api/replyImgCommentDelete");
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
      GetComments();
    });

    try {
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Deleted');
      }
    } catch (e) {
      print(e);
    }
  }

  Future deleteComment(
    int commentID,
  ) async {
    var api = Uri.parse("https://vinsta.ggggg.in.net/api/deleteComment");
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
      GetComments();
    });

    try {
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Deleted');
      }
    } catch (e) {
      print(e);
    }
  }

  Future getLikeDisLikeStatus(
    int commentID,
  ) async {
    var api = Uri.parse("https://vinsta.ggggg.in.net/api/likeCommentList");
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
      getListLikeDisLikeStatus = res['response_likescomment'];
      GetComments();
    });

    try {
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Deleted');
      }
    } catch (e) {
      print(e);
    }
  }

  Future LikeUnlikeComments(int commentID, int status) async {
    var api = Uri.parse("https://vinsta.ggggg.in.net/api/likeOnComment");
    EasyLoading.show(status: '');
    var id1 = await HelperFunctions.getVStarUniqueIdkey();
    Map mapeddate = {
      "comment_id": commentID.toString(),
      "user_id": id1.toString(),
      "status_like": status.toString()
    };
    print('commentId:' + commentID.toString() + "status:" + status.toString());
    final response = await http.post(
      api,
      body: mapeddate,
    );
    setState(() {
      GetComments();
    });
    var res = await json.decode(response.body);
    print("hererere" + response.body);

    try {
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        /* if (status == 0) {
          Fluttertoast.showToast(msg: 'UnLiked');
        } else {
          Fluttertoast.showToast(msg: 'Liked');
        }*/
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
    });

    try {
      if (response.statusCode == 200) {
        /* Fluttertoast.showToast(msg: 'Updated');*/
      }
    } catch (e) {
      print(e);
    }
  }

  Future GetComments() async {
    var api = Uri.parse("https://vinsta.ggggg.in.net/api/allCommentsList");

    Map mapeddate = {"id": widget.id.toString()};

    final response = await http.post(
      api,
      body: mapeddate,
    );

    var res = await json.decode(response.body);
    print("hererere" + response.body);
    setState(() {
      commentList = res['response_commentslist'];

      loading = true;
    });
// getLikeDisLikeStatus(commentList[0]['id']);
    try {
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Updated');
      }
    } catch (e) {
      print(e);
    }
  }

  Future GetReplyComments(int commentId) async {
    var api = Uri.parse("https://vinsta.ggggg.in.net/api/replycommentImglist");

    Map mapeddate = {"comment_id": commentId.toString()};

    final response = await http.post(
      api,
      body: mapeddate,
    );

    var res = await json.decode(response.body);
    print("hererere" + response.body);
    setState(() {
      getReplyComments = res['response_replycommentList'];

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

  Future InserCommentReply(int commentId) async {
    var api = Uri.parse("https://vinsta.ggggg.in.net/api/replycommentImage");
    var id1 = await HelperFunctions.getVStarUniqueIdkey();
    Map mapeddate = {
      "user_id": id1.toString(),
      "comment_id": commentId.toString(),
      "replycomment": postText.text.toString()
    };

    final response = await http.post(
      api,
      body: mapeddate,
    );

    var res = await json.decode(response.body);
    print("hererere1::" + response.body);
    setState(() {
     /* commentList = res['response_commentslist'];*/
      postText.clear();
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

  bool fill = false;
  @override
  void initState() {
    getUserDetails();
    GetComments();
    GetEmojis();
    print('ImageId' + widget.id.toString());
    super.initState();
  }

  @override
  void dispose() {
    postText.dispose();
    super.dispose();
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
                            /*     related_product[index]['character'] =
                                postText.text.toString();*/
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
                      controller: postText,
                      decoration: InputDecoration(
                        fillColor: Colors.white54,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                        ),
                        hintText: 'Comment as User!',
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (postText.text.isNotEmpty) {
                        if (_focusNode.hasFocus != false) {
                          InserCommentReply(commentList[Index]['id']);
                          print('asd');
                        } else {
                          PostComment(
                              widget.followingId, widget.friendId, widget.id);
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
          shrinkWrap: true,
          itemCount: commentList == null ? 0 : commentList.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                InkWell(
                    onLongPress: () =>
                        _showMyDialog(context, commentList[index]['id']),
                    child: ListTile(
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
                                    commentList[index]['userphoto'] != null
                                        ? commentList[index]['userphoto']
                                        : 'https://ps.w.org/user-avatar-reloaded/assets/icon-256x256.png?rev=2540745'
                                            .toString(),
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
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(commentList[index]['user_name'])),
                            InkWell(
                                child: Text(
                              commentList[index]['comment'],
                              style: TextStyle(fontSize: 20),
                            )),
                            Row(
                              children: [
                                Text(
                                  commentList[index]['created_at'],
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10),
                                ),
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
                                        _focusNode.hasFocus == true;
                                        Index = index;
                                        print('Index' + Index.toString());
                                      });
                                    },
                                    child: Text(
                                      'Reply',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 10),
                                    )),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                GetReplyComments(commentList[index]['id']);
                              },
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  /*${getReplyComments.length}*/ 'View all replies',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                ),
                              ),
                            ),
                          ],
                        ))),
                Padding(
                  padding: const EdgeInsets.only(left: 60.0),
                  child: alllreply(),
                )
              ],
            );
          }),
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
