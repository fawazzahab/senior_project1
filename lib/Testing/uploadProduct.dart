import 'dart:io';
import 'package:flutter_auth/Admin/AdminDivider.dart';
import 'package:flutter_auth/Testing/adminShop.dart';

import 'ItemsScreen.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'products.dart';
import 'productsModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class uploadProduct extends StatelessWidget {
  static const String routeName = "/uploadProduct";
  List<String> categoryList = <String>[
    "cleanning",
    "vegetables",
    "grain",
    "canned food",
  ];
  String _name,_price,_Link,_description,_category;
  final GlobalKey<FormState> _globalKey=GlobalKey<FormState>();
  final _products=products();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(' add items'),
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
                  children: <Widget>[Text('view all item')],
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => adminShop()));
                },
              ),
            ]
        ),



      body:Form(
        key: _globalKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'name '),
              onChanged: (value) {
              _name= value.trim();
                }),

          SizedBox(
            height: 10,
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'price'),
              onChanged: (value) {

                  _price = value.trim();
                }),

        TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'description'),
            onChanged: (value) {

              _description = value.trim();
          }),
          DropdownButton(
            items: categoryList
                .map((value) => DropdownMenuItem(
              child: Text(
                value,
              ),
              value: value,
            ))
                .toList(),
            onChanged: (selectedType) {
              _category = selectedType;

            },
            value: _category,
            isExpanded: false,
            hint: Text('select item category'),
          ),
          SizedBox(
            height: 10,
          ),
         
          SizedBox(
            height: 10,
          ),
          RaisedButton(
            onPressed: (){
      uploadImage();

              },

            child: Text("add photo"),
          ),
          SizedBox(
            height: 10,
          ),
          RaisedButton(
              onPressed: (){
                if(_globalKey.currentState.validate()){
                  _globalKey.currentState.save();

                  _products.addProduct(productsModel(

                      Pname: _name,
                      Pprice: _price,
                      imageUrl:_Link,
                      Pdescription:_description,
                      Pcategories:_category
                  ));
                }
                _globalKey.currentState.reset();
              },
            child: Text("add product"),
          ),
        ],
      ),
      ));
  }
  uploadImage() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile image;


    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted){
      //Select Image
      image = await _picker.getImage(source: ImageSource.gallery);
      var file = File(image.path);

      if (image != null){
        //Upload to Firebase

          String now = DateTime.now().toString() ;
        UploadTask uploadTask =
        _storage.ref().child(image.toString() +now +".jpg").putFile(file);
        var downloadUrl = await (await uploadTask).ref.getDownloadURL();


          _Link = downloadUrl;

      } else {
        print('No Path Received');
      }

    } else {
      print('Grant Permissions and try again');
    }


}




}
