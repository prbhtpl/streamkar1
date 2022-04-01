import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:image/image.dart' as imageLib;
import 'package:http/http.dart' as http;
import 'package:photofilters/filters/filters.dart';
import 'package:photofilters/filters/preset_filters.dart';
import 'package:photofilters/widgets/photo_filter.dart';
import 'package:untitled/bottomNavigationBar/bottomNavigation.dart';

import '../../helper/helperFunctions.dart';

class EditProfilePic2 extends StatefulWidget {
  const EditProfilePic2(
      {Key? key, required this.imageFile, required this.source})
      : super(key: key);
  final ImageSource source;
  final File? imageFile;

  @override
  State<EditProfilePic2> createState() => _EditProfilePic2State(imageFile);
}

class _EditProfilePic2State extends State<EditProfilePic2> {
  _EditProfilePic2State(this.imageFile);

  String? fileName;
  List<Filter> filters = presetFiltersList;
  final picker = ImagePicker();
  File? imageFile;
  Future getImage(context, ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile != null) {
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

  int? id;
  String _name = '';
  getallPreferences() async {
    var userDetails = await HelperFunctions.getVStarUniqueIdkey();
    var name = await HelperFunctions.getuserNameSharedPreference();
    setState(() {
      id = userDetails;
      print(id.toString());

      _name = name;
      print(_name.toString());
    });
  }

  Future uploadProfileImage() async {
    EasyLoading.show(status: 'Uploading...');
    var uploadUrl =
        Uri.parse("https://vinsta.ggggg.in.net/api/userProfileImage");
    var requestMulti = http.MultipartRequest('POST', uploadUrl);
    requestMulti.fields['id'] = id.toString();
    if (imageFile != null) {
      requestMulti.files
          .add(await http.MultipartFile.fromPath('userphoto', imageFile!.path));
      var res = await requestMulti.send();

      if (res.statusCode == 200) {
        print(imageFile!.path);
        EasyLoading.showSuccess('Data is Uploaded');
        EasyLoading.dismiss();
        Navigator.pushReplacement(
            this.context,
            MaterialPageRoute(
                builder: (context) => BottomNavigation(screenId: 4)));
        print('Upload Data');
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong upload again');
      }
      print(requestMulti.fields);
      print(fileName);
      return res.reasonPhrase;
    } else {
      print('Image is not selected');
    }
  }

  @override
  void initState() {
    getallPreferences();
    setState(() {
      getImage(this.context, widget.source);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
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
                      child: CircularProgressIndicator(
                        color: Colors.redAccent,
                      ),
                    )
                  : Image.file(new File(imageFile!.path)),
            ),
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          /*   Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => BottomNavigation(screenId: 4,)));*/
          uploadProfileImage();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Save'),
        ),
      ),
    );
  }
}
