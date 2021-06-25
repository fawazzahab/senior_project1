import 'package:flutter_auth/volunteer/OrderConstance.dart';

class orderModel{
  final String OLocation;
  final String ONotes;
  final String OPhoneNumber;
  final String OSize;
  final String OType;
  final String Oemail;
  final String Otakenby;
  final String Oid;
  final String image;

  orderModel({
    this.image,
    this.Oid ,
    this.Otakenby,
    this.OLocation,
    this.ONotes,
    this.OPhoneNumber,
    this.OSize,
    this.OType,
    this.Oemail,
});
}