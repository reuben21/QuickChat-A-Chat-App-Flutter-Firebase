import 'package:chat_app_firebase/screens/profile.dart';
import 'package:chat_app_firebase/widget/loading/loading_widget.dart';

import '../../widget/chat/add_chat.dart';
import '../../widget/chat/create_chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors.dart';
import 'chat_screen.dart';

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

  final user = FirebaseAuth.instance.currentUser;

  Future<void> _addNewTransaction(String chatName) async {
    print(chatName);
    final id = FirebaseFirestore.instance.collection('chats').doc().id;
    //
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid.toString())
        .get();
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid.toString())
        .collection('chats')
        .add({"id": id});
    FirebaseFirestore.instance.collection('chats').doc(id).collection(id).add({
      'text': 'I Created This Chat',
      'createdAt': Timestamp.now(),
      'userId': user.uid.toString(),
      'username': userData['username'],
      'id': 1
    });
    FirebaseFirestore.instance.collection('chats').doc(id).set({
      'chatName': chatName,
      'imageUrl':
          'https://dogtime.com/assets/uploads/2011/03/puppy-development.jpg',
      'users': FieldValue.arrayUnion([user.uid.toString()])
    });
  }

  Future<void> _addChat(String id) async {

    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid.toString())
        .get();
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid.toString())
        .collection('chats')
        .add({"id": id});

    FirebaseFirestore.instance.collection('chats').doc(id).update({
      'users': FieldValue.arrayUnion([user.uid.toString()])
    });
    FirebaseFirestore.instance.collection('chats').doc(id).collection(id).add({
      'text': 'Entered This Chat',
      'createdAt': Timestamp.now(),
      'userId': user.uid.toString(),
      'username': userData['username'],
      'id': 10
    });
  }

  void _startAddChat(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return GestureDetector(
            onTap: () {},
            child: AddChat(_addChat),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          leading: LoadingWidget(20, 20),
          backgroundColor: kPrimaryColorAccent,
          title: Text(
            'QuickChat',
            style: Theme.of(context).textTheme.headline1,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  icon: Icon(Icons.more_horiz_outlined),
                  iconEnabledColor: kPrimaryColor,
                  dropdownColor: kPrimaryColorAccent,
                  items: [
                    DropdownMenuItem(
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.add_comment_outlined,
                              color: kPrimaryColor,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text('Create Chat',
                                style: Theme.of(context).textTheme.headline2)
                          ],
                        ),
                      ),
                      value: 'createChat',
                    ),
                    DropdownMenuItem(
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.three_p_outlined,
                              color: kPrimaryColor,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text('Enter Chat',
                                style: Theme.of(context).textTheme.headline2)
                          ],
                        ),
                      ),
                      value: 'enterChat',
                    ),


                  ],
                  onChanged: (itemIdentifier) async {
                     if (itemIdentifier == 'createChat') {
                      _startAddNewTransaction(context);
                    } else if (itemIdentifier == 'enterChat') {
                      _startAddChat(context);
                    }
                  },
                ),
              ),
            ),
          ]),
      body: Container(
          child: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
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

                return new ListView.builder(
                  scrollDirection: Axis.vertical,
                  reverse: true,
                  shrinkWrap: true,
                  itemCount: documents.length,
                  itemBuilder: (ctx, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (ctx) => ChatScreen(
                                    documents[index]['id'].toString())));
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.all(
                              width: 1,
                              color: kPrimaryColorAccent,
                            ),
                            color: kPrimaryColorAccent),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: StreamBuilder<DocumentSnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('chats')
                                  .doc(documents[index]['id'])
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Text('Something went wrong');
                                }

                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(child: LoadingWidget(100, 100));
                                }
                                // final documents = snapshot.data['imageUrl'];

                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap:(){
                                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                                          return DetailScreen(documents[index]['id'],snapshot.data['imageUrl']);
                                        }));
                                      },
                                      child: Hero(
                                        tag:documents[index]['id'],
                                        child: CircleAvatar(
                                          radius: 25,
                                          backgroundImage: NetworkImage(
                                              snapshot.data['imageUrl']),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      snapshot.data['chatName'],
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                );
                              }),
                        ),
                      ),
                    ),
                  ),
                );
              })
        ],
      )),
    );
  }
}


class DetailScreen extends StatelessWidget {
  final String chatId;
  final String chatImage;


  DetailScreen(this.chatId, this.chatImage);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: chatId,
            child: Image.network(chatImage),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
