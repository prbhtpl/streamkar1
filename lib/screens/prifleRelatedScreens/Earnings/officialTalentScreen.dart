

import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'applytoBeandOfficialTalent.dart';
class OfficialTalent extends StatefulWidget {
  const OfficialTalent({Key? key}) : super(key: key);

  @override
  State<OfficialTalent> createState() => _OfficialTalentState();
}

class _OfficialTalentState extends State<OfficialTalent> {

List getInstruction=[];
bool  loading = false;
  Future Getinstructions() async {

    var api = Uri.parse("https://vinsta.ggggg.in.net/api/TalentInstructionlist");



    final response = await http.get(
      api,
      /* body: mapeddate,*/
    );
    var res = await json.decode(response.body);
    print("UploadPosts2" + response.body);
    setState(() {
      getInstruction = res['response_beanlist'];

    });

    try {
      if (response.statusCode == 200) {
        loading=true;
      }else{
        Fluttertoast.showToast(msg: 'No Information Found');
      }
    } catch (e) {
      print(e);
    }
  }
  @override
  void initState() {
    Getinstructions();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 45,leading: IconButton(onPressed: (){Navigator.pop(context);},icon: Icon(CupertinoIcons.left_chevron,color: Colors.black,),),elevation:0.5,title: Text('Official Talent Instruction',style: TextStyle(color: Colors.black),),backgroundColor: Colors.white,),
    body: loading!=false?Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(getInstruction[0]['heading'].toString(),style: GoogleFonts.lato(color: Colors.red,fontSize: 18),),
            ),
            Text(getInstruction[0]['talentcontent'].toString(),style: GoogleFonts.lato(),),
          ],),
        ),

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
            InkWell(onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ApplyToBeAnOfficialTalent()));
            },child: Align(alignment: Alignment.center,child:Text('I have an agency ID',),)),
          ],),
        ),
      ],
    ):Container(child: Center(child: CircularProgressIndicator(),),),);
  }
}
