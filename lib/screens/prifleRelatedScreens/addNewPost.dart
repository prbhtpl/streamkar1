import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/bottomNavigationBar/bottomNavigation.dart';
import 'package:http/http.dart' as http;
import '../../helper/helperFunctions.dart';

class AddPostSccreen extends StatefulWidget {
  const AddPostSccreen({Key? key, required this.imageFile}) : super(key: key);
  final File? imageFile;
  @override
  State<AddPostSccreen> createState() => _AddPostSccreenState();
}

class _AddPostSccreenState extends State<AddPostSccreen> {

  TextEditingController captionController = TextEditingController();
  int? id;  String ImagelUrl = '';
  List profile = [];
  String _name = '';
  bool loading =false;
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
  Future uploadPost() async {
    EasyLoading.show(status: 'Posting...');
    var uploadUrl =
    Uri.parse("https://vinsta.ggggg.in.net/api/PostImageText");
    var requestMulti = http.MultipartRequest('POST', uploadUrl);
    requestMulti.fields['user_id'] = id.toString();
    requestMulti.fields['content'] = captionController.text;
    if(widget.imageFile!=null){
      requestMulti.files.add(await http.MultipartFile.fromPath('post_image', widget.imageFile!.path));
      var res=await requestMulti.send();

      if(res.statusCode==200){
        print(widget.imageFile!.path);
        EasyLoading.showSuccess('Posted');
        EasyLoading.dismiss();
       setState(() {
         Navigator.pushReplacement(this.context, MaterialPageRoute(builder: (context)=>BottomNavigation(screenId: 0)));
       });
        print('Upload Data');

      }else{
        Fluttertoast.showToast(msg: 'Something went wrong upload again');
      }
      print(requestMulti.fields);
     // print(fileName);
      return res.reasonPhrase;
    }else {
      print('Image is not selected');
    }

  }
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
getallPreferences();
    super.initState();
  }
  @override
  void dispose() {
  captionController.dispose();
    super.dispose();
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

              uploadPost();
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
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  height: 60,
                  width: 60,
                  child: Image.file(
                    new File(widget.imageFile!.path),
                    fit: BoxFit.fill,
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
