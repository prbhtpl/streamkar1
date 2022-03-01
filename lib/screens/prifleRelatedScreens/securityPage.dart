import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class SecurityScreen extends StatefulWidget {
  const SecurityScreen({Key? key}) : super(key: key);

  @override
  _SecurityScreenState createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              CupertinoIcons.left_chevron,
              color: Colors.black,
            )),
        actions: [],
        title: Text(
          'Security',
          style: TextStyle(color: Colors.black),
        ),
        toolbarHeight: 50,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('linked your social media accounts',style: TextStyle(color: Colors.grey),),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0,right: 8.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Row(children: [
              FaIcon(FontAwesomeIcons.whatsapp,color: Colors.greenAccent,),
              SizedBox(width: 10,),
              Text('Whats App')
            ],),
              ButtonTheme(
                minWidth: 50.0,
                height: 25,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.pinkAccent)),
                child: RaisedButton(
                  elevation: 5.0,
                  hoverColor: Colors.green,
                  color: Colors.pinkAccent,
                  child: Row(
                    children: [

                      Text(
                        "Link",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0,right: 8.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Row(children: [
              FaIcon(FontAwesomeIcons.twitter,color: Colors.blue,),
              SizedBox(width: 10,),
              Text('Twitter')
            ],),
              ButtonTheme(
                minWidth: 50.0,
                height: 25,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.pinkAccent)),
                child: RaisedButton(
                  elevation: 5.0,
                  hoverColor: Colors.green,
                  color: Colors.pinkAccent,
                  child: Row(
                    children: [

                      Text(
                        "Link",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0,right: 8.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Row(children: [
              FaIcon(FontAwesomeIcons.googlePlus,color: Colors.red,),
              SizedBox(width: 10,),
              Text('Google')
            ],),
              ButtonTheme(
                minWidth: 50.0,
                height: 25,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.pinkAccent)),
                child: RaisedButton(
                  elevation: 5.0,
                  hoverColor: Colors.green,
                  color: Colors.pinkAccent,
                  child: Row(
                    children: [

                      Text(
                        "Link",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0,right: 8.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Row(children: [
              FaIcon(FontAwesomeIcons.facebook,color: Colors.blue,),
              SizedBox(width: 10,),
              Text('Facebook')
            ],),
              ButtonTheme(
                minWidth: 50.0,
                height: 25,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.pinkAccent)),
                child: RaisedButton(
                  elevation: 5.0,
                  hoverColor: Colors.green,
                  color: Colors.pinkAccent,
                  child: Row(
                    children: [

                      Text(
                        "Link",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0,right: 8.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Row(children: [
              FaIcon(FontAwesomeIcons.mobile,color: Colors.blueGrey,),
              SizedBox(width: 10,),
              Text('Phone')
            ],),
              ButtonTheme(
                minWidth: 50.0,
                height: 25,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.pinkAccent)),
                child: RaisedButton(
                  elevation: 5.0,
                  hoverColor: Colors.green,
                  color: Colors.pinkAccent,
                  child: Row(
                    children: [

                      Text(
                        "Link",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ],),
    );
  }
}
