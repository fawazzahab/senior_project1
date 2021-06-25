import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'Admin_drawer.dart';

class AEditUser extends StatefulWidget {
  final String uid;

  AEditUser({Key key, this.uid}) : super(key: key);
  @override
  _AEditUserState createState() => _AEditUserState();
}

class _AEditUserState extends State<AEditUser> {
  final auth = FirebaseAuth.instance;
  User user;
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController RoleController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    user = auth.currentUser;
    String _email = user.email;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        backgroundColor: appbarcolor,
      ),
      drawer: AdminDrawer(),
      body:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SizedBox(height: 25,),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                  hintText: "Change The Name..."
              ),
            ),
            GestureDetector(
              onTap: () async {
                String newName = nameController.text.trim();
                FirebaseFirestore.instance.collection('users').doc(widget.uid).update({
                  'username': newName,
                });
                showAlertDialog(context);
              },

              child: Container(
                margin: const EdgeInsets.all(10.0),
                height: 50,
                width: 200,
                color: msgbtncolor,
                child: Center(
                  child: Text(
                    "UPDATE Name",
                  ),
                ),
              ),
            ),
            TextFormField(
              controller: RoleController,
              decoration: InputDecoration(
                  hintText: "Change The Role..."
              ),
            ),
            GestureDetector(
              onTap: () async {
                String newRole = RoleController.text.trim();

                FirebaseFirestore.instance.collection('users').doc(widget.uid).update({
                  'role' : newRole

                });
                showAlertDialog(context);
              },

              child: Container(
                margin: const EdgeInsets.all(10.0),
                height: 50,
                width: 200,
                color: msgbtncolor,
                child: Center(
                  child: Text(
                    "UPDATE ROLE",
                  ),
                ),
              ),
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                  hintText: "Change The Password..."
              ),
            ),

            SizedBox(height: 25,),

            GestureDetector(
              onTap: () async {
                String newPassword = passwordController.text.trim();


                FirebaseFirestore.instance.collection('users').doc(widget.uid).update({

                  'password': newPassword,
                });
                showAlertDialog(context);
              },

              child: Container(
                margin: const EdgeInsets.all(10.0),
                height: 50,
                width: 200,
                color: msgbtncolor,
                child: Center(
                  child: Text(
                    "UPDATE Password",
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
showAlertDialog(BuildContext context) {

  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Done"),
    content: Text("Successfully Updated ! "),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}