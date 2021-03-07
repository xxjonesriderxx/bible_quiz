import 'package:bible_quiz/ui/Quiz.dart';
import 'package:flutter/material.dart';

class StartPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _State();
  }

}

class _State extends State<StartPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Bibelquiz"),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("Quiz starten"),
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Quiz()),
            );
          },
        ),
      ),
    );
  }

}