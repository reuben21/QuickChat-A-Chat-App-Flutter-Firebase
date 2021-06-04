import 'package:chat_app_firebase/screens/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatsWidget extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid.toString())
            .collection('chats')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          final documents = snapshot.data.docs;
          print(documents);
          return new ListView.builder(
            scrollDirection: Axis.vertical,
            reverse: true,
            shrinkWrap: true,
            itemCount: documents.length,
            itemBuilder: (ctx, index) =>
                ListTile(title: Text(documents[index]['chats']),onTap:(){ Navigator.of(context).push(MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (ctx) => ChatScreen(documents[index]['chats'].toString(),documents[index]['id'].toString())
                ));}),
          );
        });
  }
}
