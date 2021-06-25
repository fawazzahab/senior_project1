import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Home/main_drawer.dart';
import 'package:flutter_auth/components/rounded_button.dart';

import '../constants.dart';

class EditUser extends StatefulWidget {
  final String uid;

  EditUser({Key key, this.uid}) : super(key: key);
  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  final auth = FirebaseAuth.instance;
  User user;
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    user = auth.currentUser;
    String _email = user.email;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        backgroundColor: appbarcolor,
      ),
      drawer: MainDrawer(),
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          SizedBox(height: 25,),
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
                hintText: "Change Your Name..."
            ),
          ),
          SizedBox(height: 25,),

          SizedBox(height: 25,),
          GestureDetector(
            onTap: () async {
              String newEmail = emailController.text.trim();
              String newName = nameController.text.trim();
              String newPassword = passwordController.text.trim();

              FirebaseFirestore.instance.collection('users').doc(widget.uid).update({
                'username': newName,
                /*'email': newEmail,
                'password': newPassword,*/
              });
            },

            child: Container(
              margin: const EdgeInsets.all(10.0),
              height: 50,
              width: 200,
              color: msgbtncolor,
              child: Center(
                child: Text(
                  "UPDATE DATA",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}