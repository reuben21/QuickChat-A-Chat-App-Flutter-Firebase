import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatelessWidget {
  final double width;
  final double height;

  LoadingWidget(this.width, this.height);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Lottie.asset(
      'assets/lottie/chat.json',
      width: width,
      height: height,
      fit: BoxFit.fill,
    );
  }
}
