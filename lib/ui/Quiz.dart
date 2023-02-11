import 'package:bible_quiz/main.dart';
import 'package:bible_quiz/model/ContentType.dart';
import 'package:bible_quiz/model/Question.dart';
import 'package:bible_quiz/ui/QuizStateFramework.dart';
import 'package:bible_quiz/ui/Result.dart';
import 'package:bible_quiz/ui/SnackBarProgressIndicator.dart';
import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  final int numberOfQuestions;
  final Chapter? chapter;

  Quiz({Key? key, required this.numberOfQuestions, this.chapter}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _State(numberOfQuestions: numberOfQuestions, chapter: chapter);
  }
}

class _State extends QuizStateFramework<Quiz> {
  /*
  for logic
   */
  final int numberOfQuestions;
  final Chapter? chapter;
  int _correctAnswered = 0;

  //at the moment not used
  int? _chosen;

  _State({required this.numberOfQuestions, this.chapter});

  @override
  void initState() {
    if (questions.isEmpty) {
      questions = Question.getRandomQuestions(numberOfQuestions: numberOfQuestions, chapter: chapter);
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
        title: Text("Frage ${currentQuestion + 1} von ${questions.length}"),
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

  void onAnswerSelected(int index) {
    Question question = questions[currentQuestion];
    setState(() {
      scaffoldMessenger.showSnackBar(SnackBar(
        content: SnackBarProgressIndicator(
          duration: autoSkipSeconds,
          onComplete: () => continueWithQuiz(question),
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
        }
        _chosen = index;
        answered = true;
      }
    });
  }

  void goToNextQuestion() {
    scaffoldMessenger.removeCurrentSnackBar();
    setState(() {
      if (currentQuestion < questions.length - 1) {
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
          MaterialPageRoute(
              builder: (context) => Result(
                correctAnswered: _correctAnswered,
                totalQuestions: questions.length,
              )),
        );
      }
    });
  }

}