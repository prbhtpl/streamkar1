import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/bottomNavigationBar/bottomNavigation.dart';

import '../prifleRelatedScreens/profileInfoScreen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 2,
        backgroundColor: Colors.white,
        title: Text(
          'Notifications',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0, bottom: 10, top: 10),
              child: Text('New',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            ),

Container(height:MediaQuery.of(context).size.height,child: ListView.builder(

    itemCount: 50,
    itemBuilder: (BuildContext, int index) {
      return Column(
        children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    child: Stack(children: [
                      CircleAvatar(maxRadius: 25,child: Image.asset('assets/person.jpg')),
                      Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.white),
                        ),
                        child: Icon(
                          CupertinoIcons.person_alt_circle,
                          color: Colors.white,
                          size: 8,
                        ),
                      ),
                    ])
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(onTap:(){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>BottomNavigation(screenId: 0)));
                  },
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'name',
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        ),
                        Container(height: 40,width: 230,
                          child: Text(
                            'asdascsass',
                            style: TextStyle(),
                          ),
                        ),
                        Text(
                          '17 minutes ago',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              IconButton(onPressed: (){
                onoNotificationOptions();
              }, icon:Icon(Icons.more_vert))
            ],
          ),
        )
        ],
      );
    })
  ,),






          ],
        ),
      ),
    );
  }
  void onoNotificationOptions() {
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
                        height: 300,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Divider(
                                thickness: 5,
                                indent: 160,
                                endIndent: 160,
                              ),
                              CircleAvatar(maxRadius: 30,child: Image.asset('assets/person.jpg')),
                              Container(height: 40,width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Notfication Content is  here',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade400,
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(color: Colors.white),
                                    ),
                                    child: Icon(
                                      CupertinoIcons.clear_circled_solid,

                                  
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text('Remove this notification'),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade400,
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(color: Colors.white),
                                    ),
                                    child: Icon(
                                      CupertinoIcons.square_stack,


                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(height: 40,width: MediaQuery.of(context).size.width*0.75,child: Text('Turn off notifications about friends birthdays')),
                                  ),
                                ],
                              ),     Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade400,
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(color: Colors.white),
                                    ),
                                    child: Icon(
                                      CupertinoIcons.exclamationmark_bubble_fill,


                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text('Report issue to Notifications Team'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              });
        });
  }
}
