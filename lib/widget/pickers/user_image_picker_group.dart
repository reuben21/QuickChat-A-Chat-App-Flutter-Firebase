import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePickerGroup extends StatefulWidget {
  final Function(File pickedImage) imagePickFn;

  UserImagePickerGroup(this.imagePickFn);

  @override
  _UserImagePickerGroupState createState() {
    return _UserImagePickerGroupState();
  }
}

class _UserImagePickerGroupState extends State<UserImagePickerGroup> {
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

  void _pickImageFromCamera() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.camera, imageQuality: 80, maxWidth: 400);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        widget.imagePickFn(_image);
      } else {
        print('No image selected.');
      }
    });
  }

  void _pickImageFromGallery() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery, imageQuality: 80, maxWidth: 400);

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
    return Row(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: _image != null ? FileImage(_image) : null,
        ),
        TextButton.icon(
            onPressed: _pickImageFromCamera,
            icon: Icon(Icons.camera_outlined),
            label: const Text("Take Image")),
        TextButton.icon(
            onPressed: _pickImageFromGallery,
            icon: Icon(Icons.collections_outlined),
            label: const Text("Select Image")),
      ],
    );
  }
}
