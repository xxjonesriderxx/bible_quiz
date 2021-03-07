import 'package:bible_quiz/model/Question.dart';
import 'package:flutter/material.dart';

class Quiz extends StatefulWidget{
  static int currentQuestion = 0;
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
  static const double _paddingBetweenQuestionAndAnswer = 32;
  static const double _paddingLeftRight = 32;

  _State({this.numberOfQuestions, this.chapter});

  @override
  void initState() {
    if(chapter !=null){
      allQuestions.forEach((question) {
        if (question.chapter.contains(chapter)) {
          if(numberOfQuestions!=null) {
            if(questions.length<numberOfQuestions) {
              questions.add(question);
            }
          }else{
            questions.add(question);
          }
        }
      });
    }else if(numberOfQuestions!=null){
      allQuestions.forEach((question) {
        if (question.chapter.contains(chapter)) {
          if(questions.length<numberOfQuestions) {
            questions.add(question);
          }
        }
      });
    }else{
      questions.addAll(allQuestions);
    }
    numberOfCards = 1 + questions[Quiz.currentQuestion].answers.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Frage ${Quiz.currentQuestion+1} von ${numberOfQuestions!=null?numberOfQuestions:allQuestions.length}"),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 16),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _getQuestionContent(),
        ),
      ),
    );
  }

  List<Widget> _getQuestionContent(){
    List<Widget> allWidgets = [];
    allWidgets.add(_getQuestion());
    allWidgets.add(Padding(padding: EdgeInsets.only(top: _paddingBetweenQuestionAndAnswer),));
    allWidgets.addAll(_getAnswers());
    return allWidgets;
  }

  Widget _getQuestion(){
    return _getCard(questions[Quiz.currentQuestion].question, Theme.of(context).primaryColor, true);
  }

  List<Widget> _getAnswers(){
    List<Widget> allAnswers = [];
    questions[Quiz.currentQuestion].answers.forEach((answer) { 
      allAnswers.add(_getCard(answer, Colors.blueGrey, false));
    });
    return allAnswers;
  }
  
  Card _getCard(String text, Color color, bool question){
    debugPrint("number of cards: "+numberOfCards.toString());
    return Card(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: question?Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width-_paddingLeftRight,
        padding: EdgeInsets.all(16),
        child: Text(text),
      ):ElevatedButton(
        style: ButtonStyle(),
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width-_paddingLeftRight,
            padding: EdgeInsets.all(16),
            child: Text(text),
          )
      ),
    );
  }

}