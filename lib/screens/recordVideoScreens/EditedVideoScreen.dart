import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import '../../helper/helperFunctions.dart';
class EditedVideo extends StatefulWidget {
  const EditedVideo({Key? key ,required this.filePath}) : super(key: key);
  final String filePath;
  @override
  State<EditedVideo> createState() => _EditedVideoState();
}

class _EditedVideoState extends State<EditedVideo> {
  String ImagelUrl = '';
  List profile = [];
  String _name = '';
  bool loading =false;
  TextEditingController captionController = TextEditingController();
  late VideoPlayerController _videoPlayerController;
  Future getUserDetails() async {
    EasyLoading.show(status: 'Loading...');
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
  @override
  void initState() {
    getUserDetails();
    super.initState();
  }
  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future _initVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.file(File(widget.filePath));
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          'New Post',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(CupertinoIcons.arrow_left),
          color: Colors.black,
        ),
        actions: [
          IconButton(
            onPressed: () {

              /* uploadPost();*/
            },
            icon: Icon(CupertinoIcons.checkmark_alt),
            color: Colors.black,
          )
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: ClipOval(
                    child:loading!=true?Container(height: 10,width: 10,child: CircularProgressIndicator(),): Image.network(
                      ImagelUrl!=null?ImagelUrl.toString():"No Image Found",
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: new TextFormField(controller: captionController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: "Write Caption",
                      hintStyle: TextStyle(fontSize: 14)),
                  maxLines: 5,
                  minLines: 2,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0,left: 0,right: 15,bottom: 8),
                child: Container(
                  height: 70,width: 70,
                  child: FutureBuilder(
                    future: _initVideoPlayer(),
                    builder: (context, state) {
                      if (state.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return VideoPlayer(_videoPlayerController);
                      }
                    },
                  ),
                ),
              )
            ],
          ),
          Divider()
        ],
      ),
    );
  }
}
