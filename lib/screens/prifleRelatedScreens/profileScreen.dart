import 'dart:io';
import 'package:path/path.dart';
import 'package:photofilters/photofilters.dart';
import 'package:image/image.dart' as imageLib;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:untitled/helper/constants.dart';
import 'package:untitled/screens/prifleRelatedScreens/editphotoScreen.dart';
import 'package:untitled/screens/prifleRelatedScreens/settingPage.dart';
import 'package:untitled/screens/prifleRelatedScreens/topUpScreen.dart';

import 'deepAr.dart';
import 'followersList.dart';
import 'followingList.dart';
import 'friendList.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? imageFile;
/*  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick Image');
    }
  }*/
/*Future pickImage()async{
  try{
    final image=await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image==null) return;
    final imageTemporary=File(image.path);
    setState(() {
      this.image=imageTemporary;

    });
  } on PlatformException catch(e){
    print('Failed to pick Image');
  }

}*/

  Future<void> _CameraGalleryDialogue(BuildContext context) async {
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
                              builder: (context) => EditPic(
                                  imageFile: imageFile,
                                  source: ImageSource.camera)));
                      // pickImage(ImageSource.camera);
                    });
                  },
                  child: Row(
                    children: [
                      Text(
                        'Camera',
                        style: TextStyle(color: Colors.black),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              Navigator.push(
                                  this.context,
                                  MaterialPageRoute(
                                      builder: (context) => EditPic(
                                          imageFile: imageFile,
                                          source: ImageSource.camera)));
                              // pickImage(ImageSource.camera);
                            });
                          },
                          icon: Icon(
                            Icons.add_a_photo,
                            color: Colors.grey,
                          ))
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
                              builder: (context) => EditPic(
                                  imageFile: imageFile,
                                  source: ImageSource.gallery)));
                      // pickImage(ImageSource.gallery);
                    });
                  },
                  child: Row(
                    children: [
                      Text(
                        'Choose From Gallery',
                        style: TextStyle(color: Colors.black),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              Navigator.push(
                                  this.context,
                                  MaterialPageRoute(
                                      builder: (context) => EditPic(
                                          imageFile: imageFile,
                                          source: ImageSource.gallery)));

                              //  pickImage(ImageSource.gallery);
                            });
                          },
                          icon: Icon(
                            CupertinoIcons.camera_on_rectangle_fill,
                            color: Colors.grey,
                          ))
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
        renderPanelSheet: true,
        maxHeight: MediaQuery.of(context).size.height,
        minHeight: MediaQuery.of(context).size.height * 0.455,
        panel: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 80.0),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/nuts.png',
                        scale: 5,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '0',
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 80.0),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/diamond.png',
                        scale: 10,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '0',
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FriendListScreen()));
                  },
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, right: 8.0, left: 25.0),
                        child: Text(
                          '66',
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 18.0, right: 8.0, left: 25.0),
                        child: Text(
                          'Friends',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FollowersScreen()));
                  },
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, right: 8.0, left: 8.0),
                        child: Text(
                          '489',
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 18.0, right: 8.0, left: 8.0),
                        child: Text(
                          'Followers',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FollowingScreen()));
                    },
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, right: 25.0, left: 8.0),
                          child: Text(
                            '66',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 18.0, right: 25.0, left: 8.0),
                          child: Text(
                            'Following',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.orange.shade500,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.white),
                                  ),
                                  child: IconButton(
                                    icon: Icon(
                                      CupertinoIcons.bitcoin_circle_fill,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TopUpScreen()));
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: 80,
                                  child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TopUpScreen()));
                                      },
                                      child: Text('Top Up')),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.yellow.shade500,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.white),
                                  ),
                                  child: Icon(
                                    CupertinoIcons.suit_diamond_fill,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(width: 80, child: Text('earings')),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade200,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.white),
                                  ),
                                  child: Icon(
                                    CupertinoIcons.calendar_badge_minus,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(width: 80, child: Text('My Tasks')),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.deepPurpleAccent.shade200,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.white),
                                  ),
                                  child: Icon(
                                    CupertinoIcons
                                        .square_stack_3d_down_dottedline,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(width: 80, child: Text('Vip')),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            Text(
              'Moments',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey.shade200,
                        child: IconButton(
                          icon: Icon(
                            CupertinoIcons.add,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            _CameraGalleryDialogue(context);
                          },
                        )),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        child: ListView.builder(
                            itemCount: 10,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Container(
                                        width: 80,
                                        height: 80,
                                        color: Colors.grey.shade200,
                                        child: imageFile != null
                                            ? Image.file(
                                                imageFile!,
                                                width: 80,
                                                height: 80,
                                                fit: BoxFit.cover,
                                              )
                                            : FlutterLogo()),
                                  ],
                                ),
                              );
                            })),
                  ],
                ),
              ),
            )
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF9D6EF7),
                      Colors.lightBlueAccent.shade200
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(0.9, 0.2),
                    stops: [0.0, 1.0],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SettingScreen()));
                        },
                        icon: Icon(
                          CupertinoIcons.settings_solid,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.78,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.lightBlueAccent.shade200,
                        Colors.black12,
                        Color(0xFF9D6EF7),
                        Colors.lightBlueAccent.shade200,
                        Color(0xFF9D6EF7),
                        Color(0xFF9D6EF7),
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Center(
                            child: ClipOval(
                              child: Image.network(
                                'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
                                width: 130,
                                height: 130,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          Constants.myname.toUpperCase(),
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "id:622636",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "India",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 120.0, right: 120),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    color: Colors.lightGreen,
                                    borderRadius: BorderRadius.circular(5),
                                    border:
                                        Border.all(color: Colors.lightGreen)),
                                child: Text(
                                  'Lv 1',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.white),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    color: Colors.yellow.shade200,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: Colors.yellow.shade200)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      CupertinoIcons.heart_solid,
                                      color: Colors.red,
                                      size: 10,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '1',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  CupertinoIcons.forward_end_alt_fill,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  //   Navigator.push(context, MaterialPageRoute(builder: (context)=>DeepAr()));
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
