import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Profile/TestProfile.dart';
import 'package:flutter_auth/Screens/Donations/DonationHome.dart';
import 'package:flutter_auth/Screens/Home/Home_screen.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/chat/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Details_screen.dart';
import 'package:flutter_auth/Profile/ProfileModule.dart';

class MainDrawer extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  User user;
  profileModel currentuserdata;

  void getName() async{
    User user = FirebaseAuth.instance.currentUser;
    final DocumentSnapshot snap = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
  }
    getUserdata() async{
    String userEmail = user.email;

    final QuerySnapshot snap =
       await  FirebaseFirestore.
    instance.
    collection('users').
    where('email', isEqualTo: userEmail).
    get();
   {
     currentuserdata.name = snap.docs[0]['username'];
     currentuserdata.imageURL = snap.docs[0]['imageURL'];
    }

  }

        @override
  Widget build(BuildContext context) {
    getUserdata();
    final user = auth.currentUser;
    return  Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width : double.infinity,
            padding: EdgeInsets.all(20),
            color: Colors.purple[400],
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(
                      top: 50,
                      bottom: 10,
                    ),

                   /* decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),*/
                  ),
                  Text(
                    'Email: ${user.email}',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ]
              ),
            ),
          ),

         ListTile(
           leading: Icon(Icons.home_filled ),
           title : Text(
               'Home Page',
                   style: TextStyle(
               fontSize: 18,
           )
           ),
             onTap: ()
           {
             Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
           },
         ),


         /*ListTile(
            leading: Icon(Icons.account_circle),
            title : Text(
                'Profile Page',
                style: TextStyle(
                  fontSize: 18,
                )
            ),
            onTap: ()
            {
              //getUserdata();
              Navigator.pushNamed(context, SettingsUI.routeName,arguments:currentuserdata );
            },
          ),


          */
          ListTile(
            leading: Icon(Icons.chat),
            title : Text(
                'Messages',
                style: TextStyle(
                  fontSize: 18,
                )
            ),
            onTap: ()
            {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
            },
          ),
          ListTile(
            leading: Icon(Icons.attach_money),
            title : Text(
                'Donate ! ',
                style: TextStyle(
                  fontSize: 18,
                )
            ),
            onTap: ()
            {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => DonationHome()));
            },
          ),
          ListTile(
            leading: Icon(Icons.accessibility),
            title : Text(
                'About Us',
                style: TextStyle(
                  fontSize: 18,
                )
            ),
            onTap: ()
            {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => DetailsScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title : Text(
                'Log Out',
                style: TextStyle(
                  fontSize: 18,
                )
            ),
            onTap: ()
            async {
              SharedPreferences pref  =await SharedPreferences.getInstance();
              pref.clear();
              signOut();

              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          )
        ],
      ),
    );
  }

 Future<void> signOut() async {
await auth.signOut();
 }
}


