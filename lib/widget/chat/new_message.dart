import 'package:chat_app_firebase/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  final String ChatId;

  NewMessage(this.ChatId);

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
          'text':  _controller.text,
          'createdAt': Timestamp.now(),
          'userId': user.uid.toString(),
          'username': userData['username']
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
            child: TextFormField(
              controller: _controller,
              key: ValueKey('username'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter characters';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Send a Message',
                labelStyle: TextStyle(color: kPrimaryColor),
              ),
              onSaved: (value) {
                _enteredMessaged = value;
              },
            ),
          ),
          IconButton(
              onPressed: _sendMessage,
              icon: Icon(
                Icons.send,
                color: kPrimaryColor,
              ))
        ],
      ),
    );
  }
}
