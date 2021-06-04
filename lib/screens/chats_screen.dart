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
                          .collection('chats')
                          .doc()
                          .id;

                      final userData = await FirebaseFirestore.instance
                          .collection('users')
                          .doc(user.uid.toString())
                          .get();
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(user.uid.toString())
                          .collection('chats')
                          .add({'chats': 'PersonalChat', "id": id});
                      FirebaseFirestore.instance
                          .collection('chats')
                          .doc(id)
                          .collection(id)
                          .add({
                        'text': 'I Created This Chat',
                        'createdAt': Timestamp.now(),
                        'userId': user.uid.toString(),
                        'username': userData['username']
                      });
                      FirebaseFirestore.instance
                          .collection('chats')
                          .doc(id)
                          .set({
                        'chatName': 'PersonalChat',
                        'imageUrl':
                            'https://dogtime.com/assets/uploads/2011/03/puppy-development.jpg'
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
                print(documents);
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
                                    documents[index]['chats'].toString(),
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
                          color: kPrimaryColorAccent

                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              FutureBuilder(
                                  future: FirebaseFirestore.instance
                                      .collection('chats')
                                      .doc(documents[index]['id'])
                                      .get(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Text('Something went wrong');
                                    }

                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Text("Loading");
                                    }
                                    final documents = snapshot.data;
                                    return CircleAvatar(
                                      radius: 25,
                                      backgroundImage:
                                          NetworkImage(documents['imageUrl']),
                                    );
                                  }),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                documents[index]['chats'],
                                style: Theme.of(context).textTheme.headline2,
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
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
