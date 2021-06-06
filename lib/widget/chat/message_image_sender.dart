import 'dart:io';
import 'package:chat_app_firebase/widget/pickers/user_image_picker_gallery.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class MessageImageSender extends StatefulWidget {
  final String ChatId;

  MessageImageSender(this.ChatId);

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

  Future<void> _pickedImage(File pickedImage, String message) async {
    _imagePicked = pickedImage;
    final user = await FirebaseAuth.instance.currentUser;
    final ref = FirebaseStorage.instance
        .ref('chat_${widget.ChatId}')
        .child('${widget.ChatId}+${user.uid}+${DateTime.now().toIso8601String()}.jpg');

    await ref.putFile(pickedImage).whenComplete(() => null);

    final url = await ref.getDownloadURL();

    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid.toString())
        .get();
    FocusScope.of(context).unfocus();

    FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.ChatId)
        .collection(widget.ChatId)
        .add({
          'text': message,
          'imageUrl': url,
          'createdAt': Timestamp.now(),
          'userId': user.uid.toString(),
          'username': userData['username'],
          'id': 6
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Send An Image')),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[UserImagePickerGroup(_pickedImage)],
        ),
      ),
    );
  }
}
