import 'dart:convert';

import 'package:breakingbad_app/screens/character_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:breakingbad_app/models/character.dart';

class CharacterList extends StatefulWidget {
  static var length;

  const CharacterList({Key? key}) : super(key: key);

  @override
  State<CharacterList> createState() => _CharacterListState();
}

class _CharacterListState extends State<CharacterList> {
  List<Character> CharacterLists = <Character>[];

  final url = "https://www.breakingbadapi.com/api/characters/";

  void CharacterGet() async {
    Response res =
        await get(Uri.parse("https://www.breakingbadapi.com/api/characters/"));
    //print(res.body);
    var data = await jsonDecode(res.body);
    //print(data);

    setState(() {
      for (var i = 0; i < data.length; i++) {
        Character c = Character();
        c.id = data[i]["char_id"];
        c.name = data[i]["name"];
        c.img = data[i]["img"];

        CharacterLists.add(c);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    CharacterGet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Breaking Bad"),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Theme.of(context).backgroundColor,
                  Theme.of(context).scaffoldBackgroundColor
                ],
                tileMode: TileMode.mirror),
          ),
          child: ListView.builder(
              itemCount: CharacterList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => DetailScreen(
                                  id: CharacterLists[index].id,
                                )));
                  },
                  child: ListTile(
                    title: Text(
                      CharacterLists[index].name,
                      style: TextStyle(fontSize: 20.0),
                    ),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(CharacterLists[index].img),
                    ),
                  ),
                );
              }),
        ));
  }
}
