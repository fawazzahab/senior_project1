import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Testing/products.dart';
import 'package:flutter_auth/volunteer/ItemOrderModel.dart';
import 'package:flutter_auth/volunteer/OrderDetails.dart';
import 'package:flutter_auth/volunteer/volunteer_drawer.dart';

import '../constants.dart';

class ItemOrderScreen extends StatelessWidget {
  static String routename="ItemOrderScreen";
  final products order=products();
  var DocumentId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('orders'),
          backgroundColor: Colors.purple,

        ),
        drawer: volunteer_drawer(),
        body:
        StreamBuilder<QuerySnapshot>(
          stream: order.loadOrders(),
          builder: (context,snapshot){
            if(!snapshot.hasData){
              return Center(child: Text('no orders'),
              );
            }else{
              List<ItemOrderModel> Iorder=[];
              for (var doc in snapshot.data.docs){
                DocumentId=doc.id;
                var data = doc.data();
                Iorder.add(ItemOrderModel(
                  Did:DocumentId,
                  TotalPrice:data[PorderPrice],
                  donater_Email:data[UserEmail],
                  TakenBy: data[TakenBy],

                ));
              }
              return ListView.builder(
                itemBuilder: (context,index)=>
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, OrderDetails.routeName,arguments:Iorder[index] );
                        },
                        child: Container(
                            height: MediaQuery.of(context).size.height*.2,
                            color:kPrimaryColor2,
                            child:Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children :<Widget>[
                                    Text('Total Price = L.L '+Iorder[index].TotalPrice.toString()),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('donator:'+ Iorder[index].donater_Email,style:TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    )
                                    ),
                                    Text('TakenBy:'+ Iorder[index].TakenBy,style:TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    )
                                    ),
                                  ]
                              ),
                            )
                        ),
                      ),
                    ),
                itemCount: Iorder.length,
              );
            }
          },

        )

    );
  }
}