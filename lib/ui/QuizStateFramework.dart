import 'package:bible_quiz/model/ContentType.dart';
import 'package:bible_quiz/model/Question.dart';
import 'package:bible_quiz/ui/CustomCard.dart';
import 'package:bible_quiz/ui/SolutionContainer.dart';
import 'package:flutter/material.dart';

abstract class QuizStateFramework<T extends StatefulWidget> extends State<T> with TickerProviderStateMixin {
  /*
   * logic
   */
  @protected
  ContentType currentType = ContentType.Question;
  @protected
  List<Question> questions = [];
  @protected
  int currentQuestion = 0;
  @protected
  late int numberOfCards;
  @protected
  bool answered = false;

  /*
  ui
   */
  @protected
  late ScaffoldMessengerState scaffoldMessenger;
  @protected
  static const double _heightOfCard = 80;
  @protected
  static const double _paddingLeftRight = 32;
  @protected
  static const double _paddingBetweenQuestionAndAnswer = 8;
  @protected
  List<Color?> colorsOfButtons = [];
  @protected
  Color correctColor = Colors.lightGreen;
  @protected
  Color wrongColor = Colors.red;
  @protected
  Color solutionColor = Colors.lightGreen;
  @protected
  final Duration autoSkipSeconds = Duration(seconds: 10);

  void goToNextQuestion();

  void onAnswerSelected(int index);

  void continueWithQuiz(Question currentQuestion) {
    scaffoldMessenger.removeCurrentSnackBar();
    if (((currentQuestion.solutionNoteHuman?.isNotEmpty ?? false) || (currentQuestion.solutionNoteURL?.isNotEmpty ?? false)) && currentType == ContentType.Question) {
      setState(() {
        currentType = ContentType.Solution;
      });
    } else {
      goToNextQuestion();
    }
  }

  Widget getQuestion() {
    return CustomCard(
      callback: null,
      backgroundColor: Theme.of(context).primaryColor,
      tapAble: false,
      text: questions[currentQuestion].question,
      height: _heightOfCard,
    );
  }

  Widget getAnswers() {
    List<Widget> allAnswers = [];
    for (int i = 0; i < questions[currentQuestion].answers.length; i++) {
      allAnswers.add(CustomCard(
        callback: () => onAnswerSelected(i),
        backgroundColor: colorsOfButtons[i],
        tapAble: true,
        text: questions[currentQuestion].answers[i],
        height: _heightOfCard,
      ));
    }
    return SingleChildScrollView(
      child: Column(
        children: allAnswers,
      ),
    );
  }

  List<Widget> getMainContent(ContentType type) {
    if (type == ContentType.Question) {
      return [
        getQuestion(),
        Padding(padding: EdgeInsets.only(top: _paddingBetweenQuestionAndAnswer)),
        Container(
          //padding: EdgeInsets.only(left: _paddingLeftRight, right: _paddingLeftRight),
          child: Expanded(
            child: getAnswers(),
          ),
        ),
      ];
    } else if (type == ContentType.Solution) {
      return [
        SolutionContainer(
          question: questions[currentQuestion],
          paddingBetweenQuestionAndAnswer: _paddingBetweenQuestionAndAnswer,
        )
      ];
    } else {
      return [];
    }
  }

  void initColors() {
    colorsOfButtons = [];
    for (int i = 0; i < questions[currentQuestion].answers.length; i++) {
      //to use the theme config
      colorsOfButtons.add(null);
    }
  }

  @override
  void dispose() {
    scaffoldMessenger.hideCurrentSnackBar();
    super.dispose();
  }
}
