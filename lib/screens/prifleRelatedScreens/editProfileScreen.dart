import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/bottomNavigationBar/bottomNavigation.dart';
import 'package:untitled/helper/constants.dart';
import 'package:untitled/helper/helperFunctions.dart';

import 'package:http/http.dart' as http;

import 'editProfilephoto2.dart';

enum addType {
  Male,
  Female,
}

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final formKey = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  addType? _character =addType.Male;
  String addtype = 'Male';
  File? imageFile;
  String? userId;
  bool loading = false;
  TextEditingController EditedName = TextEditingController();
  TextEditingController Introduction = TextEditingController();
  TextEditingController Dob = TextEditingController();
  int? id;
  String _name = "";
  String name = '';
  String vId = '';
  String region = '';
  String ImagelUrl = '';
  String dob = '';
  String introduction = '';
  String gender = '';

  List profile = [];
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          actions: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                          this.context,
                          MaterialPageRoute(
                              builder: (context) => EditProfilePic2(
                                  imageFile: imageFile,
                                  source: ImageSource.camera)));
                      //  pickCameraImage();
                    });
                  },
                  child: Row(
                    children: [
                      Text(
                        'Choose From Camera',
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        CupertinoIcons.camera_fill,
                        color: Colors.grey,
                      )
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white, elevation: 0),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                          this.context,
                          MaterialPageRoute(
                              builder: (context) => EditProfilePic2(
                                  imageFile: imageFile,
                                  source: ImageSource.gallery)));
                    });
                  },
                  child: Row(
                    children: [
                      Text(
                        'Choose From Gallery',
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        CupertinoIcons.camera_on_rectangle_fill,
                        color: Colors.grey,
                      )
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white, elevation: 0),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  Future<void> _showEditNameDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
              // Specify some width
              width: MediaQuery.of(context).size.width * .7,
              child: Form(key: formKey,
                child: TextFormField(validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your name";
                  }
                  return null;
                },
                  controller: EditedName,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(hintText: name.toString()),
                ),
              )),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 108.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white, elevation: 0),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if(formKey.currentState!.validate()){
                      Navigator.pop(context);
                    }else{
                      Fluttertoast.showToast(msg: 'This cannot be empty');
                    }

                  },
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.pink.shade300),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white, elevation: 0),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  Widget RadioButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Radio<addType>(
              value: addType.Male,
              groupValue: _character,
              onChanged: (addType? value) {
                setState(() {
                  _character = value;
                  addtype = addType.Male.name;
                });
                print(addtype);
              },
            ),
            SizedBox(
              width: 10,
            ),
            Text('Male'),
          ],
        ),
        Row(
          children: [
            Radio<addType>(
              value: addType.Female,
              groupValue: _character,
              onChanged: (addType? value) {
                setState(() {
                  _character = value;
                  addtype = addType.Female.name;
                });
                print(addtype);
              },
            ),
            SizedBox(
              width: 10,
            ),
            Text('Female'),
          ],
        )
      ],
    );
  }

  Future<void> _showTellUsDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
              // Specify some width
              width: MediaQuery.of(context).size.width * .7,
              child: Form(key: formKey2,
                child: TextFormField(validator: (value) {
                  if (value!.isEmpty  ) {
                    return "Enter something about yourself.";
                  }else{

                  }

                },
                  controller: Introduction,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(hintText: 'Tell Us about yourself'),
                ),
              )),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 108.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white, elevation: 0),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if(formKey2.currentState!.validate()){
                      Navigator.pop(context);
                    }else{
                      Fluttertoast.showToast(msg: 'Enter Intro');
                    }

                  },
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.pink.shade300),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white, elevation: 0),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  Future<void> _showDOBDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
              // Specify some width
              width: MediaQuery.of(context).size.width * .7,
              child: Form(key: formKey1,
                child: TextFormField(  validator:  (value) {
                  if (value!.isEmpty ) {
                    return "Please enter Dob";
                  }
                  return null;
                },
                  controller: Dob,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(hintText: 'DD/MM/YY'),
                ),
              )),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 108.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);

                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white, elevation: 0),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if(formKey1.currentState!.validate()){
                      Navigator.pop(context);
                    }else{
                      Fluttertoast.showToast(msg: 'Required to Update');
                    }
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.pink.shade300),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white, elevation: 0),
                ),
              ],
            )
          ],
        );
      },
    );
  }

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

  Future getUserDetails() async {
    var api = Uri.parse("https://vinsta.ggggg.in.net/api/profileGet");
    EasyLoading.show(status: 'Loading...');
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
      ImagelUrl = profile[0]['userphoto'].toString();
      gender = profile[0]['gender'].toString();
      name = profile[0]['user_name'].toString();
      region = profile[0]['region'].toString();
      vId = profile[0]['user_code'].toString();
      dob = profile[0]['dob'].toString();
      introduction = profile[0]['introduction'].toString();
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


  Future insertDataToProfile() async {
   if(EditedName.text.isNotEmpty && Dob.text.isNotEmpty && Introduction.text.isNotEmpty){
     EasyLoading.show(status: 'Updating...');

     var api = Uri.parse("https://vinsta.ggggg.in.net/api/userProfile");

     Map mapeddate = {
       'user_id': id.toString(),
       'user_name': EditedName.text,
       'gender': addtype.toString(),
       'dob': Dob.text,
       'region': 'India',
       'introduction': Introduction.text,
     };

     final response = await http.post(
       api,
       body: mapeddate,
     );

     var res = await json.decode(response.body);
     print("hererere" + response.body);


     try {
       if (response.statusCode == 200) {
         EasyLoading.showSuccess("Updated");
         EasyLoading.dismiss();
         setState(() {
           Navigator.pushReplacement(
               context,
               MaterialPageRoute(
                   builder: (context) => BottomNavigation(
                     screenId: 4,
                   )));
         });
       }
     } catch (e) {
       print(e);
     }
   }else{
     Fluttertoast.showToast(msg: 'Fill all fields first');
   }
  }

  @override
  void initState() {
    getUserDetails();
    getallPreferences();
    print(Constants.updatedName);
    setState(() {

    });
    super.initState();
  }

  @override
  void dispose() {
    EditedName.dispose();
    Introduction.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottomOpacity: 0.0,
        elevation: 2.0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              CupertinoIcons.left_chevron,
              color: Colors.black,
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
                child: TextButton(
              child: Text(
                'Save',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                insertDataToProfile();
               // UpdateProfile();
              },
            )),
          )
        ],
        title: Text(
          'Edit Profile ',
          style: TextStyle(color: Colors.black),
        ),
        toolbarHeight: 50,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(
                  child: Column(
                children: [
                  Container(
                    width: 125,
                    height: 125,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Colors.blue, width: 1),
                    ),
                    child: ClipOval(
                        child: loading!=true
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Image.network(
                                ImagelUrl.toString(),
                                fit: BoxFit.cover,
                              )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                      onTap: () {
                        _showMyDialog();
                      },
                      child: Text('Change Photo'))
                ],
              )),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                _showEditNameDialog();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nickname',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                       name.toString(),
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    Icon(CupertinoIcons.right_chevron)
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.grey,
              indent: 15,
              endIndent: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ID',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        ' ${vId.toString()}',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: vId.toString()));
                      Fluttertoast.showToast(msg: 'Copied');
                    },
                    child: Text('Copy'),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.pinkAccent.shade200),
                  )
                ],
              ),
            ),
            Divider(
              color: Colors.grey,
              indent: 15,
              endIndent: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Gender',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        gender.toString(),
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  RadioButtons(),
                ],
              ),
            ),
            Divider(
              color: Colors.grey,
              indent: 15,
              endIndent: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Region',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        'India',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey,
              indent: 15,
              endIndent: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  _showDOBDialog();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Birthday: ',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          dob.toString(),
                        ),
                      ],
                    ),
                    Icon(CupertinoIcons.right_chevron)
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.grey,
              indent: 15,
              endIndent: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  _showTellUsDialog();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Introduction',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Container(
                          child: Text(
                            introduction.toString(),
                          ),
                        ),
                      ],
                    ),
                    Icon(CupertinoIcons.right_chevron)
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.grey.shade500,
              indent: 15,
              endIndent: 15,
              thickness: 3,
            ),
          ],
        ),
      ),
    );
  }
}
