// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ActivityStatus extends StatefulWidget {
  const ActivityStatus({Key? key}) : super(key: key);

  @override
  _ActivityStatusState createState() => _ActivityStatusState();
}

class _ActivityStatusState extends State<ActivityStatus> {
  bool staus=false;
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
          'Activity Status',
          style: TextStyle(color: Colors.black),
        ),
        toolbarHeight: 50,
      ),
      body: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                'Show Activity Status',
                style: TextStyle( fontSize: 18),
              ),
            ),
            Container(
              child: Switch(
                value: staus,
                onChanged: (value) {
                  setState(() {
                    staus = value;

                  });
                },
              ),
            ),

          ],
        ),  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Text(
              "Allow accounts you follow and anyone you message to see when you are active or were last active on instagram apps. When this is turned off, you won't be able to see the activity status of the accounts",
              style: TextStyle(color: Colors.grey),
            ),
          ),
        )
      ],),

    );
  }
}
