import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AllowCommentsFrom extends StatefulWidget {
  const AllowCommentsFrom({Key? key}) : super(key: key);

  @override
  _AllowCommentsFromState createState() => _AllowCommentsFromState();
}

class _AllowCommentsFromState extends State<AllowCommentsFrom> {
  bool everyone = false;
  bool people_you_follow= false;
  bool your_followers = false;
  bool people_you_follow_your_followers = false;
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
          'Allow Comments From',
          style: TextStyle(color: Colors.black),
        ),
        toolbarHeight: 50,
      ),
      body: Padding(
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
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('People you follow'),
                    Text('102 people',style: TextStyle(color: Colors.grey),)
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
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Your Followers'),
                    Text('102 people',style: TextStyle(color: Colors.grey),)
                  ],
                ),
                Container(
                  child: Switch(
                    value: your_followers,
                    onChanged: (value) {
                      setState(() {
                        your_followers = value;
                        your_followers == true
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
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('People you follow and your followers'),
                    Text('160 people',style: TextStyle(color: Colors.grey),)
                  ],
                ),
                Container(
                  child: Switch(
                    value: people_you_follow_your_followers,
                    onChanged: (value) {
                      setState(() {
                        people_you_follow_your_followers = value;
                        people_you_follow_your_followers == true
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
          ],
        ),
      ),
    );
  }
}
