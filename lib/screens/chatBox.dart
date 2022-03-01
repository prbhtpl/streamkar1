// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

import '../helper/constants.dart';
import '../services/database.dart';

class ChatBox extends StatefulWidget {
  const ChatBox(
      {Key? key, required this.chatRoomId, required this.otherUserName})
      : super(key: key);
  final String? chatRoomId;
  final String? otherUserName;
  @override
  _ChatBoxState createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  TextEditingController _message = TextEditingController();
  DataBaseMethods dataBaseMethods = DataBaseMethods();
  Stream<QuerySnapshot>? chatmessageStream;
  File? imageFile;
  ScrollController _scrollController = ScrollController();

  _scrollToBottom() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  void initState() {
    dataBaseMethods.getConversationMessages(widget.chatRoomId).then((val) {
      setState(() {
        chatmessageStream = val;
      });
    });
    super.initState();
  }

  Future pickGalleryImage() async {
    ImagePicker _picker = ImagePicker();

    await _picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        imageFile = File(xFile.path);
        //uploadFile();
        uploadImage();
      }
    });
  }

  Future uploadImage() async {
    String? fileName = Uuid().v1();
    int status = 1;

    await Firestore.instance
        .collection('chatroom')
        .document(widget.chatRoomId)
        .collection('chats')
        .document(fileName)
        .setData({
      "sender": Constants.myname,
      "message": "",
      "type": "img",
      "time": FieldValue.serverTimestamp(),
    });

    var ref =
        FirebaseStorage.instance.ref().child('images').child("$fileName.jpg");

    var uploadTask = await ref.putFile(imageFile).onComplete;

    if (status == 1) {
      String imageUrl = await uploadTask.ref.getDownloadURL();

      await Firestore.instance
          .collection('chatroom')
          .document(widget.chatRoomId)
          .collection('chats')
          .document(fileName)
          .updateData({"message": imageUrl});

      print(imageUrl);
    }
  }

  void onSendMessage() async {
    if (_message.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        "sender": Constants.myname,
        "message": _message.text,
        "type": "text",
        "time": FieldValue.serverTimestamp(),
      };

      _message.clear();
      await Firestore.instance
          .collection('chatroom')
          .document(widget.chatRoomId)
          .collection('chats')
          .add(messages);
    } else {
      print("Enter Some Text");
    }
  }

  Future pickCameraImage() async {
    ImagePicker _picker = ImagePicker();

    await _picker.pickImage(source: ImageSource.camera).then((xFile) {
      if (xFile != null) {
        imageFile = File(xFile.path);
        //uploadFile();
        uploadImage();
      }
    });
  }

  QuerySnapshot? chatID;

  Future clearChat() async {
    print('chatroomid:${widget.chatRoomId}');
    return await Firestore.instance
        .collection('chatroom')
        .document(widget.chatRoomId)
        .collection('chats')
        .getDocuments()
        .then((snapshot) => {
              for (DocumentSnapshot ds in snapshot.documents)
                {
                  ds.reference.delete(),
                },
            });
  }

  String? chatid;
  Future deletemsg() async {
    await Firestore.instance
        .collection('chatroom')
        .document(widget.chatRoomId)
        .collection('chats')
        .getDocuments()
        .then((snapshot) => {
              for (DocumentSnapshot ds in snapshot.documents)
                {
                  this.setState(() {
                    chatid = ds.reference.documentID;
                  })
                },
            });
    print('chatroomid:${widget.chatRoomId}');
    print('id:${chatid}');
    await Firestore.instance
        .collection('chatroom')
        .document(widget.chatRoomId)
        .collection('chats')
        .document(chatid)
        .delete();
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete message ? This cannot be undone'),
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
                    deletemsg();
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.otherUserName.toString(),
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            CupertinoIcons.left_chevron,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PopupMenuButton<String>(
              icon: Icon(
                CupertinoIcons.settings_solid,
                color: Colors.black,
              ),
              padding: EdgeInsets.all(0),
              onSelected: (value) {
                print(value);
              },
              itemBuilder: (BuildContext contesxt) {
                return [
                  PopupMenuItem(
                    child: Text("Report"),
                    value: "clear chat",
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  PopupMenuItem(
                    child: Text("clear all chat"),
                    value: "clear chat",
                    onTap: () {
                      Navigator.pop(context);
                      clearChat();
                    },
                  ),
                ];
              },
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height / 1.25,
              width: size.width,
              child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection('chatroom')
                    .document(widget.chatRoomId)
                    .collection('chats')
                    .orderBy("time", descending: false)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.data != null) {
                    WidgetsBinding.instance
                        ?.addPostFrameCallback((_) => _scrollToBottom());
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: snapshot.data!.documents.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> map = snapshot.data!
                            .documents[index].data as Map<String, dynamic>;
                        return messages(size, map, context, index);
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            Container(
              height: size.height / 10,
              width: size.width,
              alignment: Alignment.center,
              child: Container(
                height: size.height / 12,
                width: size.width / 1.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: size.height / 16,
                      width: size.width / 1.3,
                      child: TextFormField(
                        controller: _message,
                        decoration: InputDecoration(
                            prefixIcon: IconButton(
                              onPressed: () => pickCameraImage(),
                              icon: Icon(Icons.camera),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () => pickGalleryImage(),
                              icon: Icon(Icons.photo),
                            ),
                            hintText: "Send Message",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            )),
                      ),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.send,
                          color: Colors.blue,
                        ),
                        onPressed: onSendMessage),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget messages(
      Size size, Map<String, dynamic> map, BuildContext context, int index) {
    return map['type'] == "text"
        ? Container(
            width: size.width,
            alignment: map['sender'] == Constants.myname
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.blue,
              ),
              child: InkWell(
                onLongPress: () {
                  _showMyDialog(context);
                },
                child: Text(
                  map['message'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        : Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0),
                    topLeft: Radius.circular(40.0),
                    bottomLeft: Radius.circular(40.0))),
            height: size.height / 2.5,
            width: size.width,
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            alignment: map['sender'] == Constants.myname
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: InkWell(
              onLongPress: () {
                _showMyDialog(context);
              },
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ShowImage(
                    imageUrl: map['message'],
                  ),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                ),
                alignment: map['message'] != "" ? null : Alignment.center,
                child: map['message'] != ""
                    ? Image.network(
                        map['message'],
                        fit: BoxFit.fill,
                      )
                    : CircularProgressIndicator(),
              ),
            ),
          );
  }
}

class ShowImage extends StatelessWidget {
  final String imageUrl;

  const ShowImage({required this.imageUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.black,
        child: Image.network(imageUrl),
      ),
    );
  }
}
