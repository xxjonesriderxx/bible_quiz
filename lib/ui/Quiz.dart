import 'package:bible_quiz/helper/Constants.dart';
import 'package:bible_quiz/helper/TimerScoreCalculator.dart';
import 'package:bible_quiz/model/ContentType.dart';
import 'package:bible_quiz/model/Question.dart';
import 'package:bible_quiz/ui/QuizStateFramework.dart';
import 'package:bible_quiz/ui/Result.dart';
import 'package:bible_quiz/ui/SnackBarProgressIndicator.dart';
import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  final int numberOfQuestions;
  final Chapter chapter;

  Quiz({Key? key, required this.numberOfQuestions, required this.chapter}) : super(key: key);

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
  final Chapter chapter;
  int _correctAnswered = 0;

  //at the moment not used
  int? _chosen;

  _State({required this.numberOfQuestions, required this.chapter});

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
    TimerScoreCalculator.instance.startCounting();
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return WillPopScope(
      onWillPop: () async {
        scaffoldMessenger.hideCurrentSnackBar();
        TimerScoreCalculator.instance.submitScore();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Frage ${currentQuestion + 1} von ${questions.length}"),
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(questions[currentQuestion].imagePath != null ? "lib/assets/questionImages/" + questions[currentQuestion].imagePath! : "lib/assets/questionmarks.jpg"),
                  fit: BoxFit.cover)),
          padding: EdgeInsets.only(top: 16, left: Constants.rootContainerPadding.left, right: Constants.rootContainerPadding.right),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: getMainContent(currentType),
          ),
        ),
        floatingActionButton: answered
            ? FloatingActionButton(
                child: Icon(Icons.arrow_forward_ios),
                onPressed: () => continueWithQuiz(questions[currentQuestion]),
              )
            : Container(),
      ),
    );
  }

  void onAnswerSelected(int index) {
    Question question = questions[currentQuestion];
    bool rightAnswerSelected = question.solutionIndex == index;
    TimerScoreCalculator.instance.stopCounting(rightAnswerSelected);
    setState(() {
      scaffoldMessenger.showSnackBar(SnackBar(
        backgroundColor: Constants.cardHeadlineColor,
        content: SnackBarProgressIndicator(
          duration: autoSkipSeconds,
          onComplete: () => continueWithQuiz(question),
        ),
        duration: autoSkipSeconds,
      ));
      if (!answered) {
        if (rightAnswerSelected) {
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
        TimerScoreCalculator.instance.startCounting();
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
