import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Donations/DonationHome.dart';
import 'package:flutter_auth/Screens/Home/Home_screen.dart';
import 'package:flutter_auth/Screens/Home/Messaging.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/UsedChat/MessagingScreen.dart';
import 'package:flutter_auth/Screens/Donations/donationFood.dart';
import 'package:flutter_auth/chat/chatpage.dart';
import 'package:flutter_auth/chat/home.dart';
import 'package:flutter_auth/volunteer/uploadOrder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'VolunteerChatPage.dart';

class volunteer_drawer extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  User user;

  void getName() async{
    User user = FirebaseAuth.instance.currentUser;
    final DocumentSnapshot snap = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

  }
  @override
  Widget build(BuildContext context) {
    user = auth.currentUser;
    return  Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width : double.infinity,
            padding: EdgeInsets.all(20),
            color: Colors.purple[400],
            child: Center(
              child: Column(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(
                        top: 50,
                        bottom: 10,
                      ),

                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Text(
                      'Email: ${user.email}',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ]
              ),
            ),
          ),

          ListTile(
            leading: Icon(Icons.home_filled ),
            title : Text(
                'Home Page',
                style: TextStyle(
                  fontSize: 18,
                )
            ),
            onTap: ()
            {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AddOrder()));
            },
          ),

          ListTile(
            leading: Icon(Icons.chat),
            title : Text(
                'Messages',
                style: TextStyle(
                  fontSize: 18,
                )
            ),
            onTap: ()
            {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => VHome()));
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title : Text(
                'Log Out',
                style: TextStyle(
                  fontSize: 18,
                )
            ),
            onTap: ()
            async {
              SharedPreferences pref  =await SharedPreferences.getInstance();
              pref.clear();
              signOut();

              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          )
        ],
      ),
    );
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
