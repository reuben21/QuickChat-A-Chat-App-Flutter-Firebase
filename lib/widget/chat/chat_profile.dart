import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../colors.dart';

class ChatProfile extends StatefulWidget {
  final String image;
  final String chatName;
  final String chatId;
  final List listOfUsers;

  ChatProfile(this.image,this.chatId, this.chatName, this.listOfUsers);

  @override
  _ChatProfileState createState() {
    return _ChatProfileState();
  }
}

class _ChatProfileState extends State<ChatProfile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    print(widget.listOfUsers);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColorAccent,
          title: Text(
            widget.chatName,
            style: Theme.of(context).textTheme.headline3,
          ),
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
        ),
        body: SingleChildScrollView(
          child: Column(

            children: <Widget>[
              Container(
                width: double.infinity,
                height: 350,
                child: Image.network(
                  widget.image.toString(),
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(
                        width: 1,
                        color: kPrimaryColorAccent,
                      ),
                      color: kPrimaryColorAccent),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SelectableText(
                      '${widget.chatId}',
                      style: TextStyle(fontSize: 15,color:kPrimaryColor),
                      textAlign: TextAlign.center,
                    ),
                  )),
              Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(
                        width: 1,
                        color: kPrimaryColorAccent,
                      ),
                      color: kPrimaryColorAccent),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Users',
                      style: TextStyle(fontSize: 15,color:kPrimaryColor),
                      textAlign: TextAlign.center,
                    ),
                  )),
              FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .where(FieldPath.documentId, whereIn:widget.listOfUsers).get(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    }
                    final documents = snapshot.data.docs;
                    print(documents[0]['email']);
                    return new ListView.builder(
                        scrollDirection: Axis.vertical,
                        reverse: true,
                        shrinkWrap: true,
                        itemCount: documents.length,
                        itemBuilder: (ctx, index) => Container(
                              width: double.infinity,
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  border: Border.all(
                                    width: 1,
                                    color: kPrimaryColorAccent,
                                  ),
                                  color: kPrimaryColorAccent),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundImage: NetworkImage(
                                          documents[index]['imageUrl']),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      documents[index]['username'],
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                              ),
                            ));
                  }),
            ],
          ),
        ));
  }
}
