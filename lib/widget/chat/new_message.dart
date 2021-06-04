import 'package:chat_app_firebase/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() {
    return _NewMessageState();
  }
}

class _NewMessageState extends State<NewMessage> {
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

  void _sendMessage() async {
    final user = await FirebaseAuth.instance.currentUser;
    final id = FirebaseFirestore.instance
        .collection('chats').doc().id;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid.toString())
        .get();
    FocusScope.of(context).unfocus();
    // FirebaseFirestore.instance
    //     .collection('chats').doc(user.uid.toString()).set({
    //   'createdAt': Timestamp.now(),
    //   'users':FieldValue.arrayUnion([user.uid.toString()]),
    // }).then((value) => print("Chat Created"))
    //     .catchError((error) => print("Failed to add user: $error"));
    FirebaseFirestore.instance
        .collection('chats').doc('').collection('messages').add({
          'text': _enteredMessaged,
          'createdAt': Timestamp.now(),
          'userId': user.uid.toString(),
          'username':userData['username']
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
                controller: _controller,
                onChanged: (value) {
                  _enteredMessaged = value;
                },
                decoration: InputDecoration(
                  labelText: 'Send a Message',
                  labelStyle: TextStyle(color: kPrimaryColor),
                )),
          ),
          IconButton(
              onPressed: _enteredMessaged.trim().isEmpty ? null : _sendMessage,
              icon: Icon(
                Icons.send,
                color: kPrimaryColor,
              ))
        ],
      ),
    );
  }
}
