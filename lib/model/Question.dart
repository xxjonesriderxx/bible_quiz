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

  //these are no solution tips but hints that explain the solution based on the Bible passage after answering
  final String solutionNoteHuman;
  final String solutionNoteURL;

  //tip for the "Who Wants to be a Millionaire"-mode
  final String tip;

  const Question({this.imagePath, @required this.chapter, @required this.question, @required this.answers, @required this.solutionIndex, @required this.difficulty, this.solutionNoteHuman, this.solutionNoteURL, this.tip});

  static List<Question> getRandomQuestions({int numberOfQuestions, Chapter chapter, bool millionaireMode = false}) {
    List<Question> questions = [];
    if (!millionaireMode) {
      Question._allQuestions.forEach((question) {
        if ((numberOfQuestions != null ? questions.length < numberOfQuestions : true) && (chapter != null ? question.chapter.contains(chapter) : true)) {
          questions.add(question);
        }
      });
      return _shuffle(questions);
    } else {
      var random = new Random();
      for (int difficulty = 1; difficulty <= 15; difficulty++) {
        List<Question> tempForDifficultySearch = [];
        //get all questions with the wanted difficulty
        Question._allQuestions.forEach((question) {
          if (question.difficulty == difficulty) {
            tempForDifficultySearch.add(question);
          }
        });
        //now adding random question with this difficulty to our result list
        var randomIndex = random.nextInt(tempForDifficultySearch.length);
        questions.add(tempForDifficultySearch[randomIndex]);
      }
      return questions;
    }
  }

  static List<Question> _shuffle(List<Question> list) {
    var random = new Random();

    // Go through all elements.
    for (var i = list.length - 1; i > 0; i--) {
      // Pick a pseudorandom number according to the list length
      var n = random.nextInt(i + 1);

      var temp = list[i];
      list[i] = list[n];
      list[n] = temp;
    }

    return list;
  }

  static const Map<Chapter, String> chapterMap = {Chapter.neuesTestament: "Neues Testament", Chapter.altesTestament: "Altes Testament"};

  static const List<Question> _allQuestions = [
    Question(chapter: const [Chapter.altesTestament], question: "Wo verwirrte Gott die Sprache der Menschen?", answers: const ["In Jericho", "In Babylon", "In Babel", "In Sinai"], solutionIndex: 2, difficulty: 1),
    Question(chapter: const [Chapter.altesTestament], question: "Aus was erschuf Gott die Frau?",
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
          "Mose selber", "Gott"], solutionIndex: 3, difficulty: 3),
    Question(chapter: const [Chapter.neuesTestament], question: "Wer war kein Jünger von Jesus?", answers: const ["Matthäus", "Johannes", "Lukas", "Philippus"], solutionIndex: 2, difficulty: 4),
    Question(chapter: const [Chapter.altesTestament], question: "Der Herr ist mein ........, mir wird nichts mangeln.", answers: const ["Sieger", "Erlöser", "König", "Hirte"], solutionIndex: 3, difficulty: 1),
    Question(
        chapter: const [Chapter.neuesTestament],
        question: "Was hat Jesus nach seiner Auferstehung mit den Jüngern gegessen?",
        answers: const ["Honig und Heuschrecken", "Currywurst und Pommes", "Lamm und Datteln", "Fisch und Brot"],
        solutionIndex: 3,
        difficulty: 2),
    Question(chapter: const [Chapter.altesTestament], question: "Welchen Tieren wurde Daniel zum Fraß vorgeworfen?", answers: const ["Wildkatzen", "Krokodilen", "Tiger", "Löwen"], solutionIndex: 3, difficulty: 3),
    Question(
        chapter: const [Chapter.altesTestament],
        question: "Wie zahlreich sollten Abrahams Nachkommen werden?",
        answers: const ["wie das Wasser im Ozean", "wie die Muscheln am Strand", "wie die Sterne am Himmel", "wie die Insekten auf Erden"],
        solutionIndex: 2,
        difficulty: 4),
    Question(
        chapter: const [Chapter.altesTestament],
        question: "Was antwortete Kain Gott?",
        answers: const ["Ich habe meinen Bruder nicht erschlagen.", "Mein Bruder hat sich verlaufen.", "Mein Bruder ist tot.", "Muss ich immer auf meinen Bruder aufpassen!?"],
        solutionIndex: 3,
        difficulty: 5),
    Question(
        chapter: const [Chapter.neuesTestament],
        question: "Mit was vergleicht Jesus das Himmelreich einmal?",
        answers: const ["Mit einer fleißigen Ameise.", "Mit einer vergrabenen Kartoffel", "Mit einem gefüllten Fass Wein.", "Mit einem verborgenen Schatz."],
        solutionIndex: 3,
        difficulty: 6),
    Question(
        chapter: const [Chapter.neuesTestament],
        question: "Wem verspricht Jesus in den Seligpreisungen, dass sie das Erdreich besitzen werden?",
        answers: const ["den geistlichen Armen", "den Sanftmütigen", "den Friedfertigen", "denen, die sich nach Gerechtigkeit sehnen"],
        solutionIndex: 1,
        difficulty: 7),
    Question(chapter: const [Chapter.altesTestament], question: "Wie nennt Isaak einmal einen Brunnen?", answers: const ["Bank", "Rank", "Zank", "Tank"], solutionIndex: 2, difficulty: 8),
    Question(chapter: const [Chapter.neuesTestament], question: "'Auf den Fels gebaut' und 'auf Sand gebaut' bezieht Jesus auf was?", answers: const ["Turm", "Haus", "Brücke", "Tempel"], solutionIndex: 1, difficulty: 9),
    Question(chapter: const [Chapter.altesTestament], question: "Wo strandete die Arche Noah?", answers: const ["Auf dem Berg Horeb", "Unbekannt", "Auf dem Gebirge Ararat", "Auf dem Gebirge Gilead"], solutionIndex: 2, difficulty: 10),
    Question(
        chapter: const [Chapter.altesTestament],
        question: "In welchem Buch der Bibel findet man die Vision über die Frau in der Tonne?",
        answers: const ["Sacharja", "Hesekiel", "Offenbarung", "Daniel"],
        solutionIndex: 0,
        difficulty: 11,
        solutionNoteHuman: "Sach 5,5-8",
        solutionNoteURL: "https://www.bible.com/de/bible/73/zec.5.5-8"),
    Question(chapter: const [Chapter.altesTestament], question: "Wie viele Verse hat der längste Psalm?", answers: const ["97", "176", "218", "274"], solutionIndex: 1, difficulty: 12),
    Question(
        chapter: const [Chapter.neuesTestament],
        question: "Was taten Jesus und die Jünger als letztes bevor sie zum Ölberg gingen?",
        answers: const ["Sie aßen", "Sie sangen ein Loblied", "Sie tranken", "Sie wuschen sich"],
        solutionIndex: 1,
        difficulty: 13),
    Question(
        chapter: const [Chapter.neuesTestament],
        question: "Weshalb wissen 'wir', dass 'wir' laut dem 1. Johannes aus dem Tod in das Leben gekommen sind?",
        answers: const ["Weil 'wir' Gott fürchten.", "Weil 'wir' Gottes Gnade empfangen haben.", "Weil 'wir' unsere Brüder lieben.", "Weil Jesus Christus für 'uns' starb."],
        solutionIndex: 2,
        difficulty: 14),
    Question(
        chapter: const [Chapter.altesTestament],
        question: "Welche zwei Männer gerieten im Lager und nicht im Offenbarungszelt in prophetische Verzückung?",
        answers: const ["Eldad und Medad", "Nun und Schelach", "Jered und Levi", "Almodad, Schelef"],
        solutionIndex: 0,
        difficulty: 15),
    Question(chapter: const [Chapter.altesTestament], question: "Wie nannte man einen König der Ägypter?", answers: ["Big Boss", "Cäsar", "King Kong", "Pharao"], solutionIndex: 3, difficulty: 1),
    Question(chapter: const [Chapter.neuesTestament], question: "Wie groß war die Anzahl der Schafe bei Jesu Geburt?", answers: const ["zwölf", "Das wird nirgend in der Bibel erähnt.", "drei", "null"], solutionIndex: 1, difficulty: 2),
    Question(
        chapter: const [Chapter.altesTestament],
        question: "Wie heißt der erste Vers der Bibel?",
        answers: const ["Am ersten Tag schuf Gott...", "Am Anfang schuf Gott Himmel und Erde.", "Gott sprach...", "Am Anfang schuf Gott Erde und Himmel."],
        solutionIndex: 1,
        difficulty: 3),
    Question(chapter: const [Chapter.neuesTestament], question: "Welches Tier soll ein Vorbild für Faule sein?", answers: const ["Kamel", "Taube", "Ameise", "Esel"], solutionIndex: 2, difficulty: 4),
    Question(chapter: const [Chapter.altesTestament], question: "Wo wohnte Lot bevor er gefangen genommen wurde?", answers: const ["Kanaan", "Gomorra", "Man weiß es nicht", "Sodom"], solutionIndex: 3, difficulty: 5),
    Question(
        chapter: const [Chapter.altesTestament],
        question: "Warum aß Daniel die Speisen des Königs nicht?",
        answers: const ["Um sich nicht zu verunreinigen.", "Es schmeckte ihm nicht.", "Er war krank und konnte nichts essen.", "Er wäre getötet worden."],
        solutionIndex: 0,
        difficulty: 6),
    Question(
        chapter: const [Chapter.neuesTestament],
        question: "In welchen der Evangelien wird sogar der Esel im Stall zu Bethlehem erwähnt?",
        answers: const ["Bei Johannes", "Bei Lukas", "Bei Markus und Matthäus", "Bei keinem"],
        solutionIndex: 3,
        difficulty: 7),
    Question(
        chapter: const [Chapter.altesTestament],
        question: "Bei wem oder was wartete der Prophet Jona vergeblich auf den Untergang der Stadt Ninive?",
        answers: const ["bei einer Staude", "bei einer Frau", "bei der Stadtmauer", "bei einem See"],
        solutionIndex: 0,
        difficulty: 8,
        tip: "Jona 4,6-9"),
    Question(
      chapter: const [Chapter.neuesTestament],
      question: "An welche Gemeinde ist das erste Sendschreiben in der Offenbarung gerichtet?",
      answers: const ["an die Gemeinde in Ephesus", "an die Gemeinde in Thyatria", "an die Gemeine in Pergamon", "an die Gemeinde in Philadelphia"],
      solutionIndex: 0,
      difficulty: 9,
    ),
    Question(chapter: const [Chapter.altesTestament], question: "Auf welchem Berg bekam Mose die Zehn Gebote?", answers: const ["Morija", "Hermon", "Karmel", "Sinai"], solutionIndex: 3, difficulty: 10),
    Question(
        chapter: const [Chapter.altesTestament],
        question: "Was ist über Hiobs Tod überliefert?",
        answers: const ["Er starb einsam und verbittert.", "Er starb alt und lebenssatt.", "Er wurde im Kampf getötet.", "Es ist nichts überliefert."],
        solutionIndex: 1,
        difficulty: 11),
    Question(chapter: const [Chapter.altesTestament], question: "Noah hatte welchen Beruf?", answers: const ["Schäfer", "Ackermann", "Schmied", "Steht nicht in der Bibel!"], solutionIndex: 1, difficulty: 12),
    Question(chapter: const [Chapter.altesTestament], question: "Welcher Name passt nicht in diese Reihe?", answers: const ["Tamar", "Abital", "Maacha", "Egla"], solutionIndex: 0, difficulty: 13),
    Question(
        chapter: const [Chapter.neuesTestament],
        question: "Was sagt Jesus einmal zu den Schriftgelehrten und Pharisäern?",
        answers: const ["Sie sollen das Brett zerbrechen", "Sie sollen den Becher reinigen", "Sie sollen Mücken aussieben", "Sie sollen Kamele verschlucken"],
        solutionIndex: 1,
        difficulty: 14),
    Question(
        chapter: const [Chapter.neuesTestament],
        question: "Vervollständige: Das Lamm, das geschlachtet ist, ist würdig, zu nehmen Kraft und Reichtum und ...",
        answers: const ["Ehre und Stärke und Lob und Preis und Weisheit.", "Weisheit und Stärke und Ehre und Preis und Lob.", "Ehre und Preis und Lob und Weisheit und Stärke.", "Ehre und Stärke und Lob und Weisheit und Preis."],
        solutionIndex: 1,
        difficulty: 15),
    Question(
        chapter: const [Chapter.altesTestament, Chapter.neuesTestament],
        question: "Was ist laut der Bibel der Anfang aller Erkenntnis?",
        answers: const ["Weisheit", "Gottesfurcht", "Glaube", "Buße"],
        solutionIndex: 1,
        difficulty: 3,
        solutionNoteURL: "https://www.bible.com/de/bible/73/pro.1.7",
        solutionNoteHuman: "Sprüche 1, 7",
        tip: "Sprüche 1, 7"),
  ];
}

enum Chapter {
  neuesTestament,
  altesTestament,
}
