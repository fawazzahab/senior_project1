
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Home/main_drawer.dart';

import '../../constants.dart';
import 'Home_screen.dart';


class DetailsScreen extends StatelessWidget{

  User user;
  static const routeName = '/flutter_auth/Screens/Home/Details_screen.dart';
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('About Us '),
          backgroundColor: appbarcolor,
        ),
        drawer: MainDrawer(),
        body: Center(
            child: Column(
              children: <Widget>[
                Text(''),
                Text('One of the most common dilemmas housewives struggle with everyday is left-over food; and what bothers the most in this problem, is dumping the food when it goes out of date. ',
                  style: TextStyle(fontSize: 22),),
                Text(''),
                Text('With the hunger strike increasing around the world, and especially around us in Lebanon, we feel guilty in houses throwing away food, knowing people desire the basic food necessities.',
                  style: TextStyle(fontSize: 22),),
                Text(''),
                  Text('Combining these two global problems we decided to build an interactive yet simple application to solve this issue in Tripoli.',
                  style: TextStyle(fontSize: 22),),
                Text(''),
                Text('Our Solution:',style: TextStyle(fontSize: 30),),
                Text(''),
                  Text('This user-friendly applications connects people who have extra food in their houses with people who need food on their table through volunteers and NGOs in Tripoli.',
                    style: TextStyle(fontSize: 22),),
              ],
            )
        )
    );
  }
}