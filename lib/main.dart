import 'package:flutter/material.dart';
import 'package:jokeapp/home.dart';
import 'package:jokeapp/jokesData.dart';
import 'package:jokeapp/preferences.dart';

void main() {
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  JokesData jokesData = JokesData();
  Preferences preferences = Preferences();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Joke',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Home(jokesData: jokesData, preferences: preferences));
  }
}
