import 'package:chat_app_firebase/colors.dart';
import 'package:chat_app_firebase/screens/chats_screen.dart';
import 'package:chat_app_firebase/screens/profile.dart';
import 'package:flutter/material.dart';


class TabsScreen extends StatefulWidget {



  @override
  _TabsScreenState createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {

  List<Map<String, Object>> _pages;

  @override
  void initState() {
    _pages = [
      {'page': ChatsScreen(), },
      {'page': UserProfile(), }

    ];
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }



  int _selectPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(


      body: _pages[_selectPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kPrimaryColorAccent,
        unselectedItemColor: kPrimaryColor,
        selectedItemColor: kPrimaryColor,
        currentIndex: _selectPageIndex,
        onTap: _selectPage,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.question_answer_outlined), label: 'Chats'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined), label: 'Profile'),

        ],
      ),
    );
  }
}