

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Home/main_drawer.dart';
import 'products.dart';
import 'productsModel.dart';
import 'constance.dart';
import 'productInfo.dart';

class ItemsScreen extends StatefulWidget {
  static const String routeName = "/ItemsScreen";
  final FirebaseFirestore _Firestore= FirebaseFirestore.instance;
  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  TextEditingController _searchController=TextEditingController();
  @override
  void initState(){
  super.initState();
  _searchController.addListener(_onSearchChanged);
  }
  _onSearchChanged(){
    print(_searchController.text);
  }
   final _products=products();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('items'),
          backgroundColor: Colors.purple,

      ),

      drawer: MainDrawer(),
      body: StreamBuilder<QuerySnapshot>(
        stream:_products.loadProducts(),
        builder: (context,snapshot){
          List <productsModel>Lproducts = [];
          if(snapshot.hasData) {
            for (var doc in snapshot.data.docs) {
              var data = doc.data();
              Lproducts.add(productsModel(
                Pname: data[productsName],
                Pprice: data[ProductsPrice],
                imageUrl: data[Link],
                Pdescription:data[Productdescription],
                Pcategories: data[Productcategory],
              )
              );
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .8,
              ),
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: GestureDetector(
                        onTapUp: (details) async {
                           Navigator.of(context).pushNamed(productInfo.routeName,arguments:Lproducts[index]);
                 },
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Image(
                          fit: BoxFit.fill,
                          image: NetworkImage(Lproducts[index].imageUrl),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Opacity(
                          opacity: .6,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 13),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    Lproducts[index].Pname,
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(Lproducts[index].Pprice+'L.L')
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
              itemCount: Lproducts.length,

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