
import 'package:chat_app_firebase/colors.dart';
import 'package:chat_app_firebase/widget/loading/loading_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  static const routeName= '/profilepage';

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final _userName = new TextEditingController();
  final _userEmail = new TextEditingController();
  DocumentSnapshot _userData;
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState()  {

    // TODO: implement initState
    super.initState();
    getUserData();


  }

  Future<void> getUserData() async {
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid.toString())
        .get();
    setState(() {
      _userData=userData;
    });
    _userName.text = userData['username'];
    _userEmail.text = userData['email'];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return Scaffold(
      appBar: AppBar(title: Text('Your Profile',style: Theme.of(context).textTheme.bodyText1,textAlign: TextAlign.center,)),
      body:_userData==null? Center(child: LoadingWidget(100,100),): SingleChildScrollView(child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 10,),
            CircleAvatar(
              radius: 100,
              backgroundImage: NetworkImage(_userData['imageUrl']),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(

                controller:_userName ,
                decoration: InputDecoration(
                     labelText: 'Username',),),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(

                controller:_userEmail ,
                decoration: InputDecoration(
                   labelText: 'Email',),),
            ),
            SizedBox(height: 10,),
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: (){
                      FirebaseAuth.instance.signOut();
                    },
                    child: Container(
                      width: 120,
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.exit_to_app,
                            color: kPrimaryColor,
                          ),
                          SizedBox(width: 10,),
                          Text('Logout',style: Theme.of(context).textTheme.headline1,),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )




          ],
        ),
      )),
    );
  }
}
