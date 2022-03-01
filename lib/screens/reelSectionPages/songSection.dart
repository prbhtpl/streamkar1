import 'package:flutter/material.dart';
class Songscreen extends StatefulWidget {
  const Songscreen({Key? key}) : super(key: key);

  @override
  _SongscreenState createState() => _SongscreenState();
}

class _SongscreenState extends State<Songscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Songs Section'),),
    );
  }
}
