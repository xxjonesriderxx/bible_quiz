import 'package:bible_quiz/ui/StartPage.dart';
import 'package:flutter/material.dart';

const EdgeInsets rootContainerPadding = EdgeInsets.only(left: 8, right: 8);

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          cardColor: Colors.white,
          cardTheme: CardTheme(color: Colors.white),
          textTheme: TextTheme(bodyLarge: TextStyle(color: Colors.black)),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(background: Colors.white)),
      darkTheme: ThemeData(
          cardColor: Colors.blueGrey,
          cardTheme: CardTheme(color: Colors.blueGrey),
          textTheme: TextTheme(bodyLarge: TextStyle(color: Colors.white)),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(background: Colors.black)),
      home: StartPage(),
    );
  }
}
