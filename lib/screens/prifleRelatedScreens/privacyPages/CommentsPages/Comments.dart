import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'allowCommentsFrom.dart';
import 'blockComments.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({Key? key}) : super(key: key);

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
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
          'Comments',
          style: TextStyle(color: Colors.black),
        ),
        toolbarHeight: 50,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              'Controls',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AllowCommentsFrom()));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Allow comments from ',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  Text(
                    'Everyone',
                    style: TextStyle(color: Colors.black26),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          InkWell(
            onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context)=>BlockComments()));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Block comments from ',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  Text(
                    'Everyone',
                    style: TextStyle(color: Colors.black26),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Text(
                "Any new comments from people you block won't be visible to anyone but them.",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          )
        ],
      ),
    );
  }
}
