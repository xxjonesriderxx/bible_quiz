import 'package:flutter/cupertino.dart';

//TODO add difficulty
class Question {
  final List<Chapter> chapter;
  final String imagePath;
  final String question;
  final List<String> answers;

  //index of right answer
  final int solutionIndex;

  //number from 1 to 15
  final int difficulty;

  const Question(
      {this.imagePath,
      @required this.chapter,
      @required this.question,
      @required this.answers,
      @required this.solutionIndex,
      @required this.difficulty});
}

enum Chapter{
  neuesTestament,
  altesTestament,
}

const List<Question> allQuestions = [
  Question(
      chapter: const [Chapter.neuesTestament],
      question: "Das ist eine Frage",
      answers: const [
        "falsch",
        "falsch",
        "richtig",
        "test1",
        "test2",
        "test3",
        "test4"
      ],
      solutionIndex: 2,
      difficulty: 1),
  Question(
      chapter: const [Chapter.neuesTestament],
      question: "Das ist eine weitere Frage",
      answers: const ["falsch", "richtig", "falsch"],
      solutionIndex: 1,
      difficulty: 3),
];
