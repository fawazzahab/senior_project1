import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Admin/statsScreen.dart';
import 'package:flutter_auth/Testing/adminShop.dart';
import 'package:flutter_auth/components/newRoundedButton.dart';

import '../constants.dart';
import 'Admin_drawer.dart';
import 'adminscreen.dart';

class adminpath extends StatefulWidget {
  @override
   _adminpathState createState() => _adminpathState();
}

class _adminpathState extends State<adminpath> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home Screen'),
          backgroundColor: appbarcolor,
        ),
        drawer: AdminDrawer(),
        body: Center(
          child: Column(


        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            newRoundedButton(
              press:(){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AdminScreen()));
                },
              text:("Users"),
            ),
            newRoundedButton(
             press:(){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => adminShop()));
              },
              text:("Products"),
            ),
            newRoundedButton(
              press:(){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => statsScreen()));
              },
              text:("stats"),
            )
          ],
        )
        )
    );
}
}
