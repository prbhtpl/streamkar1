import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class GuidesScreen extends StatefulWidget {
  const GuidesScreen({Key? key}) : super(key: key);

  @override
  _GuidesScreenState createState() => _GuidesScreenState();
}

class _GuidesScreenState extends State<GuidesScreen> {
  bool allow=false;
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
          'Guides controls',
          style: TextStyle(color: Colors.black),
        ),
        toolbarHeight: 50,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            'Your Posts',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Allow others to use your posts'),
                  Container(child: Text('Other people can add your posts to their guides. \nYour username will always appear with your posts.',style: TextStyle(color: Colors.grey),)),

                ],
              ),
              Container(
                child: Switch(
                  value: allow,
                  onChanged: (value) {
                    setState(() {
                      allow = value;

                    });
                  },
                ),
              )
            ],
          ),
        ),
      ],),
    );
  }
}
