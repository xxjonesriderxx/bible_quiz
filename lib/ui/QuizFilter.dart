import 'package:bible_quiz/main.dart';
import 'package:bible_quiz/model/Question.dart';
import 'package:bible_quiz/ui/CustomCard.dart';
import 'package:bible_quiz/ui/Quiz.dart';
import 'package:flutter/material.dart';

class QuizFilter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<QuizFilter> {
  Chapter? selectedChapter;
  int numberOfQuestions = 24;
  static const int int64MaxValue = 9223372036854775807;

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Fragen filtern"),
        ),
        body: Container(
          padding: rootContainerPadding,
          width: MediaQuery.of(context).size.width,
          color: themeData.colorScheme.background,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 16),
                    width: MediaQuery.of(context).size.width / 2,
                    child: Text(
                      "Themenbereich",
                      style: TextStyle(color: themeData.textTheme.bodyLarge?.color),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Colors.blue, border: Border.all()),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<Chapter>(
                        dropdownColor: themeData.colorScheme.background,
                        value: selectedChapter,
                        items: Chapter.values.map((Chapter value) {
                          return new DropdownMenuItem<Chapter>(
                            value: value,
                            child: new Text(
                              Question.chapterMap[value] ?? "",
                              style: TextStyle(color: themeData.textTheme.bodyLarge?.color),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedChapter = value!;
                          });
                        },
                      ),
                    ),
                  )),
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 8)),
              Row(
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 16),
                    width: MediaQuery.of(context).size.width / 2,
                    child: Text(
                      "Anzahl der Fragen",
                      style: TextStyle(color: themeData.textTheme.bodyLarge?.color),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Colors.blue, border: Border.all()),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          dropdownColor: themeData.colorScheme.background,
                          value: numberOfQuestions == int64MaxValue ? 'Alle' : numberOfQuestions.toString(),
                          items: <String>['16', '24', '32', '48', '64', 'Alle'].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(
                                value,
                                style: TextStyle(color: themeData.textTheme.bodyLarge?.color),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              if (value == "Alle") {
                                numberOfQuestions = int64MaxValue;
                              } else {
                                numberOfQuestions = int.tryParse(value!)!;
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 16)),
              CustomCard(
                tapAble: true,
                callback: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Quiz(
                              chapter: selectedChapter,
                              numberOfQuestions: numberOfQuestions,
                            )),
                  );
                },
                text: "Quiz starten",
                height: 80,
                backgroundColor: Colors.blue,
              ),
            ],
          ),
        ));
  }
}
