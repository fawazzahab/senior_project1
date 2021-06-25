import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Testing/cartItem.dart';
import 'package:flutter_auth/Testing/productInfo.dart';
import 'package:flutter_auth/Testing/products.dart';
import 'package:flutter_auth/Testing/products.dart';
import 'package:flutter_auth/Testing/products.dart';
import 'package:flutter_auth/Testing/productsModel.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'constance.dart';

class CartScreen extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  User user=FirebaseAuth.instance
      .currentUser;
  @override
  Widget build(BuildContext context) {

    List<productsModel> products =Provider.of<cartItem>(context).products;
    final double screenheight=MediaQuery.of(context).size.height;
    final double screenwidth=MediaQuery.of(context).size.width;
    return Scaffold(
        appBar:AppBar(
          title:Text("My cart",style:TextStyle(color:Color(0xFF000000))),
          backgroundColor: Color(0xFFFFFFFF),
          leading:GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child:Icon(
              Icons.arrow_back,
              color:Color(0xFF000000),
            ),
          ),
        ),

        body: Column(
            children:<Widget>[
              LayoutBuilder(
                  builder:(context,constraines) {
                    if(products.isNotEmpty) {
                      return
                        ListView.builder(scrollDirection: Axis.vertical,shrinkWrap: true, itemBuilder: (context, index) {


                          return Padding(
                            padding: const EdgeInsets.all(15),
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
                                        onPressed: () { Navigator.pop(context);
                                        Provider.of<cartItem>(context,listen: false).deleteProduct(products[index]);

                                        },
                                      ),
                                      ),
                                      PopupMenuItem( child:FlatButton( child:Row(
                                        children: <Widget>[Text('edit')],
                                      ),
                                        onPressed: () {
                                          var x=products[index];
                                          Navigator.pop(context);
                                          Provider.of<cartItem>(context,listen: false).deleteProduct(products[index]);
                                          Navigator.of(context).pushNamed(productInfo.routeName,arguments:x);
                                        },
                                      ),
                                      ),
                                    ]);

                              },


                              child: Container(
                                height: screenheight * .15,
                                child: Row(
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: screenheight * .15 / 2,
                                      backgroundImage: NetworkImage(
                                          products[index].imageUrl),

                                    ),
                                    Expanded(
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(left: 10),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .center,
                                                children: <Widget>[
                                                  Text(products[index].Pname,
                                                    style: TextStyle(fontSize: 18,
                                                        fontWeight: FontWeight.bold),),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(products[index].Pprice + "L.L",
                                                    style: TextStyle(fontSize: 15,
                                                        fontWeight: FontWeight.bold),),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(right: 20),
                                              child: Text(
                                                products[index].Pquantity.toString(),
                                                style: TextStyle(fontSize: 15,
                                                    fontWeight: FontWeight.bold),),
                                            ),

                                          ]
                                      ),
                                    ),
                                  ],
                                ),
                                color: kPrimaryColor2,
                              ),
                            ),
                          );
                        },
                          itemCount: products.length,
                        );
                    }else
                    {
                      return Center(
                        child:Text("empty cart"),
                      );
                    };}

              ),
              Builder(

                builder:(context)=> ButtonTheme(
                  minWidth:screenwidth,
                  height: screenheight*.10,
                  child: RaisedButton(
                    shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topRight:Radius.circular(10),
                            topLeft: Radius.circular(10))
                    ),
                    onPressed:(){
                      showCustomDialog(products,context);
                    },
                    child:Text("order"),
                    color: kPrimaryColor,
                  ),
                ),
              )
            ]
        )
    );
  }

  void showCustomDialog(List <productsModel>Cproducts,context) async{
    var price=GetTotal(Cproducts);
    AlertDialog alert=AlertDialog(
      actions:<Widget>[
        MaterialButton(onPressed:(){
          products _product = products();
          _product.storeOrders({
            PorderPrice: price,
            UserEmail:user.email,
            TakenBy:"null",
          }
              , Cproducts);
          Scaffold.of(context).showSnackBar(SnackBar(
              content:Text('order successfully')
          ));
          FirebaseFirestore.instance.collection(stats).doc('rYUkgjPpN5eepxOySu4X').update({
            'nb_of_item_orders':FieldValue.increment(1)
          });
          FirebaseFirestore.instance.collection(stats).doc('rYUkgjPpN5eepxOySu4X').update({
            'Money_donated_with_items':FieldValue.increment(price)
          });
          Navigator.pop(context);
        },
          child:Text('confirm order'),
        )
      ],
      title: Text('Total Price =  L.L  '+price.toString()),
    );
    await showDialog(context:context ,builder:(context) {
      return alert;
    }
    );
  }

  int GetTotal(List<productsModel>Cproducts) {
    var price =0;
    for( var product in Cproducts){
      price+=product.Pquantity*int.parse(product.Pprice);
    }
    return price;
  }

}