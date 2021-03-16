import 'package:bible_quiz/main.dart';
import 'package:bible_quiz/model/Question.dart';
import 'package:bible_quiz/ui/CustomCard.dart';
import 'package:bible_quiz/ui/Result.dart';
import 'package:bible_quiz/ui/SnackBarProgressIndicator.dart';
import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  final int numberOfQuestions;
  final Chapter chapter;

  const Quiz({Key key, this.numberOfQuestions, this.chapter}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _State(numberOfQuestions: numberOfQuestions, chapter: chapter);
  }
}

class _State extends State<Quiz> with TickerProviderStateMixin {
  /*
  for logic
   */
  List<Question> questions = [];
  final int numberOfQuestions;
  final Chapter chapter;
  int numberOfCards;
  int _correctAnswered = 0;
  bool _answered = false;

  //at the moment not used
  int _chosen;
  int _currentQuestion = 0;
  static const Duration _autoSkipSeconds = Duration(seconds: 10);
  ScaffoldMessengerState scaffoldMessenger;

  /*
  for ui
   */
  static const double _paddingBetweenQuestionAndAnswer = 8;
  static const double _paddingLeftRight = 32;
  static const double _heightOfCard = 80;
  List<Color> colorsOfButtons = [];
  Color correctColor = Colors.lightGreen;
  Color wrongColor = Colors.red;
  Color solutionColor = Colors.lightGreen;

  _State({this.numberOfQuestions, this.chapter});

  @override
  void initState() {
    if (questions.isEmpty) {
      questions = Question.getRandomQuestions(numberOfQuestions: numberOfQuestions, chapter: chapter);
    }
    initColors();
    numberOfCards = 1 + questions[_currentQuestion].answers.length;
  }

  void initColors() {
    colorsOfButtons = [];
    for (int i = 0; i < questions[_currentQuestion].answers.length; i++) {
      //to use the theme config
      colorsOfButtons.add(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Frage ${_currentQuestion + 1} von ${questions.length}"),
      ),
      body: Container(
        color: themeData.backgroundColor,
        padding: EdgeInsets.only(top: 16, left: rootContainerPadding.left, right: rootContainerPadding.right),
        width: MediaQuery.of(context).size.width,
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _getQuestion(),
            Padding(padding: EdgeInsets.only(top: _paddingBetweenQuestionAndAnswer)),
            Container(
              //padding: EdgeInsets.only(left: _paddingLeftRight, right: _paddingLeftRight),
              child: Expanded(
                child: _getAnswers(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _answered
          ? FloatingActionButton(
              child: Icon(Icons.arrow_forward_ios),
              onPressed: _goToNextQuestion,
            )
          : Container(),
    );
  }

  void _goToNextQuestion() {
    scaffoldMessenger.removeCurrentSnackBar();
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
  }

  Widget _getQuestion() {
    return CustomCard(
      callback: null,
      backgroundColor: Theme.of(context).primaryColor,
      tapAble: false,
      text: questions[_currentQuestion].question,
      height: _heightOfCard,
    );
  }

  @override
  void dispose() {
    scaffoldMessenger.hideCurrentSnackBar();
    super.dispose();
  }

  Widget _getAnswers() {
    List<Widget> allAnswers = [];
    for (int i = 0; i < questions[_currentQuestion].answers.length; i++) {
      allAnswers.add(CustomCard(
        callback: () {
          setState(() {
            scaffoldMessenger.showSnackBar(SnackBar(
              content: SnackBarProgressIndicator(
                duration: _autoSkipSeconds,
                onComplete: _goToNextQuestion,
              ),
              duration: _autoSkipSeconds,
            ));
            if (!_answered) {
              if (questions[_currentQuestion].solutionIndex == i) {
                colorsOfButtons[i] = correctColor;
                _correctAnswered++;
              } else {
                colorsOfButtons[i] = wrongColor;
                colorsOfButtons[questions[_currentQuestion].solutionIndex] = solutionColor;
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