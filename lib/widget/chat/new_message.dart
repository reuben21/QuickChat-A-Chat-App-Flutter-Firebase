import 'package:chat_app_firebase/widget/chat/message_image_sender.dart';
import 'package:chat_app_firebase/widget/pickers/user_image_picker_gallery.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

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
  static const _actionTitles = ['Create Post', 'Upload Photo', 'Upload Video'];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _showAction(BuildContext context, int index) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(_actionTitles[index]),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('CLOSE'),
            ),
          ],
        );
      },
    );
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
          'text': _controller.text,
          'createdAt': Timestamp.now(),
          'userId': user.uid.toString(),
          'username': userData['username'],
          'id': 5
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
          SpeedDial(
            /// both default to 16
            // animatedIcon: AnimatedIcons.menu_close,
            // animatedIconTheme: IconThemeData(size: 22.0),
            /// This is ignored if animatedIcon is non null
            icon: Icons.attach_file_outlined,
            activeIcon: Icons.close_outlined,
            buttonSize: 50.0,
            visible: true,
            /// If true user is forced to close dial manually
            /// by tapping main button and overlay is not rendered.
            closeManually: false,
            /// If true overlay will render no matter what.
            renderOverlay: false,
            curve: Curves.bounceIn,
            overlayColor: Colors.black,
            overlayOpacity: 0.5,
            onOpen: () => print('OPENING DIAL'),
            onClose: () => print('DIAL CLOSED'),
            tooltip: 'Speed Dial',
            heroTag: 'speed-dial-hero-tag',
            backgroundColor: kPrimaryColorAccent,
            foregroundColor: kPrimaryColor,
            elevation: 0.0,
            shape: CircleBorder(),
            // orientation: SpeedDialOrientation.Up,
            // childMarginBottom: 2,
            // childMarginTop: 2,
            children: [
              SpeedDialChild(
                child: Icon(Icons.photo_camera,color: kPrimaryColorAccent,size: 30,),
                backgroundColor:kPrimaryColor ,
                label: 'Camera',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () {

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx)=>MessageImageSender(),
                    )
                  );

                },

                onLongPress: () => print('FIRST CHILD LONG PRESS'),
              ),
              SpeedDialChild(
                child: Icon(Icons.videocam_outlined,color: kPrimaryColorAccent,size: 30,),
                backgroundColor:kPrimaryColor ,
                label: 'Third',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () => print('THIRD CHILD'),
                onLongPress: () => print('THIRD CHILD LONG PRESS'),
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
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
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                hintText: "Send A Message",
                labelStyle: TextStyle(color: kPrimaryColor),
              ),
              onSaved: (value) {
                _enteredMessaged = value;
              },
            ),
          ),
          CircleAvatar(
              backgroundColor: kPrimaryColorAccent,
              child: IconButton(
                  onPressed: _sendMessage,
                  icon: Icon(
                    Icons.send,
                    color: kPrimaryColor,
                  ))),
        ],
      ),
    );
  }
}
