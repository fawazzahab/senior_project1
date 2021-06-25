import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Admin/stats_services/statService.dart';
import 'package:flutter_auth/Admin/stats_services/statsModel.dart';
import 'package:flutter_auth/Screens/Home/main_drawer.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/constants.dart';

import '../constants.dart';


class statsScreen extends StatefulWidget {
  @override
  _statsScreenState createState() => _statsScreenState();
}

class _statsScreenState extends State<statsScreen> {
  @override
  Widget build(BuildContext context) {
    final _stats=statService();
    return Scaffold(
      appBar: AppBar(
        title: Text('items'),
        backgroundColor: Colors.purple,
      ),

        body: StreamBuilder<QuerySnapshot>(
        stream:_stats.loadstats(),
        builder: (context,snapshot){
          List <statsModel>adminStats = [];
          if(snapshot.hasData) {
            for (var doc in snapshot.data.docs) {
              var data = doc.data();
              adminStats.add(statsModel(

                nb_users: data[users],
                numberb_of_order: data[order],
                money_donated: data[money],
                Money_donated_with_items:data[IMoney],
                  nb_of_item_orders:data[IOrder],

              )
              );
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: .8,
              ),
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        child: Opacity(
                          opacity: 1,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 13),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Text(
                                        'number of orders done:  '+
                                        adminStats[index].numberb_of_order.toString(),
                                        style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Text(
                                        'number of Item order done:  '+
                                            adminStats[index].nb_of_item_orders.toString(),
                                        style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),



                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Text(
                                          'money donated:   '+
                                          adminStats[index].money_donated.toString()+'L.L'),
                                    ),
                                  ),


                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Text(
                                        'number of user who logged in :'+
                                        adminStats[index].nb_users.toString(),
                                        style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Text(
                                        'Money donated with Item: L.L  '+
                                            adminStats[index].Money_donated_with_items.toString(),
                                        style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ),
                      )
                    ],
                  ),
                ),

              itemCount: adminStats.length,

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