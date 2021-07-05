import 'package:bible_quiz/main.dart';
import 'package:bible_quiz/ui/CustomCard.dart';
import 'package:bible_quiz/ui/BiblionaireMode.dart';
import 'package:bible_quiz/ui/QuizFilter.dart';
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
    var themeData = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Bibelquiz"),
        ),
        body: Container(
          padding: rootContainerPadding,
          color: themeData.backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomCard(
                tapAble: true,
                callback: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QuizFilter()),
                  );
                },
                text: "Quiz starten",
                height: 80,
                backgroundColor: Colors.blue,
              ),
              CustomCard(
                tapAble: true,
                callback: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BiblionaireMode()),
                  );
                },
                text: "Wer wird Biblionär",
                height: 80,
                backgroundColor: Colors.blue,
              ),
            ],
          ),
        ));
  }
}