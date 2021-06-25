import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/Signup/components/background.dart';
import 'package:flutter_auth/Screens/Signup/components/or_divider.dart';
import 'package:flutter_auth/Screens/Signup/components/social_icon.dart';
import 'package:flutter_auth/Screens/Signup/components/verificationScreen.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_auth/Screens/Home/Home_screen.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  String _email,_password,_name;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "SIGNUP",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "assets/icons/signup.svg",
                height: size.height * 0.35,
              ),
              RoundedInputField(
                hintText: "Your Name",
                onChanged: (value) {
                  setState(() {
                    _name = value.trim();
                  });
                },
              ),
              RoundedInputField(
                hintText: "Your Email",
                onChanged: (value) {
                  setState(() {
                    _email = value.trim();
                  });
                },
              ),
              RoundedPasswordField(
                onChanged: (value) {
                  setState(() {
                      _password = value.trim();
                  });
                },
              ),
              RoundedButton(
                text: "SIGNUP",
                press: () async {
                  if (validateStructure(_password) == false) {
                    showAlertDialog(context);
                  }
                  else {
                    try {
                      auth.createUserWithEmailAndPassword(
                          email: _email, password: _password);
                      await auth.currentUser.reload();
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => verificationScreen()));
                    }
                    catch (e) {
                      print("The exception thrown is $e");
                    }
                    finally {
                      User user = FirebaseAuth.instance.currentUser;
                      FirebaseFirestore.instance.collection("users").doc(
                          user.uid).set({
                        'uid': user.uid,
                        'email': _email,
                        'password': _password,
                        'role': 'user',
                        'username' : _name,
                        'imageURL': 'https://firebasestorage.googleapis.com/v0/b/email-login-1be37.appspot.com/o/blank-profile-picture-973460_1280.jpg?alt=media&token=dc22531c-64a8-4ec7-af0d-1e4618cd1748',
                      });
                    };
                  };
                },
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
bool validateStructure(String value) {
  String pattern = r'^(?=.?[A-Z])(?=.?[a-z])(?=.*?[0-9])';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
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
    title: Text("Error"),
    content: Text(
        'your password have to include'
    '\n Minimum 1 Upper case'
        '\n Minimum 1 lowercase'
        '\n Minimum 1 Numeric Number'
        '\n and password length more than 6' ),
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
