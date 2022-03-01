import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import '../prifleRelatedScreens/profileInfoScreen.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({Key? key}) : super(key: key);

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {

List related_product=[];
  Future GetEmojis() async {
    var api = Uri.parse("https://emoji-api.com/emojis?access_key=3aaec15c05716d94805ee9d08e843d140a4cf631");
    final response = await http.get(
      api,

    );

    var res = await json.decode(response.body);

    setState(() {
      related_product = res;
    });
   /* print("hererere  " + related_product[0]['unicodeName'].toString());*/
  }

  bool fill = true;
  @override
  void initState() {
    GetEmojis();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 120,
        color: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 45,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(scrollDirection:Axis.horizontal,itemCount: related_product.length,itemBuilder: (BuildContext,int index){
                  return IconButton(onPressed: (){}, icon: Text(related_product[index]['character'].toString(),style: TextStyle(fontSize: 25),),);
                }),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover, image: AssetImage('assets/2.jpg')),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 250,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Colors.white54, width: 0),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.white54,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                        ),
                        hintText: 'Comment as User!',
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      'post',
                      style: TextStyle(color: Colors.lightBlueAccent),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              CupertinoIcons.back,
              color: Colors.black,
            )),
        title: Text(
          'Comments',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        
      ),
      body: ListView.builder(
          itemCount: 50,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                ListTile(
                    leading: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileInfo()));
                      },
                      child: Stack(children: [
                        CircleAvatar(child: Image.asset('assets/person.jpg')),
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: Colors.white),
                          ),
                          child: Icon(
                            CupertinoIcons.person_alt_circle,
                            color: Colors.white,
                            size: 8,
                          ),
                        ),
                      ]),
                    ),
                    trailing: ButtonTheme(
                      minWidth: 12,
                      height: 14,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: IconButton(
                        icon: fill
                            ? Icon(
                                CupertinoIcons.heart,
                                size: 18,
                              )
                            : Icon(
                                CupertinoIcons.heart_solid,
                                color: Colors.red,
                                size: 18,
                              ),
                        onPressed: () {
                          fill = !fill;

                          setState(() {
                            /* fill == false
                                      ? Fluttertoast.showToast(
                                      msg: 'Added to wishlist',
                                      fontSize: 18,
                                      gravity: ToastGravity.BOTTOM)
                                      : Fluttertoast.showToast(
                                      msg: 'Removed from wishlist',
                                      fontSize: 18,
                                      gravity: ToastGravity.BOTTOM);*/
                          });
                        },
                      ),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Emil 554")),
                        InkWell(child: Text(related_product[index]['character'].toString(),style: TextStyle(fontSize: 20),)),
                        Row(
                          children: [
                            Text(
                              '$index h',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 10),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                                onTap: () {},
                                child: Text(
                                  'Likes',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10),
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                                onTap: () {},
                                child: Text(
                                  'Reply',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10),
                                )),
                          ],
                        ),
                      ],
                    )),
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                )
              ],
            );
          }),
    );
  }
}
