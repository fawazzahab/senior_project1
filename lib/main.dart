


import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_auth/Admin/editProduct.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/Testing/cartItem.dart';
import 'package:flutter_auth/volunteer/ItemOrderScreen.dart';
import 'package:flutter_auth/volunteer/OrderDetails.dart';
import 'package:flutter_auth/volunteer/order_State.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Admin/splashscreen.dart';
import 'Profile/TestProfile.dart';
import 'Screens/Home/Home_screen.dart';
import 'Testing/ItemsScreen.dart';
import 'Testing/productInfo.dart';
import 'volunteer/uploadOrder.dart';
import 'constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());

}
class MyApp extends StatelessWidget {
bool isUserlogedin=false;
  @override
  Widget build (BuildContext context) {

    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return MaterialApp(
            home: Scaffold(
            body: Center(
              child:
              Text("loading...."),
            ),
          ),
          );
        } else{
            isUserlogedin=snapshot.data.getBool(Ukeeplog) ?? false ;
        return MultiProvider(
            providers: [
              ChangeNotifierProvider<cartItem>(
                create:(context) => cartItem(),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: isUserlogedin ? SplashScreen.routeName : WelcomeScreen.routName,
              routes: {
                WelcomeScreen.routName:(ctx)=>WelcomeScreen(),
                HomeScreen.routeName: (ctx) => HomeScreen(),
                productInfo.routeName: (ctx) => productInfo(),
                editProduct.routeName: (ctx) => editProduct(),
                ItemOrderScreen.routename:(ctx)=>ItemOrderScreen(),
                OrderDetails.routeName: (ctx) => OrderDetails(),
                SplashScreen.routeName: (ctx) => SplashScreen(),
                orderState.routeName: (ctx) => orderState(),
                SettingsUI.routeName: (ctx) => SettingsUI(),
              },

            ),
          );
        }
      },
    );
  }
}