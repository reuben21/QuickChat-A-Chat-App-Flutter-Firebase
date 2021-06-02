import 'package:chat_app_firebase/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

void main() {
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuickChatt',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryIconTheme: IconThemeData(color: kSecondaryColor),
        primaryColorLight: kPrimaryColor,
        primaryColor: kPrimaryColor,
        accentColor: kPrimaryColorAccent,
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: GoogleFonts.lato(fontSize: 15, color: kSecondaryColor),
              headline5: GoogleFonts.lato(fontSize: 12, color: kSecondaryColor),
              headline4: GoogleFonts.lato(fontSize: 14, color: kSecondaryColor),
              headline3: GoogleFonts.lato(fontSize: 16, color: kSecondaryColor),
              headline2: GoogleFonts.lato(fontSize: 18, color: kSecondaryColor),
              headline1: GoogleFonts.lato(fontSize: 25, color: kSecondaryColor),
            ),
      ),
      home: ChatScreen(),
    );
  }
}
