import 'package:flutter/material.dart';
import 'package:jokeapp/jokesData.dart';
import 'package:jokeapp/jokes_screen.dart';
import 'package:jokeapp/preferences.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  JokesData jokesData;
  Preferences preferences;
  Home({Key? key, required this.jokesData, required this.preferences})
      : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          drawerScrimColor: Colors.white,
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            toolbarHeight: 70,
            leading: IconButton(
              onPressed: () {},
              icon: Image.asset(
                "assets/images/hls_logo.jpg",
                fit: BoxFit.fitHeight,
              ),
            ),
            actions: [
              Row(
                children: [
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Handcrafted by",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w300),
                      ),
                      Text(
                        "Jim HLS",
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                    width: 50,
                    height: 50,
                    child: ClipOval(
                      child: Image.asset("assets/images/flower.jpg"),
                    ),
                  ),
                ],
              )
            ],
          ),
          body: JokesSreens(
              jokesData: widget.jokesData, preferences: widget.preferences)),
    );
  }
}
