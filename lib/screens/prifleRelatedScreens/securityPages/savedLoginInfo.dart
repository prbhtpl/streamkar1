import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SavedLoginInfoScreen extends StatefulWidget {
  const SavedLoginInfoScreen({Key? key}) : super(key: key);

  @override
  _SavedLoginInfoScreenState createState() => _SavedLoginInfoScreenState();
}

class _SavedLoginInfoScreenState extends State<SavedLoginInfoScreen> {
  bool status = false;
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
          'Saved Login Information',
          style: TextStyle(color: Colors.black),
        ),
        toolbarHeight: 50,
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 10.0, right: 10, top: 8, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Saved Login'),
                Switch(
                  value: status,
                  onChanged: (value) {
                    setState(() {
                      status = value;
                      status == true
                          ? Fluttertoast.showToast(msg: 'Password Saved')
                          : Fluttertoast.showToast(msg: 'Password Removed');
                    });
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10, left: 10, bottom: 5, top: 5),
            child: Container(
              child: Text(
                "We'll remember your account information for you on this device. You won't need to enter it when logged in again.",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          )
        ],
      ),
    );
  }
}
