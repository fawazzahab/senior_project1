import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
AppBar buildAppBar(BuildContext context) {
  final icon = CupertinoIcons.moon_stars;
  const kPrimaryColor = Color(0xFF6F35A5);
  return AppBar(
    leading: BackButton(),
    backgroundColor: kPrimaryColor,
    elevation: 0,
    actions: [
      IconButton(
        icon: Icon(icon),
        onPressed: () {},
      ),
    ],
  );
}
