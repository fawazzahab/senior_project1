
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';import 'package:flutter_auth/Screens/Home/Home_screen.dart';
import 'package:flutter_auth/Screens/Home/main_drawer.dart';

class Messaging extends StatefulWidget{
  static const routeName = '/flutter_auth/Screens/Home/Messaging.dart';

  @override
  _MessagingState createState() => _MessagingState();
}
class _MessagingState extends State<Messaging> {
@override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Messaging Screen'),
          backgroundColor: Colors.blueAccent,
        ),
        drawer: MainDrawer(),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('We are in the Messaging Page now',
                  style: TextStyle(fontSize: 22),),
                FloatingActionButton(
                  child: Icon(Icons.arrow_back_ios),
                  onPressed: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                )
              ],
            )
        )
    );
  }
}