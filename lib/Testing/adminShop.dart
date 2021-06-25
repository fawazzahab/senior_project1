
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Admin/AdminDivider.dart';
import 'package:flutter_auth/Admin/editProduct.dart';
import 'package:flutter_auth/Screens/Home/Home_screen.dart';
import 'package:flutter_auth/Testing/uploadProduct.dart';
import 'constance.dart';
import 'products.dart';
import 'productsModel.dart';


class adminShop extends StatefulWidget {
  static const String routeName = "/adminShop";

  final FirebaseFirestore Firestore= FirebaseFirestore.instance;
  @override
  _adminShopState createState() => _adminShopState();
}

class _adminShopState extends State<adminShop> {
  final _products=products();
   var Pid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('items'),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            FlatButton(
              child: Row(
                children: <Widget>[Text('Go back to options'), Icon(Icons.arrow_back)],
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => adminpath()));
              },
            ),
            FlatButton(
              child: Row(
                children: <Widget>[Text('Add Product'), Icon(Icons.person_add)],
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => uploadProduct()));
              },
            ),
          ]
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:_products.loadProducts(),
        builder: (context,snapshot){
          List <productsModel>Lproducts = [];
          if(snapshot.hasData) {
            for (var doc in snapshot.data.docs) {
              var data = doc.data();
              Pid=doc.id;
              Lproducts.add(productsModel(
                Pname: data[productsName],
                Pprice: data[ProductsPrice],
                imageUrl: data[Link],
                Pdescription:data[Productdescription],
                Pcategories: data[Productcategory],
              ));
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
                    double dx = details.globalPosition.dx;
                    double dy = details.globalPosition.dy;
                    double dx2 = MediaQuery.of(context).size.width - dx;
                    double dy2 = MediaQuery.of(context).size.width - dy;
                    await showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                        items: [
                          PopupMenuItem( child:FlatButton( child:Row(
                            children: <Widget>[Text('delete')],
                          ),
                            onPressed: () {
                            _products.DeleteProducts(Pid);
                            },
                          ),
                          ),
                          PopupMenuItem( child:FlatButton( child:Row(
                            children: <Widget>[Text('edit')],
                          ),
                            onPressed: () {
                              Navigator.pushNamed(context,editProduct.routeName,arguments:Lproducts[index]);
                            },
                          ),
                          ),
                        ]);

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
                                  horizontal: 10, vertical: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    Lproducts[index].Pname,
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text('\$ ${Lproducts[index].Pprice}'+'L.L')
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

