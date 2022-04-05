import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:untitled/bottomNavigationBar/bottomNavigation.dart';
import 'package:untitled/helper/constants.dart';
import 'package:untitled/screens/prifleRelatedScreens/TopUpScreens/BuyBeansScreen.dart';
import 'package:http/http.dart' as http;

import '../../../helper/helperFunctions.dart';
import 'BeanRecordScreen.dart';

class TopUpScreen extends StatefulWidget {
  const TopUpScreen({Key? key}) : super(key: key);

  @override
  _TopUpScreenState createState() => _TopUpScreenState();
}

class _TopUpScreenState extends State<TopUpScreen> {
  int? response_totalBeans;
  TextEditingController VStarCode = TextEditingController();
  TextEditingController AmountOfBeans = TextEditingController();
  bool loading=false;
  Future SendBeansToFriends() async {

    var id1 = await HelperFunctions.getVStarUniqueIdkey();

    var api = Uri.parse("https://vinsta.ggggg.in.net/api/transferbeans");


    Map mapeddate = {
      "user_id": id1.toString(),
      "user_account":VStarCode.text.toString(),
      "number_beans":AmountOfBeans.text.toString()};

    final response = await http.post(
      api,
      body: mapeddate,
    );

    var res = await json.decode(response.body);
    print("hererere" + response.body);
    String msg=res['status_message'];
    setState(() {
      VStarCode.clear();
      AmountOfBeans.clear();

    });

    try {
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: msg);
        loading=true;
      }
    } catch (e) {
      print(e);
    }
  }
  Future GetTotalNo_ofBeans() async {

    var api = Uri.parse("https://vinsta.ggggg.in.net/api/totalbeans");
    var id1 = await HelperFunctions.getVStarUniqueIdkey();
    Map mapeddate = {"user_id": id1.toString()};

    final response = await http.post(
      api,
      body: mapeddate,
    );

    var res = await json.decode(response.body);
    print("hererere" + response.body);
    setState(() {
      response_totalBeans=res['response_totalBeans'];
    });

    try {
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Updated');
        loading=true;
      }
    } catch (e) {
      print(e);
    }
  }
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(

          content: Column(mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                // Specify some width
                  width: MediaQuery.of(context).size.width * .7,
                  child:TextFormField(controller: VStarCode,
                    decoration: InputDecoration(hintText:'Enter friends V Id..'),
                  )),
              Container(
                // Specify some width
                  width: MediaQuery.of(context).size.width * .7,
                  child:TextFormField(controller: AmountOfBeans,keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText:'Enter no of beans'),
                  )),
            ],
          ),
          actions: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Padding(
                padding: const EdgeInsets.only(left: 108.0),
                child: ElevatedButton(onPressed: (){Navigator.pop(context);}, child: Text('Cancel',style: TextStyle(color: Colors.black),),style: ElevatedButton.styleFrom(primary: Colors.white,elevation: 0),),
              ),
              ElevatedButton(onPressed: (){if(VStarCode.text.isEmpty || AmountOfBeans.text.isEmpty){
                Fluttertoast.showToast(msg: 'Fill all fields');
              }else if(int.parse('${AmountOfBeans.text}')>response_totalBeans!){

                Fluttertoast.showToast(msg: 'Insufficient beans',textColor: Colors.red,backgroundColor: Colors.white);
              }else {
                SendBeansToFriends(); Navigator.of(context)
                    .push(new MaterialPageRoute(builder: (context) => TopUpScreen()));
              }

              }, child: Text('Send',style: TextStyle(color: Colors.pink.shade300),),style: ElevatedButton.styleFrom(primary: Colors.white,elevation: 0),),
              ],
            )
          ],
        );
      },
    );
  }
  @override
  void initState() {
    GetTotalNo_ofBeans();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: ()async{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavigation(screenId: 4,)));
      return true;
    },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purpleAccent,
          bottomOpacity: 0.0,
          elevation: 0.0,

          actions: [
            InkWell(onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SendBeanRecord()));
            },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                    child: Text(
                      'Record',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    )),
              ),
            )
          ],
          title: Text('Top-up'),
          toolbarHeight: 50,
        ),
        body: loading?SlidingUpPanel( renderPanelSheet: true,
          maxHeight: MediaQuery.of(context).size.height,
          minHeight: MediaQuery.of(context).size.height * 0.65,
        panel: Column(
          children: [
            InkWell(onTap: (){_showMyDialog();},
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10,top: 5),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                  Row(children: [
                    Text('Account Id: ',style: TextStyle(color: Colors.grey)),
                    Text(Constants.myname,
                    )],),
                  Row(children: [
                    Text('Gifted To Friend'),
                    IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.right_chevron))],),
                ],),
              ),
            ),
            Divider(thickness: 3,color: Colors.grey.shade300,),
            InkWell(onTap: (){
Navigator.push(context, MaterialPageRoute(builder: (context)=>BuyBeans()));
            },
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10,top: 5),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                  Row(children: [
                 Image.asset('assets/googlePayIcon.jpg',scale: 12,),
                    SizedBox(width: 5,),
                    Text('Top Up',
                    )],),
                  Row(children: [
                    Container(
                      width: 90,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.pinkAccent.shade100,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.yellow, width: 2),
                      ),
                      child: Row(children: [
                        Image.asset('assets/nuts.png',scale: 20,),
                        SizedBox(width: 2,),
                        Text('Bonus',style: TextStyle(fontSize: 12,color: Colors.white),
                        )
                      ],),
                    ),
                    IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.right_chevron))],),
                ],),
              ),
            ),
        Divider(color: Colors.grey.shade300,),
            Padding(
              padding: const EdgeInsets.only(left: 8.0,top: 8),
              child: Align(alignment: Alignment.centerLeft,child: Text('Note:')),
            ),
            Expanded(

              child: ListView.builder(itemCount: 5,itemBuilder: (BuildContext,int Index){
                return Padding(
                  padding: const EdgeInsets.only(left: 8.0,top: 5),
                  child: Text("$Index . To solve Top-Up,issue,please go to feedback Page."),
                );
              }),
            ),
          ],
        ),
        body:  Column(
            children: [
            Container(
            color: Colors.purpleAccent,
            width: double.infinity,
            height: 700,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/nuts.png',
                    scale: 5,
                  ),
                  Text(
                    'Available Beans: ${response_totalBeans.toString()}',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  )
                ],
              ),
            ))]),):Container(child: Center(child: CircularProgressIndicator(),),),
      ),
    );
  }
}
