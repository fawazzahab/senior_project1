import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class passReset extends StatefulWidget {
  @override
  _passResetState createState() => _passResetState();
}

class _passResetState extends State<passReset> {
  String _email;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('reset pass?'),
        actions: <Widget>[
        ],
      ),
      body: Stack(children: <Widget>[
        Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.purple,
                  Colors.purpleAccent,
                ]))),
        Center(
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                    height: 260,
                    width: 300,
                    padding: EdgeInsets.all(16),
                    child:Column(
                      children: <Widget>[
                        //email
                        TextFormField(
                            decoration: InputDecoration(labelText: 'email'),
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              _email=value;
                            }),
                        RaisedButton(
                          child: Text('send email'),
                          onPressed: (){
                            auth.sendPasswordResetEmail(email: _email);
                            Navigator.of(context).pop();
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          color: Colors.blue,
                          textColor: Colors.white,
                        )
                      ],
                    )
                )
            )
        )
      ]
      ),
    );
  }
}