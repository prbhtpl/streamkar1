import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class BlockComments extends StatefulWidget {
  const BlockComments({Key? key}) : super(key: key);

  @override
  _BlockCommentsState createState() => _BlockCommentsState();
}

class _BlockCommentsState extends State<BlockComments> {
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
          'BLock Commenters',
          style: TextStyle(color: Colors.black),
        ),
        toolbarHeight: 50,
      ),
      body: Container(
        child: Center(
          child: Text('No data found'),
        ),
      ),
    );
  }
}
