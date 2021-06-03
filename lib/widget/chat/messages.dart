import 'package:bubble/bubble.dart';
import 'package:chat_app_firebase/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'message_bubble.dart';

class Messages extends StatelessWidget {
  final user =FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy(
          'createdAt',
          descending: true,
        )
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          final documents = snapshot.data.docs;
          print(user.uid.toString());
          return new ListView.builder(

              reverse: true,
              itemCount: documents.length,
              itemBuilder: (ctx, index) => MessageBubble( documents[index]['text'],documents[index]['username'], user.uid.toString() == documents[index]['userId'].toString())
                  );
        });
  }
}
