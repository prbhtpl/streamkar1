
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/bottomNavigationBar/bottomNavigation.dart';
class MyTaskScreen extends StatefulWidget {
  const MyTaskScreen({Key? key}) : super(key: key);

  @override
  State<MyTaskScreen> createState() => _MyTaskScreenState();
}

class _MyTaskScreenState extends State<MyTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(floatingActionButton: Stack(children: [
      Container(width:MediaQuery.of(context).size.width,height: 65,color: Colors.white70,),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
          Row(children: [ Container(height: 50,width: 50,
            child: ClipOval(
              child:Image.asset('assets/logo.jpeg'),

            ),
          ),SizedBox(width: 10,),
            Text('Prabhat Pal'),],),
          Row(children: [ Text('400'),SizedBox(width: 10,),
            Icon(CupertinoIcons.star_fill,color: Colors.deepOrange.shade300,)],),



        ],),
      )
    ],),floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(foregroundColor: Colors.black,backgroundColor: Colors.white70,elevation: 0.5,toolbarHeight: 40,title: Text('My Task'),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(  child: GridView.builder(shrinkWrap: true,
    itemCount:10,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio:0.75,mainAxisSpacing: 10,
    crossAxisCount:  5 ),
    itemBuilder: (BuildContext context, int index) {
    return Card(
            elevation: 1,child: GridTile(header: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("${index}",style: TextStyle(color: Colors.white),),
            ),child: Container(decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              gradient: LinearGradient(
                  colors: [
                    Colors.pink.shade600,
                    Colors.pinkAccent.shade200,
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),child: Center(child: Icon(CupertinoIcons.star_fill,color: Colors.orangeAccent.shade200,))),footer: Center(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('${index*100}',style: TextStyle(color: Colors.white),),
            ),),));
    },
              ),),
    OutlinedButton(
    onPressed: (){},
    style:  OutlinedButton.styleFrom( side: BorderSide(width: 1.0, color: Colors.pinkAccent),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
    ),
    child: const Text("Claim",style: TextStyle(color: Colors.pinkAccent),),
    ),
Align(alignment: Alignment.topLeft,child: Text('Tasks')),

              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                Row(children: [Container(decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  gradient: LinearGradient(
                      colors: [
                        Colors.pink.shade600,
                        Colors.pinkAccent.shade200,
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                  height:60,width:60,child: Icon(Icons.ac_unit,color: Colors.orange.shade200,size: 46,),),
                 SizedBox(width: 10,), Text('Lucky Draw'),],),
                OutlinedButton(
                  onPressed: (){},
                  style:  OutlinedButton.styleFrom( side: BorderSide(width: 1.0, color: Colors.pinkAccent),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
                  ),
                  child: const Text("To do",style: TextStyle(color: Colors.pinkAccent),),
                ),
              ],),
              Divider(),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                Row(children: [Container(decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  gradient: LinearGradient(
                      colors: [
                        Colors.pink.shade600,
                        Colors.pinkAccent.shade200,
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                  height:60,width:60,child: Column(
                    children: [
                      Icon(Icons.star,color: Colors.orange.shade200,size: 35,),
                      Center(child: Text('+50',style: TextStyle(color: Colors.white),),)
                    ],
                  ),),
                  SizedBox(width: 10,), Text('Send Message 1x'),],),
                OutlinedButton(
                  onPressed: (){},
                  style:  OutlinedButton.styleFrom( side: BorderSide(width: 1.0, color: Colors.pinkAccent),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
                  ),
                  child: const Text("Send 1x gift",style: TextStyle(color: Colors.pinkAccent),),
                ),
              ],),
              Divider(),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                Row(children: [Container(decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  gradient: LinearGradient(
                      colors: [
                        Colors.pink.shade600,
                        Colors.pinkAccent.shade200,
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                  height:60,width:60,child:Column(
                    children: [
                      Icon(Icons.star,color: Colors.orange.shade200,size: 35,),
                      Center(child: Text('+50',style: TextStyle(color: Colors.white),),)
                    ],
                  ),),
                  SizedBox(width: 10,), Text('Send 1x gift'),],),
                OutlinedButton(
                  onPressed: (){},
                  style:  OutlinedButton.styleFrom( side: BorderSide(width: 1.0, color: Colors.pinkAccent),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
                  ),
                  child: const Text("To do",style: TextStyle(color: Colors.pinkAccent),),
                ),
              ],),
              Divider(),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                Row(children: [Container(decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  gradient: LinearGradient(
                      colors: [
                        Colors.pink.shade600,
                        Colors.pinkAccent.shade200,
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                  height:60,width:60,child:Column(
                    children: [
                      Icon(Icons.star,color: Colors.orange.shade200,size: 35,),
                      Center(child: Text('+50',style: TextStyle(color: Colors.white),),)
                    ],
                  ),),
                  SizedBox(width: 10,), Text('Follow 1x talent Draw'),],),
                OutlinedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavigation(screenId: 0,)));
                  },
                  style:  OutlinedButton.styleFrom( side: BorderSide(width: 1.0, color: Colors.pinkAccent),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
                  ),
                  child: const Text("To do",style: TextStyle(color: Colors.pinkAccent),),
                ),
              ],),
              Divider(),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                Row(children: [Container(decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  gradient: LinearGradient(
                      colors: [
                        Colors.pink.shade600,
                        Colors.pinkAccent.shade200,
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                  height:60,width:60,child:Column(
                    children: [
                      Icon(Icons.star,color: Colors.orange.shade200,size: 35,),
                      Center(child: Text('+50',style: TextStyle(color: Colors.white),),)
                    ],
                  ),),
                  SizedBox(width: 10,), Text('Give us a good review '),],),
                OutlinedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavigation(screenId: 0,)));
                  },
                  style:  OutlinedButton.styleFrom( side: BorderSide(width: 1.0, color: Colors.pinkAccent),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
                  ),
                  child: const Text("To do",style: TextStyle(color: Colors.pinkAccent),),
                ),
              ],),Divider(),
              SizedBox(height: 60,)
            ],
          ),
        ),
      ),



    );
  }
}
