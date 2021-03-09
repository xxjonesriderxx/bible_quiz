import 'package:bible_quiz/model/Question.dart';
import 'package:flutter/material.dart';

class Quiz extends StatefulWidget{
  static int currentQuestion;
  final int numberOfQuestions;
  final Chapter chapter;

  Quiz({Key key, this.numberOfQuestions, this.chapter}) : super(key: key) {
    currentQuestion = 0;
  }

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<Quiz>{
  List<Question> questions = [];
  final int numberOfQuestions;
  final Chapter chapter;
  int numberOfCards;
  static const double _paddingBetweenQuestionAndAnswer = 8;
  static const double _paddingLeftRight = 32;
  static const double _heightOfCard = 80;
  bool _answered = false;
  int _chosen;
  List<Color> colorsOfButtons = [];
  Color defaultColor = Colors.blue;
  Color correctColor = Colors.green;
  Color wrongColor = Colors.red;
  Color solutionColor = Colors.green;

  _State({this.numberOfQuestions, this.chapter});

  @override
  void initState() {
    if (questions.isEmpty) {
      if (chapter != null) {
        allQuestions.forEach((question) {
          if (question.chapter.contains(chapter)) {
            if (numberOfQuestions != null) {
              if (questions.length < numberOfQuestions) {
                questions.add(question);
              }
            } else {
              questions.add(question);
            }
          }
        });
      } else if (numberOfQuestions != null) {
        allQuestions.forEach((question) {
          if (question.chapter.contains(chapter)) {
            if (questions.length < numberOfQuestions) {
              questions.add(question);
            }
          }
        });
      } else {
        questions.addAll(allQuestions);
      }
    }
    initColors();
    numberOfCards = 1 + questions[Quiz.currentQuestion].answers.length;
  }

  void initColors() {
    colorsOfButtons = [];
    for (int i = 0; i < questions[Quiz.currentQuestion].answers.length; i++) {
      colorsOfButtons.add(defaultColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            "Frage ${Quiz.currentQuestion + 1} von ${numberOfQuestions != null ? numberOfQuestions : allQuestions.length}"),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 16),
        width: MediaQuery.of(context).size.width,
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _getQuestion(),
            Padding(
                padding:
                    EdgeInsets.only(top: _paddingBetweenQuestionAndAnswer)),
            Container(
              //padding: EdgeInsets.only(left: _paddingLeftRight, right: _paddingLeftRight),
              child: Expanded(
                child: _getAnswers(),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: _answered
          ? FloatingActionButton(
              child: Icon(Icons.arrow_forward_ios),
              onPressed: () {
                setState(() {
                  if (Quiz.currentQuestion < questions.length - 1) {
                    Quiz.currentQuestion++;
                    initState();
                    setState(() {
                      _chosen = null;
                      _answered = false;
                    });
                  } else {
                    //show result
                  }
                });
              },
            )
          : Container(),
    );
  }

  Widget _getQuestion(){
    return _getCard(questions[Quiz.currentQuestion].question, Theme.of(context).primaryColor, true);
  }

  Widget _getAnswers() {
    List<Widget> allAnswers = [];
    for (int i = 0; i < questions[Quiz.currentQuestion].answers.length; i++) {
      allAnswers.add(_getCard(
          questions[Quiz.currentQuestion].answers[i], Colors.blueGrey, false,
          indexOfQuestion: i));
    }
    return SingleChildScrollView(
      child: Column(
        children: allAnswers,
      ),
    );
  }

  Card _getCard(String text, Color color, bool question,
      {int indexOfQuestion}) {
    debugPrint("number of cards: " + numberOfCards.toString());
    return Card(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: question
          ? Container(
              //question container
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width - _paddingLeftRight,
              height: _heightOfCard,
              padding: EdgeInsets.all(16),
              child: Text(text),
            ):ElevatedButton(
              //answer button
              style: ElevatedButton.styleFrom(
                primary: colorsOfButtons[indexOfQuestion], // background
                onPrimary: Colors.black, // foreground
              ),
              child: Container(
                color: colorsOfButtons[indexOfQuestion],
                alignment: Alignment.center,
                width:
                    MediaQuery.of(context).size.width - _paddingLeftRight * 2,
                height: _heightOfCard,
                padding: EdgeInsets.all(16),
                child: Text(text),
              ),
              onPressed: () {
                setState(() {
                  if (!_answered) {
                    if (questions[Quiz.currentQuestion].solutionIndex ==
                        indexOfQuestion) {
                      colorsOfButtons[indexOfQuestion] = correctColor;
                    } else {
                      colorsOfButtons[indexOfQuestion] = wrongColor;
                      colorsOfButtons[questions[Quiz.currentQuestion]
                          .solutionIndex] = solutionColor;
                    }
                    _chosen = indexOfQuestion;
                    _answered = true;
                  }
                });
              },
            ),
    );
  }
}