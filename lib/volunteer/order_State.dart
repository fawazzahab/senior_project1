import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/volunteer/OrdersModel.dart';
import 'package:flutter_auth/volunteer/OrderConstance.dart';

import '../constants.dart';
import 'ItemOrderModel.dart';

class orderState extends StatefulWidget {
  final String uid;
  final bool takenbot =  false;

  orderState({Key key, this.uid}) : super(key: key);
  static const routeName="/orderState";

  @override
  _orderStateState createState() => _orderStateState();
}

class _orderStateState extends State<orderState> {
  final auth = FirebaseAuth.instance;
  User user;
  @override
  Widget build(BuildContext context) {
    user = auth.currentUser;
    orderModel order = ModalRoute
        .of(context)
        .settings
        .arguments;
    return Scaffold(
      body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Image(
                fit: BoxFit.fill,
                image: NetworkImage(order.image),
              ),

            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * .1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),

                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                child: Column(
                  children: [
                    Opacity(
                      child: Container(
                          color: Colors.white,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.3,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    order.Oemail,
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    order.OLocation,
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    order.Otakenby,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    order.ONotes,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    order.OType,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                      children: <Widget>[
                                      ]
                                  ),


                                ]
                            ),
                          )

                      ),
                      opacity: .5,
                    ),

                    ButtonTheme(
                      minWidth: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.12,

                      child:
                      Builder(
                        builder: (context) =>
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20))
                              ),
                              color: Colors.purple[400],
                              onPressed: () {
                                if(order.Otakenby=="Null"){

                                  FirebaseFirestore.instance.collection(ordersCollections).doc(order.Oid).update({
                                orderemail :order.Oemail,
                                orderPnumber : order.OPhoneNumber,
                                orderSize: order.OSize,
                                orderLocation : order.OLocation,
                                orderType : order.OType,
                                orderNotes : order.ONotes,
                                Oimage :order.image,
                                ordertakenby : user.email,
                              });
                                  takenbot : true;
                                Navigator.of(context).pop();
                             }
                                else if(order.Otakenby == user.email){
                                  showCustomDialog(order,context);
                                }
                                else{
                                  showAlertDialog(context);
                                }
                                },
                              child: Text('confirm ', style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),),
                            ),
                      ),
                    ),
                  ],
                )
            )
          ]
      ),
    );
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
void showCustomDialog(orderModel order,context) async{
  AlertDialog alert=AlertDialog(
    actions:<Widget>[
      MaterialButton(onPressed:(){
        FirebaseFirestore.instance.collection("orders").doc(order.Oid).delete();
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





