import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {

  final Function(File pickedImage) imagePickFn;


  UserImagePicker(this.imagePickFn);

  @override
  _UserImagePickerState createState() {
    return _UserImagePickerState();
  }
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _image;
  final picker = ImagePicker();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        widget.imagePickFn(_image);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage:_image !=null ? FileImage(_image):null,
        ),
        TextButton.icon(
            onPressed:_pickImage,
            icon: Icon(Icons.image),
            label: const Text("Add Image")),
      ],
    );
  }
}