import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_auth/constants.dart';
import 'FunctionsModules.dart';

class users {
  final FirebaseFirestore _Firestore = FirebaseFirestore.instance;

  addUser(AddUser p1) {
    _Firestore.collection(UserCollec).add(
        {
          email: p1.Uemail,
          password: p1.Upass,
          role: p1.Uroles
        });
  }



  Stream<QuerySnapshot> loadProducts() {
    return _Firestore.collection(UserCollec).snapshots();
  }

  DeleteProducts(documentID) {
    return _Firestore.collection(UserCollec).doc(documentID).delete();
  }
}