// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled/screens/chatBox.dart';

import '../../helper/constants.dart';
import '../../helper/helperFunctions.dart';
import '../../services/database.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  DataBaseMethods dataBaseMethods = new DataBaseMethods();
  TextEditingController searchBoxEditor = TextEditingController();
  QuerySnapshot? searchSnapShot;
  getUserInfo() async {
    Constants.myname = await HelperFunctions.getuserNameSharedPreference();
    setState(() {});
    print("myname:${Constants.myname}");
  }

  initiateSearch() {
    dataBaseMethods.getUserByUserName(searchBoxEditor.text).then((val) {
      setState(() {
        searchSnapShot = val;
        print(searchSnapShot);
      });
    });
  }

  createChatRoomAndStartConversation(String userName) {
    if (userName != Constants.myname) {
      String chatRoomId = getChatRoomId(userName, Constants.myname);
      List<String> users = [userName, Constants.myname];
      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatroomid": chatRoomId
      };
      dataBaseMethods.createChatRoom(chatRoomId, chatRoomMap);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChatBox(
                    chatRoomId: chatRoomId,
                    otherUserName: userName,
                  )));
    } else {
      print('That is wrong');
    }
  }

  Widget searchList() {
    return searchSnapShot != null
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchSnapShot!.documents.length,
            itemBuilder: (BuildContext, int index) {
              return searchTile(
                userName: searchSnapShot!.documents[index].data['name'],
                userEmail: searchSnapShot!.documents[index].data['email'],
              );
            })
        : Container();
  }

  Widget searchTile(
      {required String userName, required String userEmail, username}) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.black,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              Text(
                userEmail,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ],
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                createChatRoomAndStartConversation(userName);
              },
              child: Text('Message'),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }
@override
  void dispose() {
  searchBoxEditor.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Here'),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    controller: searchBoxEditor,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: 'Search your friends here'),
                  )),
                  InkWell(
                    onTap: () {print("hello");
                      initiateSearch();
                    },
                    child: Icon(Icons.search),
                  )
                ],
              ),
            ),
            searchList()
          ],
        ),
      ),
    );
  }
}

/*class SearchTile extends StatelessWidget {
  final String username;
  final String userEmail;

  const SearchTile({Key? key, required this.username, required this.userEmail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.black,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              Text(
                userEmail,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ],
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Message'),
            ),
          )
        ],
      ),
    );
  }
}*/

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return '$b\_$a';
  } else {
    return '$a\_$b';
  }
}
