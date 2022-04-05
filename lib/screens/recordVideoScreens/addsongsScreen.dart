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
  AudioPlayer audioPlayer = AudioPlayer();

  AudioPlayerState audioPlayerState = AudioPlayerState.PAUSED;
  String url = 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-13.mp3';

  /// Optional
  int timeProgress = 0;
  int audioDuration = 0;
  String token =
      'BQDDboyhtL5SBHuIYDd9eLvoLqiEBy8AzvwyNbRHTuRLnBdXaLop77bKFL5GbmO-zN4G7h6EgA7nxv_bxYyHuZTZZ2wGtDaAoMtZg6j7D_BGBlub2Gq6nsetUCUW40hTG_s7Sn6_uHpPPEEyUWQpMykgimDp4zS-sx-GPGuf';
  Future AllSongs() async {
    EasyLoading.show(status: 'Loading...');

    var api = Uri.parse(
      "https://api.spotify.com/v1/tracks?market=ES&ids=7ouMYWpwJ422jRcDASZB7P%2C4VqPOruhp5EdPBeR92t6lQ%2C2takcwOaAZWiXQijPHIx7B",
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
        item = res['tracks'];



        print('item' + item.toString());
      });
    }

    EasyLoading.dismiss();
  }

  playMusic(String Url1) async {
    // Add the parameter "isLocal: true" if you want to access a local file
    await audioPlayer.play(Url1);
  }
  pauseMusic() async {
    await audioPlayer.pause();
  }

  @override
  void initState() {
    audioPlayer.onPlayerStateChanged.listen((AudioPlayerState state) {
      setState(() {
        audioPlayerState = state;
      });
    });
    audioPlayer.setUrl(
        url); // Triggers the onDurationChanged listener and sets the max duration string
    audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        audioDuration = duration.inSeconds;
      });
    });
    audioPlayer.onAudioPositionChanged.listen((Duration position) async {
      setState(() {
        timeProgress = position.inSeconds;
      });
    });

     AllSongs();
    super.initState();
  }
  @override
  void dispose() {
    audioPlayer.release();
    audioPlayer.dispose();

    super.dispose();
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
                          style: TextStyle(fontWeight: FontWeight.bold)),
                  /*    IconButton(
                          iconSize: 50,
                          onPressed: () {
                            audioPlayerState == AudioPlayerState.PLAYING
                                ? pauseMusic()
                                : playMusic(url);
                            setState(() {});
                          },
                          icon: Icon(audioPlayerState == AudioPlayerState.PLAYING
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded)),*/
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
                                      child: Image.network(item[index]['album']['images'][index]['url'].toString()),
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
                                    IconButton(
                                        iconSize: 50,
                                        onPressed: () {

                                          setState(() {
                                            audioPlayerState == AudioPlayerState.PLAYING
                                                ? pauseMusic()
                                                : playMusic(item[index]['preview_url'].toString());
                                          });
                                        },
                                        // ignore: unrelated_type_equality_checks
                                        icon: Icon(audioPlayerState == AudioPlayerState.PLAYING.index
                                            ? Icons.pause_rounded
                                            : Icons.play_arrow_rounded))
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),

                              ],
                            );
                          }),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
