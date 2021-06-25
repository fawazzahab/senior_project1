import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth/Admin/AdminDivider.dart';
import 'package:flutter_auth/Admin/createuserscreen.dart';
import 'package:flutter_auth/Admin/edituserdata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Home/main_drawer.dart';

import '../constants.dart';

class EditProfilePage extends StatefulWidget {

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController emailController = new TextEditingController();
  final auth = FirebaseAuth.instance;
  User user;
  String email = " ";
  String uid = " ";
  String role = " ";
  String name = " ";
  String password = " ";

  bool ableToEdit = false;

  @override
  Widget build(BuildContext context) {
    user = auth.currentUser;
    return Scaffold(

      appBar: AppBar(
        title: Text('Profile Page'),
        backgroundColor: appbarcolor,
      ),
      drawer: MainDrawer(),
      body: Column(
        crossAxisAlignment:CrossAxisAlignment.center,
        mainAxisAlignment:  MainAxisAlignment.center,
        children: [
          Text("Your Profile",style: TextStyle(fontWeight: FontWeight.bold , fontSize: 50),),
          SizedBox(height: 25,),
          GestureDetector(
            onTap: () async {
              String userEmail = user.email;

              final QuerySnapshot snap =
              await FirebaseFirestore.
              instance.
              collection('users').
              where('email', isEqualTo: userEmail).
              get();
              setState(() {
                email = userEmail;
                uid = snap.docs[0]['uid'];
                role = snap.docs[0]['role'];
                password = snap.docs[0]['password'];
                name = snap.docs[0]['username'];

                ableToEdit = true;
              });
            },
            child: Container(
              height: 50,
              width: 200,
              color: msgbtncolor,
              child: Center(
                child: Text(
                  "Show Your Info",
                ),
              ),
            ),
          ),
          SizedBox(height: 25,),
          GestureDetector(
            onTap: () async {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CreateUser()));
            },
            child: Container(
              padding: const EdgeInsets.all(8.0),
              height: 50,
              width: 200,
              color:  msgbtncolor,
              child: Center(
                child: Text(
                  "Apply to be a Volunteer",
                ),
              ),
            ),
          ),
          SizedBox(height: 25,),
          ableToEdit ? GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => EditUser(uid: uid,)));
            },
            child: Container(

              height: 50,
              width: 200,
              color: msgbtncolor,
              child: Center(
                child: Text(
                  "Edit Your Info",
                ),
              ),
            ),
          ) : Container(),

          SizedBox(height: 25,),
          Text('User Data :',style: TextStyle(fontWeight: FontWeight.bold , fontSize: 50),),
          SizedBox(height: 25,),
          Text('Email :'+ email ,style: TextStyle(fontWeight: FontWeight.bold , fontSize: 25),),
          Text('Name :'+  name,style: TextStyle(fontWeight: FontWeight.bold , fontSize: 25), ),
          Text('Role :'+  role,style: TextStyle(fontWeight: FontWeight.bold , fontSize: 25),),

        ],
      ),

    );
  }
}

