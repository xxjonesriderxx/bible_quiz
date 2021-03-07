import 'package:flutter/cupertino.dart';

//TODO add difficulty
class Question {
  final List<Chapter> chapter;
  final String imagePath;
  final String question;
  final List<String> answers;
  //index of right answer
  final int solution;

  const Question({this.imagePath, @required this.chapter, @required this.question, @required this.answers, @required this.solution, });
}

enum Chapter{
  neuesTestament,
  altesTestament,
}

const List<Question> allQuestions = [
  Question(chapter: const [Chapter.neuesTestament], question: "Das ist eine Frage", answers: const ["falsch", "falsch", "richtig"], solution: 2),
  Question(chapter: const [Chapter.neuesTestament], question: "Das ist eine weitere Frage", answers: const ["falsch", "richtig", "falsch"], solution: 1),
];
