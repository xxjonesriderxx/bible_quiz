import 'dart:math';

import 'package:flutter/cupertino.dart';

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

  static List<Question> getRandomQuestions() {
    return _shuffle(Question._allQuestions);
  }

  static List<Question> _shuffle(List<Question> list) {
    List<Question> modifiableList = [];
    modifiableList.addAll(list);
    var random = new Random();

    // Go through all elements.
    for (var i = modifiableList.length - 1; i > 0; i--) {
      // Pick a pseudorandom number according to the list length
      var n = random.nextInt(i + 1);

      var temp = modifiableList[i];
      modifiableList[i] = modifiableList[n];
      modifiableList[n] = temp;
    }

    return modifiableList;
  }

  static const List<Question> _allQuestions = [
    Question(
        chapter: const [Chapter.altesTestament],
        question: "Wo verwirrte Gott die Sprache der Menschen?",
        answers: const ["In Jericho", "In Babylon", "In Babel", "In Sinai"],
        solutionIndex: 2,
        difficulty: 1),
    Question(
        chapter: const [Chapter.altesTestament],
        question: "Aus was erschuf Gott die Frau?",
        answers: const ["Jochbein", "Ferse", "Schlüsselbein", "Rippe", "Staub"],
        solutionIndex: 3,
        difficulty: 1),
    Question(
        chapter: const [Chapter.neuesTestament],
        question: "Auf welchem Baum saß Zachäus?",
        answers: const [
          "Maulbeer-Feigenbaum",
          "Olivenbaum",
          "Zedernbaum",
          "Johannisbrotbaum"
        ],
        solutionIndex: 0,
        difficulty: 7),
    Question(
        chapter: const [Chapter.neuesTestament],
        question:
            "Von welchem dieser Personen wird berichtet, dass er auf dem Wasser ging?",
        answers: const ["Petrus", "Johannes", "Lukas", "Matthäus"],
        solutionIndex: 0,
        difficulty: 1),
    Question(
        chapter: const [Chapter.altesTestament],
        question: "Wer bekam die 10 Gebote von Gott?",
        answers: const ["Aaron", "Jakob", "Mose", "Abraham"],
        solutionIndex: 2,
        difficulty: 2),
    Question(
        chapter: const [Chapter.altesTestament],
        question: "Wer schrieb die 10 Gebote?",
        answers: const [
          "Es waren 12 Gebote.",
          "Ein Steinmetz von Mose",
          "Mose selber",
          "Gott"
        ],
        solutionIndex: 3,
        difficulty: 3),
    Question(
        chapter: const [Chapter.neuesTestament],
        question: "Wer war kein Jünger von Jesus?",
        answers: const ["Matthäus", "Johannes", "Lukas", "Philippus"],
        solutionIndex: 2,
        difficulty: 4),
    /*Question(
      chapter: const [Chapter.neuesTestament],
      question: "Seit wann heißt Saulus Paulus?",
      answers: const["Schon immer", "Seit er erblindet ist",],
      solutionIndex: solutionIndex,
      difficulty: 15),

   */
  ];
}

enum Chapter {
  neuesTestament,
  altesTestament,
}
