import 'package:flutter/cupertino.dart';
import 'package:flutter_auth/Testing/productsModel.dart';

class cartItem extends ChangeNotifier
{
  List <productsModel> products=[];

  addProduct(productsModel product){
    products.add(product);
    notifyListeners();
  }
  deleteProduct(productsModel product) {
    products.remove(product);
    notifyListeners();
  }
}