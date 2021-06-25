import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Home/main_drawer.dart';
import 'package:flutter_auth/volunteer/volunteer_drawer.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import 'package:flutter_auth/chat/chatpage.dart';

import 'VchatPage.dart';

class VHome extends StatefulWidget {
  @override
  _VHomeState createState() => _VHomeState();
}

class _VHomeState extends State<VHome> {
  GoogleSignIn googleSignIn = GoogleSignIn();
  String userId;
  String docId;

  @override
  void initState() {
    getUserId();
    super.initState();
  }

  getUserId() async {
    //SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    User user = FirebaseAuth.instance.currentUser;
    userId = user.uid;

    //userId = sharedPreferences.getString('uid');
  }

  getdocumentId() async{
    docId = getdocumentId();
  }
  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _Firestore= FirebaseFirestore.instance;

    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('Home Screen'),
          backgroundColor: appbarcolor,
          actions: <Widget>[
          ],
        ),
        drawer: volunteer_drawer(),
        body: StreamBuilder<QuerySnapshot>(
          stream: _Firestore.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return ListView.builder(
                itemBuilder: (listContext, index) =>
                    buildItem(snapshot.data.docs[index]),
                itemCount: snapshot.data.docs.length,
              );
            }

            return Container();
          },
        ));
  }

  buildItem(doc) {
    return (userId != doc['uid'])
        ? GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => VChatPage(docs: doc)));
      },
      child: Card(
        color: msgbtncolor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Center(
              child:
              Text(doc['email']),
            ),
          ),
        ),
      ),
    )
        : Container();
  }
}