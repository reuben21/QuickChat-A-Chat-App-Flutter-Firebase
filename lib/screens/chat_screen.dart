import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {


  @override
  void initState() {
    // TODO: implement initState
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('chat').snapshots(),
        builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Text('Something went wrong');
      }

      if (snapshot.connectionState == ConnectionState.waiting) {
        return Text("Loading");
      }
      final documents = snapshot.data!.docs;
      return new ListView.builder(
        itemCount: documents.length,
        itemBuilder:(ctx,index)=> Container(
            child: new Text(documents[index]['text']),

          )
        );}
      ),


    floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance.collection('chat').add({'text':"FloatingActionButton"}).then((value) => print("User Added"))
              .catchError((error) => print("Failed to add user: $error"));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
