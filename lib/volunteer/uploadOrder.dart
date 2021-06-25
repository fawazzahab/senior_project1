import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/components/newRoundedButton.dart';
import 'package:flutter_auth/volunteer/ItemOrderScreen.dart';
import 'package:flutter_auth/volunteer/volunteer_drawer.dart';
import 'package:flutter_auth/volunteer/volunteerscreen.dart';
import '../constants.dart';
import 'OrdersModel.dart';
import 'VolunteersOrders.dart';
// ignore: must_be_immutable
class AddOrder extends StatelessWidget {

  String _email, _pnumber, _size, _location, _notes, _type;
  final GlobalKey<FormState> _globalKey=GlobalKey<FormState>();
  final _orders = orders();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: volunteer_drawer(),
      appBar: AppBar(
        title: Text('Donation'),
        backgroundColor: appbarcolor,
      ),

      body: Stack(
        children: <Widget>[
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget> [
            newRoundedButton(
            text: "food orders",
                press:(){
               Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => VolunteerScreen()));
         }
        ),
            newRoundedButton(
              text: "item order",
              press:(){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ItemOrderScreen()));
              }
            ),

          ],
        ),
      ),
    ]
      ),

    );
  }
}
