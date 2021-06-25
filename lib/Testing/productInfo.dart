import 'package:flutter/material.dart';
import 'package:flutter_auth/Testing/ItemsScreen.dart';
import 'package:flutter_auth/Testing/cartItem.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import 'CartScreen.dart';
import 'productsModel.dart';
import 'constance.dart';

class productInfo extends StatefulWidget {
  static const routeName="/productInfo";
  @override
  _productInfoState createState() => _productInfoState();
}

class _productInfoState extends State<productInfo> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    productsModel product = ModalRoute
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
                image: NetworkImage(product.imageUrl),
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
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => ItemsScreen()));
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.shopping_cart),

                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => CartScreen()));
                      },
                    )
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
                                    product.Pname,
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    product.Pdescription,
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    product.Pprice + "  L.L",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                      children: <Widget>[

                                        ClipOval(
                                          child: Material(
                                            color: kPrimaryColor,
                                            child: GestureDetector(
                                              onTap: add,
                                              child: SizedBox(
                                                child: Icon(Icons.add),
                                                height: 20,
                                                width: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          _quantity.toString(),
                                          style: TextStyle(
                                              fontSize: 40),
                                        ),
                                        ClipOval(
                                          child: Material(
                                            color: kPrimaryColor,
                                            child: GestureDetector(
                                              onTap:
                                              subtract,
                                              child: SizedBox(
                                                child: Icon(Icons.remove),
                                                height: 20,
                                                width: 20,
                                              ),
                                            ),
                                          ),
                                        ),
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
                                addToCart(context, product);

                              },
                              child: Text('add to cart', style: TextStyle(
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

  subtract() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  add() {
    setState(() {
      _quantity++;
    });
  }

  void addToCart(context, product) {
    cartItem Cart = Provider.of<cartItem>(context, listen: false);
    bool exist = false;
    var productsInCart = Cart.products;
    for (var productInCart in productsInCart) {
      if (productInCart.Pname == product.Pname) {
        exist = true;
      }
    }
    if (exist==true) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('you\'ve added this item before'),
      ));
    } else {
      product.Pquantity = _quantity;
      Cart.addProduct(product);
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Added to Cart'),
      ));
    }
  }

}


