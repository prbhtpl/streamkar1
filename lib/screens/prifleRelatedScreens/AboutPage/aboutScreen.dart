

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  bool loading=false;
  List aboutUs=[];

  Future GetAboutUs() async {

    var api = Uri.parse("https://vinsta.ggggg.in.net/api/aboutGet");


    final response = await http.get(
      api,
     /* body: mapeddate,*/
    );
    var res = await json.decode(response.body);
    // print("UploadPosts2" + response.body);
    setState(() {
      aboutUs = res['response_about'];
      loading = true;
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
    GetAboutUs();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 1.0,backgroundColor: Colors.white70,title: Text('About Us'),toolbarHeight: 40,foregroundColor: Colors.black),
      body:loading!=false?Container(
        child: ListView.builder(shrinkWrap: true,itemCount:  aboutUs == null ? 0 : aboutUs.length,itemBuilder: (BuildContext,int index){
          return
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [   Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(aboutUs[index]['heading'],style: GoogleFonts.zenMaruGothic(fontSize: 18,color: Colors.pinkAccent,fontWeight: FontWeight.bold),),
                    ),Container(

                      child:  Text(aboutUs[index]['contentApp'],style: GoogleFonts.lobsterTwo(),),
                    ),],
                  ),
                ),
              ),
            );
        }),
      ):Center(child: CircularProgressIndicator()),




    );
  }
}
