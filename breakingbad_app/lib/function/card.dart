import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget cardGenerator(String leading, String title, BuildContext context) {
  return Card(
    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
    child: ListTile(
      leading: Text(
        leading,
        style: TextStyle(color: Colors.black, fontSize: 20),
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.indigo, fontSize: 20),
      ),
    ),
  );
}
