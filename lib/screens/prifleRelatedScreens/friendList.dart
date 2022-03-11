import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/screens/prifleRelatedScreens/profileInfoScreen.dart';

class FriendListScreen extends StatefulWidget {
  const FriendListScreen({Key? key}) : super(key: key);

  @override
  _FriendListScreenState createState() => _FriendListScreenState();
}

class _FriendListScreenState extends State<FriendListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar:
          AppBar(
            backgroundColor: Colors.white,
            bottomOpacity: 0.0,
            elevation: 2.0,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(CupertinoIcons.left_chevron,color: Colors.black,)),
            actions: [

            ],
            title: Text('Friend List',style: TextStyle(color: Colors.black),),
            toolbarHeight: 50,
          ),
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                ListTile(
                    leading: InkWell(onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileInfo()));
                    },
                      child: Stack(
                          children:[
                            CircleAvatar(
                                child: Image.asset('assets/person.jpg')
                            ),
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: Colors.purple,
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(color: Colors.white),
                              ),
                              child: Icon( CupertinoIcons.person_alt_circle,
                                color: Colors.white,size: 8,),

                            ),
                          ]
                      ),
                    ),

                    title:Column(
                      children: [
                        Align(alignment: Alignment.centerLeft,child: Text("Emil 554")),
                        Row(

                          children: [
                            Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  color: Colors.lightGreen,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.lightGreen)),
                              child: Text(
                                'Lv 1',
                                style: TextStyle(fontSize: 10, color: Colors.white),
                              ),
                            ),SizedBox(width: 5,),
                            Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  color: Colors.yellow.shade200,
                                  borderRadius: BorderRadius.circular(5),
                                  border:
                                  Border.all(color: Colors.yellow.shade200)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    CupertinoIcons.heart_solid,
                                    color: Colors.red,
                                    size: 10,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '1',
                                    style: TextStyle(
                                        fontSize: 10, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),SizedBox(width: 5,),
                            Text('Last Online :265 days...',style: TextStyle(color: Colors.grey,fontSize: 13),)
                          ],
                        ),
                      ],
                    )
                ),
                Divider(color: Colors.grey,thickness: 1,)
              ],
            );

          }),
    );
  }
}