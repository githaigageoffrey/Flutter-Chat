// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  // File _image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _pickImage() async {
    // final pickedImage = await picker.getImage(source: ImageSource.gallery);
    // final pickedImageFile = File(pickedImage.path); // requi
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: <Widget>[
      CircleAvatar(radius: 40),
      TextButton.icon(
          // FlatButton.icon(
          onPressed: _pickImage,
          icon: Icon(
            Icons.image,
            color: Theme.of(context).primaryColor,
          ),
          label: Text(
            "Add Image",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          )),
    ]));
  }
}
