
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_auth/Admin/splashscreen.dart';
import 'package:flutter_auth/Screens/Home/Home_screen.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';
import 'package:flutter_auth/Screens/Login/components/passReset.dart';
import 'package:flutter_auth/Screens/Signup/signup_screen.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../../constants.dart';


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
class ToastExample extends StatefulWidget {
  @override
  _ToastExampleState createState(){
    return _ToastExampleState();
  }
}

class _ToastExampleState extends State {
  void showToast() {
    Fluttertoast.showToast(
        msg: 'This is toast notification',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.yellow
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
class _MyAppState extends State<MyApp> {
  bool keeplogedin=false;
  String _email,_password,role;
  final auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
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
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Text("remember me",
                      style: TextStyle(
                          color: appbarcolor
                      ),
                  ),
                  Theme(
                    data:ThemeData  (
                      unselectedWidgetColor:Colors.purple
                    ),
                    child: Checkbox(
                      checkColor: kPrimaryColor,
                      activeColor: Colors.white,
                      value:keeplogedin,
                      onChanged: (value){
                        setState(() {
                          keeplogedin=value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),



            RoundedButton(
              text: "LOGIN",
              press: () async {
                //auth.signInWithEmailAndPassword(email: _email, password: _password);
                // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
                try {
                  if(keeplogedin==true){
                    KeepUserLogedIn();
                  }
                  await auth.signInWithEmailAndPassword(email: _email, password: _password);
                    // ignore: unnecessary_statements
                  await auth.currentUser.reload();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SplashScreen()));
                  return
                    FirebaseFirestore.instance.collection(stats).doc('rYUkgjPpN5eepxOySu4X').update({
                    'nb_users':FieldValue.increment(1),
                  });
                }on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    showAlertDialog(context);
                  } else if (e.code == 'wrong-password') {
                    showAlertDialog(context);
                  }
                }

                },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
            Center(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    TextButton(child:Text('forgot password?',
                    style: TextStyle(
                        color: appbarcolor,
                    ),
                    ),
                      onPressed: (){
                        Navigator.push(
                        context,
                          MaterialPageRoute(
                        builder: (context) {
                          return passReset();
                    },
                  ),
                );            },)

              ]),
            )
          ],
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

  void KeepUserLogedIn() async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    preferences.setBool(Ukeeplog, keeplogedin);
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
    title: Text("Error"),
    content: Text("Wrong Email or password"),
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

