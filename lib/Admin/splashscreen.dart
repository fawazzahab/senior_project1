
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth/volunteer/uploadOrder.dart';
import 'package:flutter_auth/volunteer/volunteerscreen.dart';
import 'AdminDivider.dart';
import 'package:flutter_auth/Screens/Home/Home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static const routeName='SplashScreen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String role = 'user';

  @override
  void initState() {
    super.initState();
    _checkRole();
  }

  void _checkRole() async {
    User user = FirebaseAuth.instance.currentUser;
    final DocumentSnapshot snap = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

    setState(() {
      role = snap['role'];
    });

    if(role == 'user'){
      Timer(Duration(milliseconds: 500), () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      });
    } else if(role == 'admin'){
      Timer(Duration(milliseconds: 500), () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => adminpath()));
      });
    } else if(role == 'volunteer'){
      Timer(Duration(milliseconds: 500), () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddOrder()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}