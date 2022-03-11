import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MentionsScreen extends StatefulWidget {
  const MentionsScreen({Key? key}) : super(key: key);

  @override
  _MentionsScreenState createState() => _MentionsScreenState();
}

class _MentionsScreenState extends State<MentionsScreen> {
  bool everyone = false;
  bool people_you_follow = false;
  bool no_one = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              CupertinoIcons.left_chevron,
              color: Colors.black,
            )),
        actions: [],
        title: Text(
          'Mentions',
          style: TextStyle(color: Colors.black),
        ),
        toolbarHeight: 50,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              'Allow @mentions from',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('EveryOne'),
                    Container(
                      child: Switch(
                        value: everyone,
                        onChanged: (value) {
                          setState(() {
                            everyone = value;
                            everyone == true
                                ? Fluttertoast.showToast(
                                    msg:
                                        'Only your followers will be able to see your photos and videos')
                                : Fluttertoast.showToast(
                                    msg:
                                        'Anyone  will be able to see your photos and videos');
                          });
                        },
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('People you follow'),
                        Text(
                          '102 people',
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                    Container(
                      child: Switch(
                        value: people_you_follow,
                        onChanged: (value) {
                          setState(() {
                            people_you_follow = value;
                            people_you_follow == true
                                ? Fluttertoast.showToast(
                                    msg:
                                        'Only your followers will be able to see your photos and videos')
                                : Fluttertoast.showToast(
                                    msg:
                                        'Anyone  will be able to see your photos and videos');
                          });
                        },
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Your Followers'),
                        Text(
                          '102 people',
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                    Container(
                      child: Switch(
                        value: no_one,
                        onChanged: (value) {
                          setState(() {
                            no_one = value;
                            no_one == true
                                ? Fluttertoast.showToast(
                                    msg:
                                        'Only your followers will be able to see your photos and videos')
                                : Fluttertoast.showToast(
                                    msg:
                                        'Anyone  will be able to see your photos and videos');
                          });
                        },
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      child: Text(
                    "Choose who can @mention you to link your account in their stories, comments, live videos and captions. When people try to @mention you, they'll see if dont't allow mentions.",
                    style: TextStyle(color: Colors.grey),
                  )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
