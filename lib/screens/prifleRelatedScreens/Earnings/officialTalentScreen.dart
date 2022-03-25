

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class OfficialTalent extends StatefulWidget {
  const OfficialTalent({Key? key}) : super(key: key);

  @override
  State<OfficialTalent> createState() => _OfficialTalentState();
}

class _OfficialTalentState extends State<OfficialTalent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 45,leading: IconButton(onPressed: (){Navigator.pop(context);},icon: Icon(CupertinoIcons.left_chevron,color: Colors.black,),),elevation:0.5,title: Text('Official Talent Instruction',style: TextStyle(color: Colors.black),),backgroundColor: Colors.white,),
    body: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.end,crossAxisAlignment: CrossAxisAlignment.stretch,children: [
            Divider(thickness: 2),
            Align(alignment: Alignment.center,child: Text('Current Gem Balance: 0 gems',style: TextStyle(color: Colors.grey))),
          Align(alignment: Alignment.center,child:Text('Gems Required to Apply: 2000000 gems',style: TextStyle(color: Colors.grey),),),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: ElevatedButton(onPressed: (){}, child: Text('Cannot Apply'),style: ElevatedButton.styleFrom(primary: Colors.pinkAccent),),
            ),
            InkWell(onTap: (){},child: Align(alignment: Alignment.center,child:Text('I have an agency ID',style: TextStyle(color: Colors.grey),),)),
          ],),
        )
      ],
    ),);
  }
}
