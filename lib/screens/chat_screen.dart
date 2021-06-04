import 'package:chat_app_firebase/colors.dart';
import 'package:chat_app_firebase/widget/chat/messages.dart';
import 'package:chat_app_firebase/widget/chat/new_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String chatName;
  final String chatId;

  ChatScreen(this.chatName, this.chatId);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        backgroundColor: kPrimaryColorAccent,
        leadingWidth: 50,
        title:FutureBuilder(
            future:
            FirebaseFirestore.instance.collection('chats').doc(widget.chatId).get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }
              final documents = snapshot.data;
              return InkWell(

                onTap: (){
                  print("Hello");
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
          ],),
                ),
              );
            }),

        actions: [
          // IconButton(onPressed: (){}, icon: Icon(Icons.videocam),color: kPrimaryColor,),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.call),
            color: kPrimaryColor,
          )
        ],
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
