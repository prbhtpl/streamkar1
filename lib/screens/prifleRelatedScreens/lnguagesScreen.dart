import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
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
        actions: [],
        title: Text(
          'Language',
          style: TextStyle(color: Colors.black),
        ),
        toolbarHeight: 50,
      ),
      body: ListView.builder(itemCount: 7,itemBuilder: (BuildContext,int Index){
        return Column(crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            InkWell(onTap: (){},
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('English'),
            ),)
          ],
        );
      }),
    );
  }
}
