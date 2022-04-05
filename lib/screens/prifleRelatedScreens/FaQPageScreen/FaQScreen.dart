import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
class FaQScreen extends StatefulWidget {
  const FaQScreen({Key? key}) : super(key: key);

  @override
  State<FaQScreen> createState() => _FaQScreenState();
}

class _FaQScreenState extends State<FaQScreen> {


bool loading=false;
List  getFAQquestion=[];
List  getFAQanswer=[];
  Future FaqQuestionGet() async {

    var api = Uri.parse("https://vinsta.ggggg.in.net/api/faQusGet");



    final response = await http.get(
      api,
      /* body: mapeddate,*/
    );
    var res = await json.decode(response.body);
    // print("UploadPosts2" + response.body);
    setState(() {
      getFAQquestion = res['response_getques'];
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
Future FaqAnswerGet() async {

  var api = Uri.parse("https://vinsta.ggggg.in.net/api/answerGet");



  final response = await http.get(
    api,
    /* body: mapeddate,*/
  );
  var res = await json.decode(response.body);
  // print("UploadPosts2" + response.body);
  setState(() {
    getFAQanswer = res['response_getAns'];
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
    FaqQuestionGet();
    FaqAnswerGet();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(foregroundColor: Colors.black,toolbarHeight: 40,backgroundColor: Colors.white70,elevation: 1.0,
        title: Text('FAQ'),
      ),
      body:loading!=false?Container(
        child: ListView.builder(shrinkWrap: true,itemCount:  getFAQquestion == null ? 0 : getFAQquestion.length,itemBuilder: (BuildContext,int index){
          return
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  Card(color: Colors.teal[50],shape:   RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                    child: ExpansionTile(
                      title: Text(
                        getFAQquestion[index]['question'],
                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                      ),
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            getFAQanswer[index]['answer'],
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        )
                      ],
                    ),
                  ),
                ],),
              ),
            );
        }),
      ):Center(child: CircularProgressIndicator()),
    );
  }
}
