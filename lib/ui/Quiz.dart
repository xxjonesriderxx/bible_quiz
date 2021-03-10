import 'package:bible_quiz/model/Question.dart';
import 'package:bible_quiz/ui/CustomCard.dart';
import 'package:bible_quiz/ui/Result.dart';
import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  final int numberOfQuestions;
  final Chapter chapter;

  const Quiz({Key key, this.numberOfQuestions, this.chapter}) : super(key: key);

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
  int _correctAnswered = 0;
  static const double _paddingBetweenQuestionAndAnswer = 8;
  static const double _paddingLeftRight = 32;
  static const double _heightOfCard = 80;
  bool _answered = false;
  int _chosen;
  int _currentQuestion = 0;

  List<Color> colorsOfButtons = [];
  Color defaultColor = Colors.white;
  Color correctColor = Colors.lightGreen;
  Color wrongColor = Colors.red;
  Color solutionColor = Colors.lightGreen;

  _State({this.numberOfQuestions, this.chapter});

  @override
  void initState() {
    List<Question> randomizedQuestions = Question.getRandomQuestions();
    if (questions.isEmpty) {
      if (chapter != null) {
        randomizedQuestions.forEach((question) {
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
        randomizedQuestions.forEach((question) {
          if (question.chapter.contains(chapter)) {
            if (questions.length < numberOfQuestions) {
              questions.add(question);
            }
          }
        });
      } else {
        questions.addAll(randomizedQuestions);
      }
    }
    initColors();
    numberOfCards = 1 + questions[_currentQuestion].answers.length;
  }

  void initColors() {
    colorsOfButtons = [];
    for (int i = 0; i < questions[_currentQuestion].answers.length; i++) {
      colorsOfButtons.add(defaultColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            "Frage ${_currentQuestion + 1} von ${numberOfQuestions != null ? numberOfQuestions : questions.length}"),
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
                  if (_currentQuestion < questions.length - 1) {
                    _currentQuestion++;
                    initState();
                    setState(() {
                      _chosen = null;
                      _answered = false;
                    });
                  } else {
                    //show result
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Result(
                                correctAnswered: _correctAnswered,
                                totalQuestions: questions.length,
                              )),
                    );
                  }
                });
              },
            )
          : Container(),
    );
  }

  Widget _getQuestion(){
    return CustomCard(
      callback: null,
      backgroundColor: Theme.of(context).primaryColor,
      tapAble: false,
      text: questions[_currentQuestion].question,
      height: _heightOfCard,
    );
  }

  Widget _getAnswers() {
    List<Widget> allAnswers = [];
    for (int i = 0; i < questions[_currentQuestion].answers.length; i++) {
      allAnswers.add(CustomCard(
        callback: () {
          setState(() {
            if (!_answered) {
              if (questions[_currentQuestion].solutionIndex == i) {
                colorsOfButtons[i] = correctColor;
                _correctAnswered++;
              } else {
                colorsOfButtons[i] = wrongColor;
                colorsOfButtons[questions[_currentQuestion].solutionIndex] =
                    solutionColor;
              }
              _chosen = i;
              _answered = true;
            }
          });
        },
        backgroundColor: colorsOfButtons[i],
        tapAble: true,
        text: questions[_currentQuestion].answers[i],
        height: _heightOfCard,
      ));
    }
    return SingleChildScrollView(
      child: Column(
        children: allAnswers,
      ),
    );
  }

}