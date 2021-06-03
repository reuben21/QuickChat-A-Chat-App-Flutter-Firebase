import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../colors.dart';
import '../widget/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  final _auth = FirebaseAuth.instance;

  void _submitAuthForm(String email,
      String password,
      String username,
      bool isLogin,BuildContext ctx) async {
    UserCredential _userCredential;
    try {
      if (isLogin) {
        _userCredential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        _userCredential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
      }
    } on PlatformException catch (error) {
      var message = "An error occurred";
      if (error.message != null) {
        message = error.message!;
      }

      ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: Theme
              .of(context)
              .errorColor,));
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColorAccent,
      body: AuthForm(
        _submitAuthForm,
      ),
    );
  }
}
