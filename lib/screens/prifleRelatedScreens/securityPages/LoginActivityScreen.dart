import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginActivityScreen extends StatefulWidget {
  const LoginActivityScreen({Key? key}) : super(key: key);

  @override
  _LoginActivityScreenState createState() => _LoginActivityScreenState();
}

class _LoginActivityScreenState extends State<LoginActivityScreen> {
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
          'Login Activity',
          style: TextStyle(color: Colors.black),
        ),
        toolbarHeight: 50,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                'Where your are logged In',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(CupertinoIcons.location_solid),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Lucknow, Uttar Pradesh'),
                    Row(
                      children: [
                        Text(
                          'Active Now',
                          style: TextStyle(color: Colors.green),
                        ),
                        Text(
                          'This Samsung SM-J415F',
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    )
                  ],
                ),
                PopupMenuButton<String>(
                  icon: Icon(
                    CupertinoIcons.ellipsis_vertical,
                    color: Colors.black,
                  ),
                  padding: EdgeInsets.all(0),
                  onSelected: (value) {
                    print(value);
                  },
                  itemBuilder: (BuildContext contesxt) {
                    return [
                      PopupMenuItem(
                        child: Text("Log Out"),
                        value: "clear chat",
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ];
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
