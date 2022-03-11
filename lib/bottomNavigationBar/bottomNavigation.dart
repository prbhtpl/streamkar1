import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../myhomePage.dart';
import '../screens/inboxPages/inboxScreen.dart';
import '../screens/prifleRelatedScreens/profileScreen.dart';
import '../screens/recordVideoScreens/recordVideo.dart';
import '../screens/reelSectionPages/reelVideos.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key, required this.screenId}) : super(key: key);
  final int screenId;

  @override
  _BottomNavigationState createState() => _BottomNavigationState(this.screenId);
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    MyHomePage(),
    ReelVideos(),
    RecordVideo(),
    InboxScreen(),
    ProfileScreen()
  ];

  _BottomNavigationState(this._selectedIndex);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.play_arrow_solid),
            label: 'Reels',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.videocam_fill,

            ),
            label: 'Record',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.ellipses_bubble),
            label: 'Inbox',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chart_bar_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.purpleAccent,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}
