import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants.dart';
import 'AdminDivider.dart';
import 'Admin_drawer.dart';
import 'EditUserAdmin.dart';
import 'createuserscreen.dart';
import 'edituserdata.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  TextEditingController emailController = new TextEditingController();

  String email = " ";
  String uid = " ";
  String role = " ";
  String name = " ";

  bool ableToEdit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
        backgroundColor: appbarcolor,
      ),
      drawer: AdminDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Welcome Admin"),
            SizedBox(height: 50,),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Email",
              ),
            ),
            SizedBox(height: 25,),
            GestureDetector(
              onTap: () async {
                String userEmail = emailController.text.trim();

                final QuerySnapshot snap = await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: userEmail).get();
                setState(() {
                  email = userEmail;
                  uid = snap.docs[0]['uid'];
                  role = snap.docs[0]['role'];
                  name = snap.docs[0]['username'];

                  ableToEdit = true;
                });
              },
              child: Container(
                height: 50,
                width: 100,
                color: msgbtncolor,
                child: Center(
                  child: Text(
                    "Get User Data",
                  ),
                ),
              ),
            ),
            SizedBox(height: 25,),
            ableToEdit ? GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AEditUser(uid: uid,)));
              },
              child: Container(
                height: 50,
                width: 100,
                color: msgbtncolor,
                child: Center(
                  child: Text(
                    "Edit User",
                  ),
                ),
              ),
            ) : Container(),
            SizedBox(height: 25,),
            GestureDetector(
              onTap: () async {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CreateUser()));
              },
              child: Container(
                height: 50,
                width: 100,
                color: msgbtncolor,
                child: Center(
                  child: Text(
                    "Create User",
                  ),
                ),
              ),
            ),
            SizedBox(height: 50,),
            Text('User Data :'),
            SizedBox(height: 50,),
            Text('Email : ',style: TextStyle(fontWeight: FontWeight.bold , fontSize: 25),),
            Text('' + email, style: TextStyle(fontSize: 20),),
            Text('UID : ' ,style: TextStyle(fontWeight: FontWeight.bold , fontSize: 25),),
            Text('' + uid ,style: TextStyle(fontSize: 20),),
            Text('Role : ' ,style: TextStyle(fontWeight: FontWeight.bold , fontSize: 25), ),
            Text('' + role,style: TextStyle( fontSize: 20),),
            Text('Name : ',style: TextStyle(fontWeight: FontWeight.bold , fontSize: 25), ),
            Text('' + name, style: TextStyle(fontSize: 20),),
          ],
        ),
      ),
    );
  }
}