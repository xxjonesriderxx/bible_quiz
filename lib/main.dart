import 'package:bible_quiz/ui/StartPage.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue, backgroundColor: Colors.white, accentColor: Colors.black, cardColor: Colors.white, cardTheme: CardTheme(color: Colors.white)),
      darkTheme: ThemeData(primarySwatch: Colors.blue, backgroundColor: Colors.black, accentColor: Colors.white, cardColor: Colors.blueGrey, cardTheme: CardTheme(color: Colors.blueGrey)),
      home: StartPage(),
    );
  }
}
