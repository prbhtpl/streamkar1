import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';

class addSongs extends StatefulWidget {
  const addSongs({Key? key}) : super(key: key);

  @override
  State<addSongs> createState() => _addSongsState();
}

class _addSongsState extends State<addSongs> {
  List item = [];
  List artist=[];
  AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
  AudioCache audioCache = AudioCache();
  String token =
      'BQDdI4X1uclEbF8sojAM1xaVbR86MG_pRO20HH9OCjYKK9L23EGXyFmcziieBDCoToHsirMy4PvgImzLCnoLzy742WA1Nw1aF3zY_vFoukfjDQKmG4ansQaRCTFEphhuFqBPno2T4fMZFMWyywqX_oirLOTAKJD3NKUvPmw-';
  Future AllSongs() async {
    EasyLoading.show(status: 'Loading...');

    var api = Uri.parse(
      "https://api.spotify.com/v1/albums/4aawyAB9vmqN3uQ7FjRGTy/tracks?market=ES&limit=10&offset=5",
    );

    Map mapeddate = {};

    final response = await http.get(api, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    var res = await json.decode(response.body);
    print("hererere" + response.body);
    if (response.statusCode == 200) {
      setState(() {
        item = res['items'];



        print('item' + item.toString());
      });
    }

    EasyLoading.dismiss();
  }
  play(String url) async {

    int result = await audioPlayer.play('song.mp3');
    if (result == 1) {
    print('pllay');
    }
  }

  @override
  void initState() {
    AllSongs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        /* dark theme settings */
      ),
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15.0, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          CupertinoIcons.back,
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 250,
                        child: TextField(
                          decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                // width: 0.0 produces a thin "hairline" border
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 0.0),
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
                              hintStyle:
                                  TextStyle(fontSize: 12, color: Colors.grey)),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {



                            },
                            child: Icon(
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
                        child: Center(child: Text('Saved')),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'For You',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('See More',
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(

                      child: ListView.builder(shrinkWrap: true,
                          itemCount:  item == null ? 0 : item.length,
                          itemBuilder: (BuildContext, int index) {

                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      child: Image.asset('assets/logo.jpeg'),
                                      decoration: BoxDecoration(
                                          color: Colors.black26,
                                          border:
                                              Border.all(color: Colors.white),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                    ),
                                    Column(
                                      children: [

                                        Text(item[index]['name'],style: TextStyle(fontSize: 12),),
                                        Text(
                                          item[index]['artists'][0]['name'],
                                          style:
                                              TextStyle(color: Colors.white54),
                                        ),
                                      ],
                                    ),
                                    IconButton(onPressed: (){
                                    /*  String url=item[index]['preview_url'];*/
                                      String url='https://thegrowingdeveloper.org/files/audios/quiet-time.mp3?b4869097e4';
                                      print('url.toString()'+url.toString());
                                      play(url);

                                      setState(() {

                                      });
                                    },icon:Icon(CupertinoIcons.play_arrow_solid))
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                )
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
