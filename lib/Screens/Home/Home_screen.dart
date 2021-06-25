
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Home/main_drawer.dart';
import '../../constants.dart';

class HomeScreen extends StatelessWidget{
  static const routeName='HomeScreen';
  @override
  Widget build(BuildContext context) {
    //var assetsImage = new AssetImage('assets/images/donation.jpg');
    //var image = new Image(image: assetsImage, fit: BoxFit.cover);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        backgroundColor: appbarcolor,
      ),
     drawer: MainDrawer(),

        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: new AssetImage('assets/images/Welcome_TooFoodToGo.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: null /* add child content here */,
        ),
    );
  }
}
//image: new AssetImage('assets/images/donation.jpg'),