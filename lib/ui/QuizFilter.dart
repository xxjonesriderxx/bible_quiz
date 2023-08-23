import 'package:bible_quiz/model/Question.dart';
import 'package:bible_quiz/ui/CustomCard.dart';
import 'package:bible_quiz/ui/Quiz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../helper/Constants.dart';
import '../helper/DeviceTypeHelper.dart';

class QuizFilter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<QuizFilter> {
  Chapter selectedChapter = Chapter.alles;
  int numberOfQuestions = 8;

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    Orientation currentOrientation = MediaQuery.of(context).orientation;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Fragen filtern"),
        ),
        body: Container(
          padding: DeviceTypeHelper.getRootContainerPadding(context),
          width: MediaQuery.of(context).size.width,
          //color: themeData.colorScheme.background,
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage("lib/assets/questionmarks.jpg"), fit: currentOrientation == Orientation.landscape ? BoxFit.fitWidth : BoxFit.fitHeight)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 16),
                    width: MediaQuery.of(context).size.width * 0.4,
                    /*child: Text(
                      "Themenbereich",
                      style: TextStyle(color: themeData.textTheme.bodyLarge?.color),
                    ),*/
                    child: CustomCard(
                      height: 50,
                      tapAble: false,
                      text: "Themenbereich",
                      backgroundColor: Constants.uiSelectableColor,
                    ),
                  ),
                  Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Constants.uiSelectableColor, border: Border.all()),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<Chapter>(
                        dropdownColor: Constants.uiSelectableColor,
                        value: selectedChapter,
                        items: Chapter.values.where((Chapter value) {
                          int count = Question.getCountOfQuestions(value);
                          return count >= 16 || kDebugMode;
                        }).map((Chapter value) {
                          int count = Question.getCountOfQuestions(value);
                          return new DropdownMenuItem<Chapter>(
                            value: value,
                            child: new Text(
                              (Question.chapterMap[value] ?? "") + " ($count)",
                              style: TextStyle(color: themeData.textTheme.displayLarge?.color),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedChapter = value!;
                            int count = Question.getCountOfQuestions(value);
                            if (count < 8) {
                              numberOfQuestions = Constants.int64MaxValue;
                            } else {
                              numberOfQuestions = 8;
                            }
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
                    width: MediaQuery.of(context).size.width * 0.4,
                    /*child: Text(
                      "Anzahl der Fragen",
                      style: TextStyle(color: themeData.textTheme.bodyLarge?.color),
                    ),*/
                    child: CustomCard(
                      height: 50,
                      tapAble: false,
                      text: "Anzahl der Fragen",
                      backgroundColor: Constants.uiSelectableColor,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Constants.uiSelectableColor, border: Border.all()),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          dropdownColor: Constants.uiSelectableColor,
                          value: numberOfQuestions == Constants.int64MaxValue ? 'Alle' : numberOfQuestions.toString(),
                          items: <String>['8', '16', '24', '32', '40', 'Alle'].where((element) {
                            if (element == 'Alle') {
                              return kDebugMode;
                            }
                            return int.parse(element) <= Question.getCountOfQuestions(selectedChapter);
                          }).map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(
                                value,
                                style: TextStyle(color: themeData.textTheme.displayLarge?.color),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              if (value == "Alle") {
                                numberOfQuestions = Constants.int64MaxValue;
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
                backgroundColor: Constants.uiSelectableColor,
              ),
            ],
          ),
        ));
  }
}
