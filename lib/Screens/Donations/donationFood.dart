import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_auth/Admin/Functions.dart';
import 'package:flutter_auth/Screens/Donations/DonationHome.dart';
import 'package:flutter_auth/Screens/Home/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/volunteer/VolunteersOrders.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../constants.dart';

// ignore: camel_case_types
class foodDonationScreen extends StatefulWidget {

  @override
  _foodDonationScreenState createState() => _foodDonationScreenState();
}


// ignore: camel_case_types
class _foodDonationScreenState extends State<foodDonationScreen> {
  final GlobalKey<FormState> _globalKey=GlobalKey<FormState>();
  var _foodType,selectedPerson,phone,size,location,notes,_link;
  String takenby = 'Null';
  List<String> _foodTypes=<String>[
    "Full Meal",
    "Drinks",
    "Vegetables or Fruit",
    "Bakery",
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar:AppBar(
          title:Text ('food donation'),
            backgroundColor: appbarcolor,
        ),
        drawer: MainDrawer(),
        body: Stack(
              children:<Widget>[

                Container(
                    decoration:BoxDecoration(
                        gradient:LinearGradient(
                            colors:[
                              Colors.purple[300],
                              Colors.grey[400],
                            ]
                        )
                    )
                ),

              Center(
                child:Card(
                    shape:RoundedRectangleBorder(
                      borderRadius:BorderRadius.circular(10.0),
                    ),
                    child:Container(
                        height:450,
                        width:400,
                        padding: EdgeInsets.all(16),

                        child:Form(
//
                            child:SingleChildScrollView(
                              child: Column (
                                children:<Widget> [
                                  TextFormField(

                                      decoration:InputDecoration(labelText:'Phone Number*'),
                                      keyboardType: TextInputType.number,
                                      validator: (value){
                                        if(value.isEmpty){return "Can't be empty";}
                                        return null;
                                      },
                                      onChanged: (value){
                                        phone=value.trim();
                                      }
                                  ),
                                  TextFormField(
                                      decoration:InputDecoration(labelText:'For how many person is the meal'),
                                      validator: (value){
                                        if(value.isEmpty){return "Can't be empty";}
                                        return null;
                                      },
                                      onChanged: (value){
                                        size=value.trim();
                                      }
                                  ),
                                  TextFormField(

                                      decoration:InputDecoration(labelText:'Address'),

                                      validator: (value){
                                        if(value.isEmpty){return "Can't be empty";}
                                        return null;
                                      },
                                      onChanged: (value){
                                        location=value.trim();
                                      }
                                  ),

                                  DropdownButton(
                                    items: _foodTypes.map((value)=>DropdownMenuItem(
                                      child:Text(
                                        value,
                                      ),
                                      value:value,
                                    )).toList(),
                                    onChanged: (selectedType){
                                      setState((){
                                        _foodType=selectedType;
                                      }
                                      );
                                    },
                                    value:_foodType,
                                    isExpanded: false,
                                    hint: Text('select food type'),
                                  ),
                                  RaisedButton(
                                    onPressed: (){
                                      uploadImage();
                                    },

                                    child: Text("add photo"),
                                  ),
                                  //another drop down
                                  TextFormField(
                                      decoration:InputDecoration(labelText:'Notes...'),
                                      onChanged: (value){
                                        notes=value.trim();
                                      }
                                  ),
                                  RoundedButton(
                                    text: "Submit",
                                    press: () async{
                                      try {
                                        User user = FirebaseAuth.instance.currentUser;
                                        DocumentReference ref = FirebaseFirestore.instance.collection("orders").doc();

                                        ref.set({
                                          'email':user.email,
                                          'uid': ref.id,
                                          'Phone Number': phone,
                                          'Size': size,
                                          'Location': location,
                                          'Type': _foodType,
                                          'Notes': notes,
                                          'imageUrl':_link,
                                          'Taken By' : takenby,
                                        });


                                        FirebaseFirestore.instance.collection(stats).doc('rYUkgjPpN5eepxOySu4X').update({
                                            'number_of_order':FieldValue.increment(1),
                                        });
                                      }
                                      finally
                                          {
                                            Navigator.of(context).pushReplacement(
                                                MaterialPageRoute(builder: (context) => DonationHome()));
                                          }
                                    },
                                  ),
                                ],
                              ),
                            )
                        )
                    )
                ),
              )
            ]
        )
    );
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
      image = await _picker.getImage(source: ImageSource.camera);
      var file = File(image.path);

      if (image != null){
        //Upload to Firebase

        String now = DateTime.now().toString() ;
        UploadTask uploadTask =
        _storage.ref().child(image.toString() +now +".jpg").putFile(file);
        var downloadUrl = await (await uploadTask).ref.getDownloadURL();


        _link = downloadUrl;

      } else {
        print('No Path Received');
      }

    } else {
      print('Grant Permissions and try again');
    }


  }
}
