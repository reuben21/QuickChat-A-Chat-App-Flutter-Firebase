import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../colors.dart';
import '../widget/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(String email,
      String password,
      String username,
      bool isLogin, BuildContext ctx) async {
    UserCredential _userCredential;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        _userCredential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        _userCredential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
      }
      await FirebaseFirestore.instance.collection('users').doc(
          _userCredential.user.uid).set({
        'username':username,
        'email':email
      });
    } on PlatformException catch (error) {
      var message = "An error occurred";
      if (error.message != null) {
        message = error.message;
      }

      ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: Theme
              .of(ctx)
              .errorColor,));
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      print(error);
      ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(content: Text(error.toString()), backgroundColor: Theme
              .of(ctx)
              .errorColor,));
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColorAccent,
      body: AuthForm(
        _submitAuthForm,_isLoading
      ),
    );
  }
}
