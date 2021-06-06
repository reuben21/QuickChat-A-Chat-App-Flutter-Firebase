import 'package:firebase_messaging/firebase_messaging.dart';

import '../../colors.dart';
import '../../screens/chat_profile.dart';
import '../../widget/chat/messages.dart';
import '../../widget/chat/new_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;

  ChatScreen(this.chatId);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back,color:kPrimaryColor),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        backgroundColor: kPrimaryColorAccent,
        leadingWidth: 50,
        title: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('chats')
                .doc(widget.chatId)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }
              final documents = snapshot.data;

              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (ctx) => ChatProfile(
                              documents['imageUrl'],
                              widget.chatId.toString(),
                              documents['chatName'],
                              documents['users'])));
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(
                        width: 1,
                        color: kPrimaryColorAccent,
                      )),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 19,
                        backgroundImage: NetworkImage(documents['imageUrl']),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        documents['chatName'],
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
      body: Container(
          child: Column(
        children: [
          Expanded(child: Messages(widget.chatId)),
          NewMessage(widget.chatId)
        ],
      )),
    );
  }
}
