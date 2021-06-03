import 'package:bubble/bubble.dart';
import 'package:chat_app_firebase/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  final user =FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          final documents = snapshot.data!.docs;

          return new ListView.builder(

              reverse: true,
              itemCount: documents.length,
              itemBuilder: (ctx, index) => Container(
                key: ValueKey(documents[index].id),
                    child:user!.uid.toString() == documents[index]['userId']? Bubble(
                      margin: BubbleEdges.only(top: 5, right: 5),
                      alignment: Alignment.topRight,
                      nipWidth: 30,
                      nipHeight: 10,
                      radius: Radius.circular(10.0),
                      color: kPrimaryColor,
                      child: Text(
                        documents[index]['text'],
                        textAlign: TextAlign.right,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ):  Bubble(
                      margin: BubbleEdges.only(top: 5, left: 5),
                      alignment:Alignment.topLeft,
                      nipWidth: 30,
                      nipHeight: 10,
                      radius: Radius.circular(10.0),
                      color: receiverMessageColor,
                      child: Text(
                        documents[index]['text'],
                        textAlign: TextAlign.right,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                  ));
        });
  }
}
