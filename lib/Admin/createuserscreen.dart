
import 'FunctionsModules.dart';
import 'package:flutter/material.dart';
import 'Functions.dart';
class CreateUser extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<CreateUser> {
  String _email,_pass,_role;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController roleController = new TextEditingController();
  final _users = users();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
              decoration: InputDecoration(labelText: 'Enter The email'),
              onChanged: (value) {
                _email= value.trim();
              }),
          TextFormField(
              decoration: InputDecoration(labelText: 'Enter The password'),
              onChanged: (value) {
                _pass= value.trim();
              }),
          TextFormField(
              decoration: InputDecoration(labelText: 'Enter The role'),
              onChanged: (value) {
                _role= value.trim();
              }),
          // ignore: deprecated_member_use
          RaisedButton(
              onPressed: (){
                _users.addUser(AddUser(

                    Uemail: _email,
                    Upass: _pass,
                    Uroles:_role
                ));
              },
            child: Text("add User"),
          )
        ],
      ),
    );
  }
}