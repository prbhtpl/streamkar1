import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/helper/constants.dart';
import 'package:untitled/helper/helperFunctions.dart';
import 'package:untitled/screens/prifleRelatedScreens/profileScreen.dart';
import 'package:uuid/uuid.dart';

import '../../modal/user.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String _selectedGender = 'male';
  File? image;
  String? userId;
  bool loading = false;
  TextEditingController EditedName = TextEditingController();
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
                      Navigator.pop(context);
                      pickCameraImage();
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
                      Navigator.pop(context);
                      pickGalleryImage();
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
              child: TextField(
                controller: EditedName,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'Change Nickname'),
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
                    inputData();
                    Navigator.pop(context);
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

  Future<void> _showChooseGenderDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Select Your Gender'),
          actions: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ListTile(
                  leading: Radio<String>(
                    value: 'male',
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value!;
                      });
                    },
                  ),
                  title: const Text('Male'),
                ),
                ListTile(
                  leading: Radio<String>(
                    value: 'female',
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value!;
                      });
                    },
                  ),
                  title: const Text('Female'),
                ),
              ],
            )
          ],
        );
      },
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
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'Tell Us about yourself'),
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
                  onPressed: () {},
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

  Future pickGalleryImage() async {
    ImagePicker _picker = ImagePicker();

    await _picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        image = File(xFile.path);
        //uploadFile();
        uploadImage();
      }
    });
  }

  Future pickCameraImage() async {
    ImagePicker _picker = ImagePicker();

    await _picker.pickImage(source: ImageSource.camera).then((xFile) {
      if (xFile != null) {
        image = File(xFile.path);
        //uploadFile();
        uploadImage();
      }
    });
  }

  Future refreshingUrl() async {
    Constants.profilePicUrl =
        await HelperFunctions.getuserProfilePicSharedPreference();
    setState(() {
      /*loading=true;*/
    });
  }

  Future uploadImage() async {
    String? fileName = Uuid().v1();
    int status = 1;

    /*await Firestore.instance
        .collection('chatroom')
        .document(widget.chatRoomId)
        .collection('chats')
        .document(fileName)
        .setData({
      "sender": Constants.myname,
      "message": "",
      "type": "img",
      "time": FieldValue.serverTimestamp(),
    });*/

    var ref = FirebaseStorage.instance
        .ref()
        .child('profile_pics')
        .child("$fileName.jpg");

    var uploadTask = await ref.putFile(image).onComplete;

    if (status == 1) {
      String imageUrl = await uploadTask.ref.getDownloadURL();

      HelperFunctions.saveuserProfilepicSharedPreference(imageUrl);

      setState(() {});

      print(Constants.profilePicUrl);
    }
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> inputData() async {
    userId = await HelperFunctions.getCurrentUserIdSharedPreference();
    print("uid:${userId}");
    // here you write the codes to input the data into firestore
    await Firestore.instance
        .collection('users')
        .document(userId)
        .updateData({"name": EditedName.text});
    HelperFunctions.saveuserUpdatedNameSharedPreference(EditedName.text);
    Constants.updatedName =
        await HelperFunctions.getUpdateNameSharedPreference();
  }

  @override
  void initState() {
    refreshingUrl();

    print(Constants.updatedName);
    setState(() {
      loading = !loading;
    });
    super.initState();
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
                child: InkWell(
              child: Text(
                'Save',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
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
                      border: Border.all(color: Colors.blue, width: 4),
                    ),
                    child: ClipOval(
                        child: loading == false
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Image.network(
                                Constants.profilePicUrl.toString(),
                                fit: BoxFit.fill,
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
                          Constants.updatedName,
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
                        '622161916',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
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
              child: InkWell(
                onTap: () {
                  setState(() {
                    _showChooseGenderDialog();
                  });
                },
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
                          'Male',
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
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Birthday',
                      style: TextStyle(color: Colors.grey),
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
                    Text(
                      'Introduction',
                      style: TextStyle(color: Colors.grey),
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
