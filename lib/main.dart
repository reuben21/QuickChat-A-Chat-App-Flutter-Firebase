import 'package:chat_app_firebase/screens/auth_screen.dart';

import 'package:chat_app_firebase/screens/chats_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  print(message.data);
  flutterLocalNotificationsPlugin.show(
      message.data.hashCode,
      message.data['title'],
      message.data['body'],
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channel.description,
        ),
      ));
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().whenComplete(() {

  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String token;

  @override
  void initState() {
    super.initState();
    var initialzationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
    InitializationSettings(android: initialzationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                icon: android?.smallIcon,
              ),
            ));
      }
    });
    getToken();

  }
  getToken() async {
    token = await FirebaseMessaging.instance.getToken();
    setState(() {
      token = token;
    });
    print(token);
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
            bodyText2: GoogleFonts.lato(fontSize: 18,
                color: kSecondaryColor,
                fontWeight: FontWeight.w400),
            bodyText1: GoogleFonts.lato(fontSize: 18,
                color: kPrimaryColorAccent,
                fontWeight: FontWeight.w400),
            headline6: GoogleFonts.lato(fontSize: 15,
                color: kPrimaryColorAccent,
                fontWeight: FontWeight.w400),
            headline5: GoogleFonts.lato(fontSize: 12, color: kSecondaryColor),
            headline4: GoogleFonts.lato(fontSize: 14, color: kSecondaryColor),
            headline3: GoogleFonts.lato(fontSize: 16, color: kPrimaryColor),
            headline2: GoogleFonts.lato(fontSize: 18, color: kPrimaryColor),
            headline1: GoogleFonts.lato(fontSize: 20, color: kPrimaryColor),
          ),
        ),
        home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ChatsScreen();
            }
            return AuthScreen();
          },)
    );
  }
}
