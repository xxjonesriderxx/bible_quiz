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
      theme: ThemeData(primarySwatch: Colors.blue, backgroundColor: Colors.white, cardColor: Colors.white, cardTheme: CardTheme(color: Colors.white), textTheme: TextTheme(bodyText1: TextStyle(color: Colors.black))),
      darkTheme: ThemeData(primarySwatch: Colors.blue, backgroundColor: Colors.black, cardColor: Colors.blueGrey, cardTheme: CardTheme(color: Colors.blueGrey), textTheme: TextTheme(bodyText1: TextStyle(color: Colors.white))),
      home: StartPage(),
    );
  }
}
