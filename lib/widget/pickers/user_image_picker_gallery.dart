import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../colors.dart';

class UserImagePickerGroup extends StatefulWidget {
  final Function(File pickedImage,String message) imagePickFn;

  UserImagePickerGroup(this.imagePickFn);

  @override
  _UserImagePickerGroupState createState() {
    return _UserImagePickerGroupState();
  }
}

class _UserImagePickerGroupState extends State<UserImagePickerGroup> {
  File _image;
  final picker = ImagePicker();
  final _controller = new TextEditingController();
  var _enteredMessaged = '';

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
        widget.imagePickFn(_image,_controller.text);
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
        widget.imagePickFn(_image,_controller.text);
      } else {
        print('No image selected.');
      }
    });
  }

  void _sendMessage() async {
    print(_image.path.toString());
    print(_controller.text);

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 400,
          child: _image != null
              ? Image.file(_image)
              : Center(
                  child: Text(
                    "Take or Select And Image",
                    textAlign: TextAlign.center,
                  ),
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
                onPressed: _pickImageFromCamera,
                icon: Icon(Icons.camera_outlined),
                label: const Text("Take Image")),
            TextButton.icon(
                onPressed: _pickImageFromGallery,
                icon: Icon(Icons.collections_outlined),
                label: const Text("Select Image")),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: 'Enter A Message'),
          ),
        ),

        TextButton.icon(
              label: Text('Send Message'),
                onPressed: _sendMessage,
                icon: Icon(
                  Icons.send,
                  color: kPrimaryColor,
                ))
      ],
    );
  }
}
