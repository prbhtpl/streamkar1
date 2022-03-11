
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class addSongs extends StatefulWidget {
  const addSongs({Key? key}) : super(key: key);

  @override
  State<addSongs> createState() => _addSongsState();
}

class _addSongsState extends State<addSongs> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData(
      brightness: Brightness.dark,
      /* dark theme settings */
    ),
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
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
                              hintText: 'Search Music ',
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
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black26,
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:Center(child: Text('Saved')),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
                    Text('For You',style: TextStyle(fontWeight: FontWeight.bold),),
                    Text('See More',style: TextStyle(fontWeight: FontWeight.bold))
                  ],),
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(height: 500,
                      child: ListView.builder(itemCount: 50,itemBuilder: (BuildContext,int index){

return Column(
  children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

      Container(height: 50,width:50,child:Image.asset('assets/logo.jpeg') ,decoration: BoxDecoration(

          color: Colors.black26,

          border: Border.all(color: Colors.white),

          borderRadius: BorderRadius.all(Radius.circular(10))),),
          Column(
            children: [
              Text('Tick Tok Boon'),
              Text('Sage the GeminiS ',style: TextStyle(color: Colors.white54),),
            ],
          ),
          Icon(CupertinoIcons.play_arrow_solid)

    ],),
    SizedBox(height: 15,)
  ],
);

                      }),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        
      ),
    );
  }
}
