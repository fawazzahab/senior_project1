import 'package:flutter_auth/Screens/Donations/donationFood.dart';
import 'package:flutter_auth/Screens/Home/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Testing/ItemsScreen.dart';
import 'package:flutter_auth/components/newRoundedButton.dart';
import 'package:flutter_auth/components/rounded_button.dart';

import '../../constants.dart';
import 'donationMoney.dart';

class DonationHome extends StatefulWidget {
  @override
  _DonationHomeState createState() => _DonationHomeState();
}

class _DonationHomeState extends State<DonationHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donation'),
          backgroundColor: appbarcolor,
      ),
      drawer: MainDrawer(),
      body: Stack(
          children:<Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: new AssetImage('assets/images/Welcome_TooFoodToGo_2.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: null /* add child content here */,
          ),
          Center(
                  child:Form(
                      child:Column (
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:<Widget> [
                          /*Text('Choose your type of Donation',
                              style: TextStyle(fontSize: 22),),*/
                          Text(''),
                          newRoundedButton(
                            icon: Icon(Icons.fastfood),
                            text: "Food Donations",
                            press: (){
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => foodDonationScreen()));
                              padding: EdgeInsets.all(0.0);
                            },
                          ),
                          newRoundedButton(
                            text: "Money Donations",
                            press: (){
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MoneyDonationScreen()));
                            },
                          ),
                          newRoundedButton(
                           text: "Donate Items",
                                 press: (){
                                   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ItemsScreen()));
                              },
                            ),
                        ],
                      )
                  )
              )
        ]
      ),
    );
  }
}
