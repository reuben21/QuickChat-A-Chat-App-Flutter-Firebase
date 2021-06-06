import 'dart:io';
import 'package:chat_app_firebase/widget/pickers/user_image_picker_gallery.dart';
import 'package:flutter/material.dart';

class MessageImageSender extends StatefulWidget {
  MessageImageSender({Key key}) : super(key: key);

  @override
  _MessageImageSenderState createState() {
    return _MessageImageSenderState();
  }
}

class _MessageImageSenderState extends State<MessageImageSender> {
  File _imagePicked;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  void _pickedImage(File pickedImage){

    _imagePicked = pickedImage;

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Send An Image')),
      body: Column(
        children: <Widget>[
          UserImagePickerGroup(_pickedImage)
        ],
      ),
    );
  }
}