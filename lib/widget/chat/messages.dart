import 'package:bubble/bubble.dart';
import 'package:chat_app_firebase/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('createdAt',descending: true)
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
                    child:Bubble(
                      margin: BubbleEdges.only(top: 5,right: 5),
                      alignment: Alignment.topRight,
                      nipWidth: 30,
                      nipHeight: 10,

                      radius: Radius.circular(20.0),
                      color: kPrimaryColor,
                      child: Text(documents[index]['text'], textAlign: TextAlign.right,style: Theme.of(context).textTheme.headline6,),
                    ),
                  ));
        });
  }
}
