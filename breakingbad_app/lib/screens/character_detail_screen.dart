import 'dart:convert';

import 'package:breakingbad_app/function/card.dart';
import 'package:breakingbad_app/models/character.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:image_fade/image_fade.dart';

class DetailScreen extends StatefulWidget {
  final int id;
  DetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Character c = new Character();
  bool loading = false;
  void charactergets() async {
    //print(widget.id);

    Response res = await get(Uri.parse(
        "https://www.breakingbadapi.com/api/characters/ ${widget.id}"));

    var data = await jsonDecode(res.body);

    setState(() {
      c.name = data[0]["name"];
      c.actor = data[0]["portrayed"];
      c.img = data[0]["img"];
      c.nickname = data[0]["nickname"];
      c.situation = data[0]["status"];
      c.birthday = data[0]["birthday"];
      loading = true;
    });
  }

  @override
  void initState() {
    super.initState();
    charactergets();
  }

  @override
  Widget build(BuildContext context) {
    return loading == false
        ? const Scaffold(
            body: Center(
              child: SpinKitPulse(
                color: Colors.black,
                size: 150,
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.indigo,
              title: AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText(c.name,
                      textStyle: TextStyle(
                          fontSize: 25.0, fontStyle: FontStyle.italic),
                      speed: Duration(milliseconds: 100)),
                ],
                repeatForever: true,
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: ImageFade(
                    image: NetworkImage(c.img),
                    height: 200,
                    alignment: Alignment.center,
                    fit: BoxFit.cover,
                    fadeDuration: Duration(seconds: 2),
                  ),
                ),
                SizedBox(
                  height: 10,
                  width: 250,
                  child: Divider(
                    color: Colors.indigo,
                  ),
                ),
                cardGenerator("Name", c.name, context),
                cardGenerator("Actor", c.actor, context),
                cardGenerator("Nickname", c.nickname, context),
                cardGenerator("Birthday", c.birthday, context),
                cardGenerator("Situation", c.situation, context),
              ],
            ),
          );
  }
}
