import 'package:chat_app_firebase/screens/auth_screen.dart';
import 'package:chat_app_firebase/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().whenComplete(() {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'QuickChat',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryIconTheme: IconThemeData(color: kSecondaryColor),
          primaryColorLight: kPrimaryColor,
          primaryColor: kPrimaryColor,
          accentColor: kPrimaryColorAccent,
          textTheme: ThemeData
              .light()
              .textTheme
              .copyWith(
            bodyText2: GoogleFonts.lato(fontSize: 15,
                color: kSecondaryColor,
                fontWeight: FontWeight.w400),
            bodyText1: GoogleFonts.lato(fontSize: 15,
                color: kPrimaryColorAccent,
                fontWeight: FontWeight.w400),
            headline6: GoogleFonts.lato(fontSize: 15,
                color: kPrimaryColorAccent,
                fontWeight: FontWeight.w400),
            headline5: GoogleFonts.lato(fontSize: 12, color: kSecondaryColor),
            headline4: GoogleFonts.lato(fontSize: 14, color: kSecondaryColor),
            headline3: GoogleFonts.lato(fontSize: 16, color: kSecondaryColor),
            headline2: GoogleFonts.lato(fontSize: 18, color: kSecondaryColor),
            headline1: GoogleFonts.lato(fontSize: 25, color: kSecondaryColor),
          ),
        ),
        home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ChatScreen();
            }
            return AuthScreen();
          },)
    );
  }
}
