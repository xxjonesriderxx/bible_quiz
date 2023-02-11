import 'package:bible_quiz/main.dart';
import 'package:bible_quiz/model/ContentType.dart';
import 'package:bible_quiz/model/Question.dart';
import 'package:bible_quiz/ui/BiblionaireResult.dart';
import 'package:bible_quiz/ui/QuizStateFramework.dart';
import 'package:bible_quiz/ui/SnackBarProgressIndicator.dart';
import 'package:flutter/material.dart';

class BiblionaireMode extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends QuizStateFramework<BiblionaireMode> {
  /*
  for logic
   */
  int _correctAnswered = 0;
  static const List<String> BiblionaireQuestions = [
    "50 Euro",
    "100 Euro",
    "200 Euro",
    "300 Euro",
    "500 Euro",
    "1.000 Euro",
    "2.000 Euro",
    "4.000 Euro",
    "8.000 Euro",
    "16.000 Euro",
    "32.000 Euro",
    "64.000 Euro",
    "125.000 Euro",
    "500.000 Euro",
    "1.000.000 Euro"
  ];
  bool _failed = false;

  //at the moment not used
  int? _chosen;

  _State();

  @override
  void initState() {
    if (questions.isEmpty) {
      questions = Question.getRandomQuestions(numberOfQuestions: 15, biblionaireMode: true);
    }
    initColors();
    numberOfCards = 1 + questions[currentQuestion].answers.length;
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("${BiblionaireQuestions[currentQuestion]} Frage"),
      ),
      body: Container(
        color: questions[currentQuestion].imagePath == null ? themeData.colorScheme.background : null,
        decoration: questions[currentQuestion].imagePath != null ? BoxDecoration(image: DecorationImage(image: AssetImage("lib/assets/questionImages/" + questions[currentQuestion].imagePath!), fit: BoxFit.cover)) : null,
        padding: EdgeInsets.only(top: 16, left: rootContainerPadding.left, right: rootContainerPadding.right),
        width: MediaQuery.of(context).size.width,
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: getMainContent(currentType),
        ),
      ),
      floatingActionButton: answered
          ? FloatingActionButton(
              child: Icon(Icons.arrow_forward_ios),
              onPressed: () => continueWithQuiz(questions[currentQuestion]),
            )
          : Container(),
    );
  }

  void goToNextQuestion() {
    scaffoldMessenger.removeCurrentSnackBar();
    setState(() {
      if (currentQuestion < questions.length - 1 && !_failed) {
        currentQuestion++;
        initState();
        setState(() {
          _chosen = null;
          answered = false;
          currentType = ContentType.Question;
        });
      } else {
        //show result
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BiblionaireResult(correctAnswered: _correctAnswered, failed: _failed)),
        );
      }
    });
  }

  @override
  void onAnswerSelected(int index) {
    Question question = questions[currentQuestion];
    setState(() {
      scaffoldMessenger.showSnackBar(SnackBar(
        content: SnackBarProgressIndicator(
          duration: autoSkipSeconds,
          onComplete: goToNextQuestion,
        ),
        duration: autoSkipSeconds,
      ));
      if (!answered) {
        if (question.solutionIndex == index) {
          colorsOfButtons[index] = correctColor;
          _correctAnswered++;
        } else {
          colorsOfButtons[index] = wrongColor;
          colorsOfButtons[question.solutionIndex] = solutionColor;
          _failed = true;
        }
        _chosen = index;
        answered = true;
      }
    });
  }
}
