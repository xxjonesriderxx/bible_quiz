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

  //tip for the "Who Wants to be a Biblionaire"-mode
  final String tip;

  const Question({this.imagePath, @required this.chapter, @required this.question, @required this.answers, @required this.solutionIndex, @required this.difficulty, this.solutionNoteHuman, this.solutionNoteURL, this.tip});

  static List<Question> getRandomQuestions({int numberOfQuestions, Chapter chapter, bool biblionaireMode = false}) {
    List<Question> questions = [];
    if (!biblionaireMode) {
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

  static const Map<Chapter, String> chapterMap = {Chapter.neuesTestament: "Neues Testament", Chapter.altesTestament: "Altes Testament", Chapter.juengerUndApostel: "J??nger und Apostel"};

  static const List<Question> _allQuestions = [
    Question(chapter: const [Chapter.altesTestament], question: "Wo verwirrte Gott die Sprache der Menschen?", answers: const ["In Jericho", "In Babylon", "In Babel", "In Sinai"], solutionIndex: 2, difficulty: 1),
    Question(chapter: const [Chapter.altesTestament], question: "Aus was erschuf Gott die Frau?", answers: const ["Jochbein", "Ferse", "Schl??sselbein", "Rippe", "Staub"], solutionIndex: 3, difficulty: 1),
    Question(chapter: const [Chapter.neuesTestament], question: "Auf welchem Baum sa?? Zach??us?", answers: const ["Maulbeer-Feigenbaum", "Olivenbaum", "Zedernbaum", "Johannisbrotbaum"], solutionIndex: 0, difficulty: 7),
    Question(
        chapter: const [Chapter.neuesTestament, Chapter.juengerUndApostel],
        question: "Von welchem dieser Personen wird berichtet, dass er auf dem Wasser ging?",
        answers: const ["Petrus", "Johannes", "Lukas", "Matth??us"],
        solutionIndex: 0,
        difficulty: 1),
    Question(chapter: const [Chapter.altesTestament], question: "Wer bekam die 10 Gebote von Gott?", answers: const ["Aaron", "Jakob", "Mose", "Abraham"], solutionIndex: 2, difficulty: 2),
    Question(chapter: const [Chapter.altesTestament], question: "Wer schrieb die 10 Gebote?", answers: const ["Es waren 12 Gebote.", "Ein Steinmetz von Mose", "Mose selber", "Gott"], solutionIndex: 3, difficulty: 3),
    Question(chapter: const [Chapter.neuesTestament, Chapter.juengerUndApostel], question: "Wer war kein J??nger von Jesus?", answers: const ["Matth??us", "Johannes", "Lukas", "Philippus"], solutionIndex: 2, difficulty: 4),
    Question(chapter: const [Chapter.altesTestament], question: "Der Herr ist mein ........, mir wird nichts mangeln.", answers: const ["Sieger", "Erl??ser", "K??nig", "Hirte"], solutionIndex: 3, difficulty: 1),
    Question(
        chapter: const [Chapter.neuesTestament, Chapter.juengerUndApostel],
        question: "Was hat Jesus nach seiner Auferstehung mit den J??ngern gegessen?",
        answers: const ["Honig und Heuschrecken", "Currywurst und Pommes", "Lamm und Datteln", "Fisch und Brot"],
        solutionIndex: 3,
        difficulty: 2),
    Question(chapter: const [Chapter.altesTestament], question: "Welchen Tieren wurde Daniel zum Fra?? vorgeworfen?", answers: const ["Wildkatzen", "Krokodilen", "Tiger", "L??wen"], solutionIndex: 3, difficulty: 3),
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
        answers: const ["Mit einer flei??igen Ameise.", "Mit einer vergrabenen Kartoffel", "Mit einem gef??llten Fass Wein.", "Mit einem verborgenen Schatz."],
        solutionIndex: 3,
        difficulty: 6),
    Question(
        chapter: const [Chapter.neuesTestament],
        question: "Wem verspricht Jesus in den Seligpreisungen, dass sie das Erdreich besitzen werden?",
        answers: const ["den geistlichen Armen", "den Sanftm??tigen", "den Friedfertigen", "denen, die sich nach Gerechtigkeit sehnen"],
        solutionIndex: 1,
        difficulty: 7),
    Question(chapter: const [Chapter.altesTestament], question: "Wie nennt Isaak einmal einen Brunnen?", answers: const ["Bank", "Rank", "Zank", "Tank"], solutionIndex: 2, difficulty: 8),
    Question(chapter: const [Chapter.neuesTestament], question: "'Auf den Fels gebaut' und 'auf Sand gebaut' bezieht Jesus auf was?", answers: const ["Turm", "Haus", "Br??cke", "Tempel"], solutionIndex: 1, difficulty: 9),
    Question(chapter: const [Chapter.altesTestament], question: "Wo strandete die Arche Noah?", answers: const ["Auf dem Berg Horeb", "Unbekannt", "Auf dem Gebirge Ararat", "Auf dem Gebirge Gilead"], solutionIndex: 2, difficulty: 10),
    Question(
        chapter: const [Chapter.altesTestament],
        question: "In welchem Buch der Bibel findet man die Vision ??ber die Frau in der Tonne?",
        answers: const ["Sacharja", "Hesekiel", "Offenbarung", "Daniel"],
        solutionIndex: 0,
        difficulty: 11,
        solutionNoteHuman: "Sach 5,5-8",
        solutionNoteURL: "https://www.bible.com/de/bible/73/zec.5.5-8"),
    Question(chapter: const [Chapter.altesTestament], question: "Wie viele Verse hat der l??ngste Psalm?", answers: const ["97", "176", "218", "274"], solutionIndex: 1, difficulty: 12),
    Question(
        chapter: const [Chapter.neuesTestament, Chapter.juengerUndApostel],
        question: "Was taten Jesus und die J??nger als letztes bevor sie zum ??lberg gingen?",
        answers: const ["Sie a??en", "Sie sangen ein Loblied", "Sie tranken", "Sie wuschen sich"],
        solutionIndex: 1,
        difficulty: 13),
    Question(
        chapter: const [Chapter.neuesTestament],
        question: "Weshalb wissen 'wir', dass 'wir' laut dem 1. Johannes aus dem Tod in das Leben gekommen sind?",
        answers: const ["Weil 'wir' Gott f??rchten.", "Weil 'wir' Gottes Gnade empfangen haben.", "Weil 'wir' unsere Br??der lieben.", "Weil Jesus Christus f??r 'uns' starb."],
        solutionIndex: 2,
        difficulty: 14),
    Question(
        chapter: const [Chapter.altesTestament],
        question: "Welche zwei M??nner gerieten im Lager und nicht im Offenbarungszelt in prophetische Verz??ckung?",
        answers: const ["Eldad und Medad", "Nun und Schelach", "Jered und Levi", "Almodad, Schelef"],
        solutionIndex: 0,
        difficulty: 15),
    Question(chapter: const [Chapter.altesTestament], question: "Wie nannte man einen K??nig der ??gypter?", answers: ["Big Boss", "C??sar", "King Kong", "Pharao"], solutionIndex: 3, difficulty: 1),
    Question(chapter: const [Chapter.neuesTestament], question: "Wie gro?? war die Anzahl der Schafe bei Jesu Geburt?", answers: const ["zw??lf", "Das wird nirgend in der Bibel er??hnt.", "drei", "null"], solutionIndex: 1, difficulty: 2),
    Question(
        chapter: const [Chapter.altesTestament],
        question: "Wie hei??t der erste Vers der Bibel?",
        answers: const ["Am ersten Tag schuf Gott...", "Am Anfang schuf Gott Himmel und Erde.", "Gott sprach...", "Am Anfang schuf Gott Erde und Himmel."],
        solutionIndex: 1,
        difficulty: 3),
    Question(chapter: const [Chapter.neuesTestament], question: "Welches Tier soll ein Vorbild f??r Faule sein?", answers: const ["Kamel", "Taube", "Ameise", "Esel"], solutionIndex: 2, difficulty: 4),
    Question(chapter: const [Chapter.altesTestament], question: "Wo wohnte Lot bevor er gefangen genommen wurde?", answers: const ["Kanaan", "Gomorra", "Man wei?? es nicht", "Sodom"], solutionIndex: 3, difficulty: 5),
    Question(
        chapter: const [Chapter.altesTestament],
        question: "Warum a?? Daniel die Speisen des K??nigs nicht?",
        answers: const ["Um sich nicht zu verunreinigen.", "Es schmeckte ihm nicht.", "Er war krank und konnte nichts essen.", "Er w??re get??tet worden."],
        solutionIndex: 0,
        difficulty: 6),
    Question(
        chapter: const [Chapter.neuesTestament],
        question: "In welchen der Evangelien wird sogar der Esel im Stall zu Bethlehem erw??hnt?",
        answers: const ["Bei Johannes", "Bei Lukas", "Bei Markus und Matth??us", "Bei keinem"],
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
        question: "Was ist ??ber Hiobs Tod ??berliefert?",
        answers: const ["Er starb einsam und verbittert.", "Er starb alt und lebenssatt.", "Er wurde im Kampf get??tet.", "Es ist nichts ??berliefert."],
        solutionIndex: 1,
        difficulty: 11),
    Question(chapter: const [Chapter.altesTestament], question: "Noah hatte welchen Beruf?", answers: const ["Sch??fer", "Ackermann", "Schmied", "Steht nicht in der Bibel!"], solutionIndex: 1, difficulty: 12),
    Question(chapter: const [Chapter.altesTestament], question: "Welcher Name passt nicht in diese Reihe?", answers: const ["Tamar", "Abital", "Maacha", "Egla"], solutionIndex: 0, difficulty: 13),
    Question(
        chapter: const [Chapter.neuesTestament],
        question: "Was sagt Jesus einmal zu den Schriftgelehrten und Pharis??ern?",
        answers: const ["Sie sollen das Brett zerbrechen", "Sie sollen den Becher reinigen", "Sie sollen M??cken aussieben", "Sie sollen Kamele verschlucken"],
        solutionIndex: 1,
        difficulty: 14),
    Question(
        chapter: const [Chapter.neuesTestament],
        question: "Vervollst??ndige: Das Lamm, das geschlachtet ist, ist w??rdig, zu nehmen Kraft und Reichtum und ...",
        answers: const ["Ehre und St??rke und Lob und Preis und Weisheit.", "Weisheit und St??rke und Ehre und Preis und Lob.", "Ehre und Preis und Lob und Weisheit und St??rke.", "Ehre und St??rke und Lob und Weisheit und Preis."],
        solutionIndex: 1,
        difficulty: 15),
    Question(
        chapter: const [Chapter.altesTestament, Chapter.neuesTestament],
        question: "Was ist laut der Bibel der Anfang aller Erkenntnis?",
        answers: const ["Weisheit", "Gottesfurcht", "Glaube", "Bu??e"],
        solutionIndex: 1,
        difficulty: 3,
        solutionNoteURL: "https://www.bible.com/de/bible/73/pro.1.7",
        solutionNoteHuman: "Spr??che 1, 7",
        tip: "Spr??che 1, 7"),
    Question(
        chapter: const [Chapter.juengerUndApostel, Chapter.neuesTestament],
        question: "Welcher Satz stammt von Jesus ?",
        answers: const ["Ich bin bei Euch alle Tage bis zum Ende der Welt.", "Ende gut - Alles gut!", "Bleibt immer cool!", "Und Tsch??ss!"],
        solutionIndex: 0,
        difficulty: 1),
    Question(
        chapter: const [Chapter.juengerUndApostel, Chapter.altesTestament],
        question: "Wieso waren Josefs Br??der neidisch auf ihn?",
        answers: const ["Ihr Vater schenkte ihm einen Esel.", "Josef erhielt eine reiche Erbschaft.", "Josef hatte die sch??nste Frau.", "Ihr Vater liebte Josef mehr als sie."],
        solutionIndex: 3,
        difficulty: 2),
    Question(
        chapter: const [Chapter.juengerUndApostel, Chapter.altesTestament],
        question: "Wor??ber staunten die Menschen, als an Pfingsten der Geist Gottes auf die Apostel herabgekommen war?",
        answers: const ["Die Apostel begannen zu schweben.", "100 wei??e Tauben flogen auf.", "Jeder h??rte die Apostel in seiner eigenen Sprache reden.", "Die Apostel hatten Heiligenscheine."],
        solutionIndex: 2,
        difficulty: 1),
    Question(
        chapter: const [Chapter.juengerUndApostel, Chapter.altesTestament], question: "Judas wurde f??r den Verrat an Jesus belohnt mit ...", answers: const ["Wein.", "einem Hahn.", "Gold.", "Silbergeld."], solutionIndex: 3, difficulty: 2),
    Question(
        chapter: const [Chapter.altesTestament],
        question: "Was sagte Gott am ersten Tag der Sch??pfung?",
        answers: const ["Das Chaos hat nun ein Ende.", "Es werde Licht.", "Sonne, Mond und Sterne sollen leuchten.", "Ich erschaffe jetzt Mann und Frau."],
        solutionIndex: 1,
        difficulty: 1),
    Question(chapter: const [Chapter.altesTestament], question: "Wozu erschuf Gott Sonne und Mond?", answers: const ["zur Zeitbestimmung", "als Lichtquellen", "aus Spa?? ", "als W??rmequellen"], solutionIndex: 0, difficulty: 5),
    Question(
        chapter: const [Chapter.altesTestament], question: "Was wurde zuerst erschaffen?", answers: const ["die Menschen", "die V??gel", "die Fische", "die S??ugetiere"], solutionIndex: 2, difficulty: 3, tip: "Wurden am 5. Tag erschaffen"),
    Question(
        chapter: const [Chapter.altesTestament],
        question: "Was tat Gott am Sch??pfungstag?",
        answers: const ["Er erschuf die Frau.", "Er erschuf Mann und Frau.", "Er ruhte aus.", "Er vernichtete alles, was ererschaffen hatte."],
        solutionIndex: 2,
        difficulty: 1),
    Question(
        chapter: const [Chapter.altesTestament],
        question: "Wann wurde der Menscherschaffen?",
        answers: const ["am 3. Tag", "am 4. Tag", "am 5. Tag", "am 6. Tag"],
        solutionIndex: 3,
        difficulty: 1,
        tip: "Der Mensch ist die Kr??nung der Sch??pfung."),
    Question(
        chapter: const [Chapter.altesTestament], question: "Wie beurteilte Gott sein Werk?", answers: const ["Er fand es unvollst??ndig.", "Er fand es schlecht.", "Er fand es gut.", "Er fand es langweilig"], solutionIndex: 2, difficulty: 1),
    Question(chapter: const [Chapter.altesTestament], question: "Wann wurden die Pflanzen erschaffen?", answers: const ["am 2. Tag", "am 3. Tag", "am 4. Tag", "am 5. Tag"], solutionIndex: 3, difficulty: 4),
    Question(chapter: const [Chapter.altesTestament], question: "Wer wird in der Sch??pfungsgeschichte nicht genannt?", answers: const ["die V??gel", "die Fische", "die Menschen", "die Affen"], solutionIndex: 3, difficulty: 1)
  ];
}

enum Chapter {
  neuesTestament,
  altesTestament,
  juengerUndApostel,
}
