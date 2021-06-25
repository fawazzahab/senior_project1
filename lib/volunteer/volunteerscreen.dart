import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/volunteer/order_State.dart';
import 'package:flutter_auth/volunteer/volunteer_drawer.dart';
import 'OrdersModel.dart';
import 'VolunteersOrders.dart';
import  'OrderConstance.dart';


import '../constants.dart';

class VolunteerScreen extends StatefulWidget {

  final FirebaseFirestore _Firestore = FirebaseFirestore.instance;
  @override
  _VolunteerScreenState createState() => _VolunteerScreenState();
}

void getName() async{
  User user = FirebaseAuth.instance.currentUser;
  final DocumentSnapshot snap = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
}
class _VolunteerScreenState extends State<VolunteerScreen> {
  final _orders = orders();
  final GlobalKey<FormState> _globalKey=GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    User user;
    orderModel order=ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Volunteer Screen'),
        backgroundColor: appbarcolor,
      ),
      drawer: volunteer_drawer(),
      body: StreamBuilder<QuerySnapshot>(
        stream:_orders.loadOrders(),
        builder: (context,snapshot){
          List <orderModel>LOrders = [];
          if(snapshot.hasData) {
            for (var doc in snapshot.data.docs) {
              var data = doc.data();
              LOrders.add(orderModel(
                Oid: data[orderID],
                Oemail: data[orderemail],
                OPhoneNumber: data[orderPnumber],
                OSize: data[orderSize],
                OType:data[orderType],
                OLocation: data[orderLocation],
                ONotes: data[orderNotes],
                Otakenby : data[ordertakenby],
                image :data[Oimage],
              ));
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: .8,
              ),
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: GestureDetector(
                  onTapUp: (details) async {
                    Navigator.of(context).pushNamed(orderState.routeName,arguments:LOrders[index]);

                  },
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Image(
                          fit: BoxFit.fill,
                          image: NetworkImage(LOrders[index].image),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Opacity(
                          opacity: .6,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 140,
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 13),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(' Phone number :  ${LOrders[index].OPhoneNumber}'),
                                  Text(' For :  ${LOrders[index].OSize}'),
                                  Text('Type :  ${LOrders[index].OType}'),
                                  Text(' Address:${LOrders[index].OLocation}'),
                                  Text('Extra Notes: ${LOrders[index].ONotes}'),
                                  Text('Taken By : ${LOrders[index].Otakenby}'),



                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              itemCount: LOrders.length,

            );
          }
          else{
            return Center(child: Text('loading...'));
          }
        },
      ),
    );
  }
}
