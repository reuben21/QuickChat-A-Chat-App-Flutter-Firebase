import 'package:chat_app_firebase/widget/loading/loading_widget.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: LoadingWidget(200, 200)
      ),
    );
  }
}
