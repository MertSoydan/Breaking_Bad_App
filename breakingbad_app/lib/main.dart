import 'package:breakingbad_app/models/character.dart';
import 'package:breakingbad_app/screens/character_list_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Breaking Bad App",
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.indigoAccent,
        secondaryHeaderColor: Colors.red,
        backgroundColor: Colors.white,
      ),
      home: CharacterList(),
    );
  }
}
