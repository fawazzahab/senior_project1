import 'package:cloud_firestore/cloud_firestore.dart';
import 'OrdersModel.dart';
import 'OrderConstance.dart';

class orders {
  final FirebaseFirestore _Firestore = FirebaseFirestore.instance;

  addOrders(orderModel o1) {
    _Firestore.collection(ordersCollections).add(
        {
         orderemail : o1.Oemail,
         orderLocation : o1.OLocation,
         orderType :  o1.OType,
         orderSize : o1.OSize,
         orderPnumber : o1.OPhoneNumber,
         orderNotes  :  o1.ONotes,
        });
  }
  updateorder(orderModel o1)
  {
    _Firestore.collection(ordersCollections).doc(o1.Oid).update(
    {

    });
}

  Stream<QuerySnapshot> loadOrders() {
    return _Firestore.collection(ordersCollections).snapshots();
  }
  DeleteProducts(documentID) {
    return _Firestore.collection(ordersCollections).doc(documentID).delete();
  }

}
