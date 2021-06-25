import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Admin/statsScreen.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Testing/adminShop.dart';
import 'package:flutter_auth/volunteer/uploadOrder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'adminscreen.dart';

class AdminDrawer extends StatelessWidget {
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
                'Check users ! ',
                style: TextStyle(
                  fontSize: 18,
                )
            ),
            onTap: ()
            {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AdminScreen()));
            },
          ),

          ListTile(
            leading: Icon(Icons.chat),
            title : Text(
                'Products !',
                style: TextStyle(
                  fontSize: 18,
                )
            ),
            onTap: ()
            {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => adminShop()));
            },
          ),
          ListTile(
            leading: Icon(Icons.chat),
            title : Text(
                ' Statistics !',
                style: TextStyle(
                  fontSize: 18,
                )
            ),
            onTap: ()
            {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => statsScreen()));
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
