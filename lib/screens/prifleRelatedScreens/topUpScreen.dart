import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class TopUpScreen extends StatefulWidget {
  const TopUpScreen({Key? key}) : super(key: key);

  @override
  _TopUpScreenState createState() => _TopUpScreenState();
}

class _TopUpScreenState extends State<TopUpScreen> {
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(

          content: Container(
            // Specify some width
              width: MediaQuery.of(context).size.width * .7,
              child:TextField(keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText:'Account Id..'),
              )),
          actions: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Padding(
                padding: const EdgeInsets.only(left: 108.0),
                child: ElevatedButton(onPressed: (){Navigator.pop(context);}, child: Text('Cancel',style: TextStyle(color: Colors.black),),style: ElevatedButton.styleFrom(primary: Colors.white,elevation: 0),),
              ),
              ElevatedButton(onPressed: (){}, child: Text('Confirm',style: TextStyle(color: Colors.pink.shade300),),style: ElevatedButton.styleFrom(primary: Colors.white,elevation: 0),),
              ],
            )
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(CupertinoIcons.left_chevron)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
                child: InkWell(
              child: Text(
                'Record',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              onTap: () {},
            )),
          )
        ],
        title: Text('Top-up'),
        toolbarHeight: 50,
      ),
      body: SlidingUpPanel( renderPanelSheet: true,
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
                  Text('Pal Prabhat',
                  )],),
                Row(children: [
                  Text('Gifted To Friend'),
                  IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.right_chevron))],),
              ],),
            ),
          ),
          Divider(thickness: 3,color: Colors.grey.shade300,),
          InkWell(onTap: (){},
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 10,top: 5),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                Row(children: [
               Image.asset('assets/googlePayIcon.jpg',scale: 12,),
                  SizedBox(width: 5,),
                  Text('Google',
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
                  'Available Beans: 0',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                )
              ],
            ),
          ))]),),
    );
  }
}
