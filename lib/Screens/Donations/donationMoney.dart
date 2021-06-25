
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_auth/Screens/Home/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/components/newRoundedButton.dart';
import 'package:flutter_auth/components/rounded_button.dart';

import '../../constants.dart';


// ignore: camel_case_type
class MoneyDonationScreen extends StatefulWidget {

  @override
  _MoneyDonationScreenState createState() => _MoneyDonationScreenState();
}
// ignore: camel_case_types
class _MoneyDonationScreenState extends State<MoneyDonationScreen> {
  var _expiryyear, _expirydate, CardNumber, CardHolder, CVC;
  int amount;



  // ignore: non_constant_identifier_names
  List<String> _Years = <String>[
    "2021",
    "2022",
    "2023",
    "2024",
    "2025",
    "2026",
    "2027",
    "2028",
    "2029",
    "2030",
    "2031",
    "2032",
  ];
  List<String> month = <String>[
    "01",
    "02",
    "03",
    "04",
    "05",
    "06",
    "07",
    "08",
    "09",
    "10",
    "11",
    "12",

  ];
  @override
  Widget build(BuildContext context) {
    /* */
    return Scaffold(
        appBar: AppBar(
          title: Text('Money donation'),
          backgroundColor: appbarcolor,
        ),
        drawer: MainDrawer(),
        body: Stack(
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Colors.purple[300],
                            Colors.grey[400],
                          ]
                      )
                  )
              ),
              Center(
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                        height: 460,
                        width: 350,
                        padding: EdgeInsets.all(16),

                        child: Form(
//
                            child: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[

                                  TextFormField(

                                      decoration: InputDecoration(
                                          labelText: 'Card Number '),
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Can't be empty";
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        CardNumber = value;
                                      }
                                  ),
                                  TextFormField(
                                      decoration: InputDecoration(
                                          labelText: 'Card Holder Name'),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Can't be empty";
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        CardHolder = value;
                                      }
                                  ),
                                  TextFormField(

                                      decoration: InputDecoration(
                                          labelText: 'CVV '),

                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Can't be empty";
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        CVC = value;
                                      }
                                  ),
                                  TextFormField(

                                      decoration: InputDecoration(
                                          labelText: 'Specified Amount '),
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Can't be empty";
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        amount = value.trim() as int;
                                      }
                                  ),

                                  DropdownButton(
                                    items: _Years.map((value) =>
                                        DropdownMenuItem(
                                          child: Text(
                                            value,
                                          ),
                                          value: value,
                                        )).toList(),
                                    onChanged: (selectedType) {
                                      setState(() {
                                        _expiryyear = selectedType;
                                      }
                                      );
                                    },
                                    value: _expiryyear,
                                    isExpanded: false,
                                    hint: Text('Select Expiry Year'),
                                  ),

                                  DropdownButton(
                                    items: month.map((value) =>
                                        DropdownMenuItem(
                                          child: Text(
                                            value,
                                          ),
                                          value: value,
                                        )).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _expirydate = value;
                                      }
                                      );
                                    },
                                    value: _expirydate,
                                    isExpanded: false,
                                    hint: Text('Select Expiry Month'),
                                  ), //another drop down
                                  RoundedButton(
                                    text: "Submit",
                                    press: () {
                                      FirebaseFirestore.instance.collection(stats).doc('rYUkgjPpN5eepxOySu4X').update({
                                        'money_donated':FieldValue.increment(amount),
                                      });
                                    },
                                    // =>_launchURL('mysecondemail.ab@gmail.com', 'Flutter Email Test', 'Hello Flutter'),
                                  ),
                                ],
                              ),
                            )
                        )
                    )
                ),
              )
            ]
        )
    );
  }
}
