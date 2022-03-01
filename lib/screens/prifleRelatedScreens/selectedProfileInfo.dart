// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class SelectedProfileInfo extends StatefulWidget {
  const SelectedProfileInfo({Key? key}) : super(key: key);

  @override
  _SelectedProfileInfoState createState() => _SelectedProfileInfoState();
}

class _SelectedProfileInfoState extends State<SelectedProfileInfo> {
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

        ],
        title: Text(
          ' Profile ',
          style: TextStyle(color: Colors.black),
        ),
        toolbarHeight: 50,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SizedBox(
            height: 20,
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
                      'Nickname',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      'Pal Prabhat',
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Birthday',
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  '27/09/1997',
                  style: TextStyle(fontSize: 15),
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
            child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Introduction',
                  style: TextStyle(color: Colors.grey),
                ),  Text(
                  "Death is nothing..its life that's hard",
                  style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),

              ],
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

    );
  }
}
