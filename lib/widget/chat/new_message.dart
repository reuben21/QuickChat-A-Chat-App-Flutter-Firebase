import 'package:chat_app_firebase/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  void _sendMessage(){
    FocusScope.of(context).unfocus();
    FirebaseFirestore.instance
        .collection('chat')
        .add({
        'text':_enteredMessaged,
      'createdAt':Timestamp.now(),
      'userId':User
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
              controller:_controller,
              onChanged: (value){
                _enteredMessaged = value;
              },
                decoration: InputDecoration(
              labelText: 'Send a Message',
              labelStyle: TextStyle(color: kPrimaryColor),
            )),
          ),
          IconButton(onPressed: _enteredMessaged.trim().isEmpty ? null : _sendMessage
          , icon: Icon(Icons.send,color: kPrimaryColor,))
        ],
      ),
    );
  }
}
