
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Chats {
  User _user;
  final id = FirebaseFirestore.instance
      .collection('chats').doc().id;

  Chats(this._user);

  void currentUser() async {
    final getUser = await FirebaseAuth.instance.currentUser;
    _user = getUser;
  }

  Future<void> _stream() {
    try {

    } catch (e) {
      print(e);
    }
  }


}