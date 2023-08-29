import 'package:bible_quiz/helper/Constants.dart';
import 'package:bible_quiz/ui/StartPage.dart';
import 'package:flutter/material.dart';
import 'package:games_services/games_services.dart';

void main() async {
  runApp(MyApp());
  GamesServices.signIn();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          cardColor: Colors.white,
          cardTheme: CardTheme(color: Colors.white),
          textTheme: TextTheme(bodyLarge: TextStyle(color: Colors.black), displayLarge: TextStyle(color: Colors.white)),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Constants.uiSelectableColor).copyWith(background: Colors.white)),
      darkTheme: ThemeData(
          cardColor: Colors.blueGrey,
          cardTheme: CardTheme(color: Colors.blueGrey),
          textTheme: TextTheme(bodyLarge: TextStyle(color: Colors.white), displayLarge: TextStyle(color: Colors.white)),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Constants.uiSelectableColor).copyWith(background: Colors.black)),
      home: StartPage(),
    );
  }
}
