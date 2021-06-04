import 'package:chat_app_firebase/widget/chats/chats.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../colors.dart';

class ChatsScreen extends StatefulWidget {


  @override
  _ChatsScreenState createState() {
    return _ChatsScreenState();
  }
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kPrimaryColorAccent,
          title: Text(
            'QuickChat',
            style: Theme.of(context).textTheme.headline3,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  icon: Icon(Icons.more_vert),
                  iconEnabledColor: kPrimaryColor,
                  dropdownColor: kPrimaryColorAccent,
                  items: [
                    DropdownMenuItem(
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.add_comment_outlined),
                            SizedBox(
                              width: 8,
                            ),
                            Text('Add Chat')
                          ],
                        ),
                      ),
                      value: 'createChat',
                    ),
                    DropdownMenuItem(
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.exit_to_app),
                            SizedBox(
                              width: 8,
                            ),
                            Text('Logout')
                          ],
                        ),
                      ),
                      value: 'logout',
                    ),
                  ],
                  onChanged: (itemIdentifier) async {
                    if (itemIdentifier == 'logout') {
                      FirebaseAuth.instance.signOut();
                    } else {
                      final id = FirebaseFirestore.instance
                          .collection('chats').doc().id;
                      final user = await FirebaseAuth.instance.currentUser;
                      final userData = await FirebaseFirestore.instance
                          .collection('users')
                          .doc(user.uid.toString())
                          .get();
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(user.uid.toString())
                          .collection('chats')
                          .add({'chats': 'PersonalChat',"id":id});
                      FirebaseFirestore.instance
                          .collection('chats')
                          .doc(user.uid.toString())
                          .collection(id)
                          .add({
                        'text': 'I Created This Chat',
                        'createdAt': Timestamp.now(),
                        'userId': user.uid.toString(),
                        'username':userData['username']
                      });


                    }
                  },
                ),
              ),
            ),
          ]),
      body: Container(
          child: Column(
        children: [
          ChatsWidget()
        ],
      )),
    );
  }
}