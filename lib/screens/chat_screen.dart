import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {



  CollectionReference chat = FirebaseFirestore.instance.collection('chat');


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
    // TODO: implement build
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
        future: chat.doc('9ieKCJJ8OqQouvgKF5Xz').get(),
        builder:
            (BuildContext context, AsyncSnapshot snapshot) {

          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data!.data();

            print(data.toString());
            return  ListView.builder(
              itemBuilder: (ctx, index) => Container(
                padding: EdgeInsets.all(8),
                child: Text('${data['text']}'),
              ),
              itemCount: 10,
            );
          }

          return Text("loading");
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {

      },
  child: Icon(Icons.add),
      ),
    );
  }
}

