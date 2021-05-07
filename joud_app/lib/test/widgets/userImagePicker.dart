import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {

  final void Function (File pickedImage) imgPickFunc;
  UserImagePicker(this.imgPickFunc);

  @override
  State<StatefulWidget> createState() {
    return UserImagePickerState();
  }
}

class UserImagePickerState extends State <UserImagePicker> {
  File pickedImage;
  final ImagePicker picker =  ImagePicker();


  void addImage(ImageSource src) async {
    final imageFile = await picker.getImage(source: src, imageQuality: 60,  maxWidth: 150);

    if (imageFile != null) {
      setState(() {
        pickedImage = File(imageFile.path);
      });
      widget.imgPickFunc(pickedImage);
    }
    else {
      print ('Select an Image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget> [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.blueGrey,
          backgroundImage: pickedImage != null ? FileImage(pickedImage) : null ,
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // ignore: deprecated_member_use
            FlatButton.icon(
              textColor: Theme.of(context).primaryColor,
              onPressed: () => addImage(ImageSource.camera),
              icon: Icon(Icons.photo_camera_outlined),
              label: Text ('Camera', textAlign: TextAlign.center,),
            ),
            // ignore: deprecated_member_use
            FlatButton.icon(
              textColor: Theme.of(context).primaryColor,
              onPressed: () => addImage(ImageSource.gallery),
              icon: Icon(Icons.image_outlined),
              label: Text ('Gallery', textAlign: TextAlign.center,),
            ),
          ],
        ),
      ],
    );
  }
}
