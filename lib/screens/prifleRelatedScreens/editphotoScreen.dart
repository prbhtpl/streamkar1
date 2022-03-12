import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:image/image.dart' as imageLib;
import 'package:photofilters/filters/filters.dart';
import 'package:photofilters/filters/preset_filters.dart';
import 'package:photofilters/widgets/photo_filter.dart';
import 'package:untitled/screens/prifleRelatedScreens/profileScreen.dart';
class EditPic extends StatefulWidget {
  const EditPic({Key? key,required this.imageFile,required this.source}) : super(key: key);
  final ImageSource source;
final File? imageFile;
  @override
  State<EditPic> createState() => _EditPicState(imageFile);
}

class _EditPicState extends State<EditPic> {
  String? fileName;
  List<Filter> filters = presetFiltersList;
  final picker = ImagePicker();
  File? imageFile;

  _EditPicState(this.imageFile);

  Future getImage(context,ImageSource source) async {
    final pickedFile = await picker.getImage(source:source);
    if(pickedFile!=null){
      imageFile = new File(pickedFile.path);
      fileName = basename(imageFile!.path);
      var image = imageLib.decodeImage(await imageFile!.readAsBytes());
      image = imageLib.copyResize(image!, width: 600);
      Map imagefile = await Navigator.push(
        this.context,
        MaterialPageRoute(
          builder: (context) => new PhotoFilterSelector(
            title: Text("Photo Filter Example"),
            image: image!,
            filters: presetFiltersList,
            filename: fileName!,
            loader: Center(child: CircularProgressIndicator()),
            fit: BoxFit.contain,
          ),
        ),
      );

      if (imagefile != null && imagefile.containsKey('image_filtered')) {
        setState(() {
          imageFile = imagefile['image_filtered'];
        });
        print(imageFile!.path);

      }
    }
  }

@override
  void initState() {
setState(() {
  getImage(this.context, widget.source);
});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: SafeArea(
        child: Container( height:MediaQuery.of(context).size.height,decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.lightBlueAccent.shade200,
            Colors.black12,
            Color(0xFF9D6EF7),
            Colors.lightBlueAccent.shade200,
            Color(0xFF9D6EF7),
            Color(0xFF9D6EF7),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
          child: Center(
            child: new Container(
              child: imageFile == null
                  ? Center(
                child: new Text('No image selected.'),
              )
                  : Image.file(new File(imageFile!.path)),
            ),
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));

        },

        child:Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Save'),
        ),
      ),
    );
  }

}
