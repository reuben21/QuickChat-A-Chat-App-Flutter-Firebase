import 'package:flutter/material.dart';

import '../colors.dart';
import '../widget/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  void _submitAuthForm(
      String email,
      String password,
      String username,
      bool isLogin,
      ) {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColorAccent,
      body: AuthForm(_submitAuthForm,),
    );
  }
}
