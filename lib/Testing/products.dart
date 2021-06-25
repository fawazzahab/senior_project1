import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth/constants.dart';
import 'productsModel.dart';
import 'constance.dart';
// ignore: camel_case_types
class products {
  final FirebaseFirestore _Firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  User user;
  addProduct(productsModel p1) {
    _Firestore.collection(prodcutsCollenction).add(
        {
          Link: p1.imageUrl,
          productsName: p1.Pname,
          ProductsPrice: p1.Pprice,
          Productdescription:p1.Pdescription,
          ProductsPrice:p1.Pprice
        });
  }



  Stream<QuerySnapshot> loadProducts() {
    return _Firestore.collection(prodcutsCollenction).snapshots();
  }

  DeleteProducts(documentID) {
    return _Firestore.collection(prodcutsCollenction).doc(documentID).delete();
  }
  Stream<QuerySnapshot> loadOrders() {
    return _Firestore.collection(Porder).snapshots();
  }
  Stream<QuerySnapshot> loadOrdersDetails(documentID) {
    return _Firestore.collection(Porder).doc(documentID).collection(PorderDetails).snapshots();
  }

storeOrders(data,List<productsModel> products){
   var documentRef= _Firestore.collection(Porder).doc();
  documentRef.set(data);
  for(var product in products){

    documentRef.collection(PorderDetails).doc().set({
      Link: product.imageUrl,
      productsName: product.Pname,
      ProductsPrice: product.Pprice,
      Pquantity:product.Pquantity,
      Productcategory:product.Pcategories
    }
    );
  }
  }


}