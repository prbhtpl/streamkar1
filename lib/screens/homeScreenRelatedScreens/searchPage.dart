import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed:(){
                    Navigator.pop(context);
                  },
        icon:  Icon(
          CupertinoIcons.back,

        ),),
                  Container(
                    height: 30,
                    width: 250,
                    child: TextField(
                      decoration: InputDecoration( enabledBorder: const OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderSide: const BorderSide(color: Colors.white, width: 0.0),
                      ),
                          contentPadding:
                          EdgeInsets.only(top: 10, left: 10),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              25,
                            ),
                          ),
                          hintText: 'Search by username / userId',
                          hintStyle: TextStyle(
                              fontSize: 12, color: Colors.grey)),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      InkWell(onTap:(){},
                        child:  Icon(
                          CupertinoIcons.search,

                        ),
                      ),

                    ],
                  )
                ],
              ),
            ),
            Divider()
          ],
        ),
      ),
    );
  }
}
