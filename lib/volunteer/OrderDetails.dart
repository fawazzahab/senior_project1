import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Home/main_drawer.dart';
import 'package:flutter_auth/Testing/constance.dart';
import 'package:flutter_auth/Testing/products.dart';
import 'package:flutter_auth/Testing/productsModel.dart';
import 'package:flutter_auth/volunteer/ItemOrderModel.dart';

import '../constants.dart';

class OrderDetails extends StatelessWidget {
  static const String routeName = "/OrderDetails";
  products _order=products();
  @override
  Widget build(BuildContext context) {
    ItemOrderModel order = ModalRoute
        .of(context)
        .settings
        .arguments;
    User user=FirebaseAuth.instance
        .currentUser;
    return Scaffold(
        appBar: AppBar(
          title: Text('order Detail'),
          backgroundColor: Colors.purple,


        ),

        body:StreamBuilder<QuerySnapshot>(
          stream: _order.loadOrdersDetails(order.Did),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<productsModel> products = [];
              for (var doc in snapshot.data.docs) {
                var data =doc.data();
                products.add(productsModel(
                  Pname: data[productsName],
                  Pquantity: data['quantity'],
                  Pcategories: data[Productcategory],
                ));
              }

              return Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          height: MediaQuery.of(context).size.height * .2,
                          color: kPrimaryColor,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('product name : ${products[index].Pname}',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Quantity : ${products[index].Pquantity}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'product Category : ${products[index].Pcategories}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      itemCount: products.length,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: ButtonTheme(
                            buttonColor: kPrimaryColor,
                            child: RaisedButton(
                              onPressed: () { if(order.TakenBy=="null"){
                                FirebaseFirestore.instance.collection(Porder).doc(order.Did).update({

                                  TakenBy : user.email,
                                });
                              } else if(order.TakenBy == user.email){
                                showCustomDialog(order,context);
                              }
                              else{
                                showAlertDialog(context);
                              }
                              },
                              child: Text('Confirm Order'),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),

                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: Text('Loading Order Details'),
              );
            }
          },
        )
    );
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
      content: Text("This order Is already taken! "),
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
  void showCustomDialog(ItemOrderModel order,context) async{
    AlertDialog alert=AlertDialog(
      actions:<Widget>[
        MaterialButton(onPressed:(){
          FirebaseFirestore.instance.collection(Porder).doc(order.Did).delete();
          Navigator.pop(context);
          Navigator.pop(context);
        },
          child:Text('delete'),
        )
      ],
      title: Text(' If you have finished the task please delete it \n and Thank you '),
    );
    await showDialog(context:context ,builder:(context) {
      return alert;
    }
    );
  }
}