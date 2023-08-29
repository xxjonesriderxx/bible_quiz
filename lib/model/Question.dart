import 'dart:math';

class Question {
  final List<Chapter> chapter;
  final String? imagePath;
  final String question;
  final List<String> answers;

  //index of right answer
  final int solutionIndex;

  //number from 1 to 15
  final int difficulty;

  //these are no solution tips but hints that explain the solution based on the Bible passage after answering
  final List<String>? solutionNoteHuman;
  final List<String>? solutionNoteURL;

  //tip for the "Who Wants to be a Biblionaire"-mode
  final String? tip;

  const Question(
      {this.imagePath,
      required this.chapter,
      required this.question,
      required this.answers,
      required this.solutionIndex,
      required this.difficulty,
      this.solutionNoteHuman,
      this.solutionNoteURL,
      this.tip});

  static List<Question> getRandomQuestions({required int numberOfQuestions, required Chapter chapter, bool biblionaireMode = false}) {
    List<Question> questions = [];
    if (!biblionaireMode) {
      Question._allQuestions.forEach((question) {
        if (questions.length < numberOfQuestions && (chapter == Chapter.alles ? true : question.chapter.contains(chapter))) {
          questions.add(question);
        }
      });
      return List.of(questions..shuffle()).map((e) => _shuffleAnswerOptions(e)).toList();
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
        questions.add(_shuffleAnswerOptions(tempForDifficultySearch[randomIndex]));
      }
      return questions;
    }
  }

  static Question _shuffleAnswerOptions(Question question) {
    List<String> randomizedAnswers = List.of(question.answers)..shuffle();
    int newSolutionIndex = randomizedAnswers.indexOf(question.answers[question.solutionIndex]);

    return Question(
        imagePath: question.imagePath,
        chapter: question.chapter,
        question: question.question,
        answers: randomizedAnswers,
        solutionIndex: newSolutionIndex,
        difficulty: question.difficulty,
        solutionNoteHuman: question.solutionNoteHuman,
        solutionNoteURL: question.solutionNoteURL,
        tip: question.tip);
  }

  static int getCountOfQuestions(Chapter chapter) {
    int count = 0;
    if (chapter == Chapter.alles) {
      return Question._allQuestions.length;
    }
    Question._allQuestions.forEach((question) {
      if (question.chapter.contains(chapter)) {
        count++;
      }
    });
    return count;
  }

  static const Map<Chapter, String> chapterMap = {
    Chapter.alles: "Die gesamte Bibel",
    Chapter.neuesTestament: "Neues Testament",
    Chapter.altesTestament: "Altes Testament",
    Chapter.juengerUndApostel: "Jünger und Apostel",
    Chapter.Josua: "Josua",
    Chapter.Mose: "Mose",
    Chapter.Jesus: "Jesus",
    Chapter.Koenige: "Könige"
  };

  static const List<Question> _allQuestions = [
    Question(
        chapter: const [Chapter.altesTestament],
        question: "Wo verwirrte Gott die Sprache der Menschen?",
        answers: const ["In Jericho", "In Babylon", "In Babel", "In Sinai"],
        solutionIndex: 2,
        difficulty: 3,
        imagePath: "towerOfBabelIsBuilt.png",
        solutionNoteURL: ["https://www.bible.com/de/bible/73/gen.11.1-9"]),
    Question(
        chapter: const [Chapter.altesTestament],
        question: "Aus was erschuf Gott die Frau?",
        answers: const ["Jochbein", "Ferse", "Schlüsselbein", "Rippe", "Staub"],
        solutionIndex: 3,
        difficulty: 4,
        solutionNoteURL: ["https://www.bible.com/de/bible/877/GEN.2.21-22"],
        solutionNoteHuman: ["1. Mose 2:21-22"],
        imagePath: "adamSleepsInEden.jpeg"),
    Question(
        chapter: const [Chapter.neuesTestament, Chapter.juengerUndApostel],
        question: "Von welchem dieser Personen wird berichtet, dass er auf dem Wasser ging?",
        answers: const ["Petrus", "Johannes", "Lukas", "Matthäus"],
        solutionIndex: 0,
        difficulty: 6,
        solutionNoteURL: ["https://www.bible.com/de/bible/73/mat.23.28-31"],
        solutionNoteHuman: ["Matthäus 23:28-31"],
        imagePath: "petrusWalksOnWater.png"),
    Question(
      chapter: const [Chapter.altesTestament],
      question: "Wer bekam die 10 Gebote von Gott?",
      answers: const ["Aaron", "Jakob", "Mose", "Abraham"],
      solutionIndex: 2,
      difficulty: 3,
    ),
    Question(
      chapter: const [Chapter.neuesTestament],
      question: "Auf welchem Baum saß Zachäus?",
      answers: const ["Maulbeer-Feigenbaum", "Olivenbaum", "Zedernbaum", "Johannisbrotbaum"],
      solutionIndex: 0,
      difficulty: 4,
      solutionNoteURL: ["https://www.bible.com/de/bible/73/LUK.19.4"],
      solutionNoteHuman: ["Lukas 19:4"],
    ),
    Question(
      chapter: const [Chapter.altesTestament],
      question: "Wer schrieb die 10 Gebote?",
      answers: const ["Es waren 12 Gebote.", "Ein Steinmetz von Mose", "Mose selber", "Gott"],
      solutionIndex: 3,
      difficulty: 2,
      solutionNoteURL: ["https://www.bible.com/de/bible/73/exo.31.18"],
      solutionNoteHuman: ["2. Mose 31:18"],
    ),
    Question(
        chapter: const [Chapter.neuesTestament, Chapter.juengerUndApostel],
        question: "Wer war kein Jünger von Jesus?",
        answers: const ["Matthäus", "Johannes", "Lukas", "Philippus"],
        solutionIndex: 2,
        difficulty: 2),
    Question(
      chapter: const [Chapter.altesTestament],
      question: "Der Herr ist mein ........, mir wird nichts mangeln.",
      answers: const ["Sieger", "Erlöser", "König", "Hirte"],
      solutionIndex: 3,
      difficulty: 2,
      solutionNoteURL: ["https://www.bible.com/de/bible/73/psa.23.1"],
      solutionNoteHuman: ["Psalm 23:1"],
    ),
    Question(
      chapter: const [Chapter.neuesTestament, Chapter.juengerUndApostel],
      question: "Was hat Jesus nach seiner Auferstehung mit den Jüngern gegessen?",
      answers: const ["Honig und Heuschrecken", "Currywurst und Pommes", "Lamm und Datteln", "Fisch und Brot"],
      solutionIndex: 3,
      difficulty: 3,
      solutionNoteURL: ["https://www.bible.com/de/bible/73/luk.24.41-43"],
      solutionNoteHuman: ["Lukas 24:41-43"],
    ),
    Question(
      chapter: const [Chapter.altesTestament],
      question: "Welchen Tieren wurde Daniel zum Fraß vorgeworfen?",
      answers: const ["Wildkatzen", "Krokodilen", "Tiger", "Löwen"],
      solutionIndex: 3,
      difficulty: 4,
      solutionNoteURL: ["https://www.bible.com/de/bible/73/DAN.6"],
      solutionNoteHuman: ["Daniel 6"],
    ),
    Question(
      chapter: const [Chapter.altesTestament],
      question: "Wie zahlreich sollten Abrahams Nachkommen werden?",
      answers: const ["wie das Wasser im Ozean", "wie die Muscheln am Strand", "wie die Sterne am Himmel", "wie die Insekten auf Erden"],
      solutionIndex: 2,
      difficulty: 3,
      solutionNoteURL: ["https://www.bible.com/de/bible/73/gen.15.5"],
      solutionNoteHuman: ["1. Mose 15:5"],
    ),
    Question(
      chapter: const [Chapter.altesTestament],
      question: "Was antwortete Kain Gott?",
      answers: const ["Ich habe meinen Bruder nicht erschlagen.", "Mein Bruder hat sich verlaufen.", "Mein Bruder ist tot.", "Muss ich immer auf meinen Bruder aufpassen!?"],
      solutionIndex: 3,
      difficulty: 2,
      solutionNoteURL: ["https://www.bible.com/de/bible/73/gen.4.9"],
      solutionNoteHuman: ["1. Mose 4:9"],
    ),
    Question(
        chapter: const [Chapter.neuesTestament],
        question: "Mit was vergleicht Jesus das Himmelreich einmal?",
        answers: const ["Mit einer fleißigen Ameise.", "Mit einer vergrabenen Kartoffel", "Mit einem gefüllten Fass Wein.", "Mit einem verborgenen Schatz."],
        solutionIndex: 3,
        difficulty: 5),
    Question(
      chapter: const [Chapter.neuesTestament],
      question: "Wem verspricht Jesus in den Seligpreisungen, dass sie das Erdreich besitzen werden?",
      answers: const ["den geistlichen Armen", "den Sanftmütigen", "den Friedfertigen", "denen, die sich nach Gerechtigkeit sehnen"],
      solutionIndex: 1,
      difficulty: 4,
      solutionNoteURL: ["https://www.bible.com/de/bible/157/mat.5.5"],
      solutionNoteHuman: ["Matthäus 5:5"],
    ),
    Question(chapter: const [Chapter.altesTestament], question: "Wie nennt Isaak einmal einen Brunnen?", answers: const ["Bank", "Rank", "Zank", "Tank"], solutionIndex: 2, difficulty: 4),
    Question(
        chapter: const [Chapter.neuesTestament],
        question: "'Auf den Fels gebaut' und 'auf Sand gebaut' bezieht Jesus auf was?",
        answers: const ["Turm", "Haus", "Brücke", "Tempel"],
        solutionIndex: 1,
        difficulty: 5),
    Question(
        chapter: const [Chapter.altesTestament],
        question: "Wo strandete die Arche Noah?",
        answers: const ["Auf dem Berg Horeb", "Unbekannt", "Auf dem Gebirge Ararat", "Auf dem Gebirge Gilead"],
        solutionIndex: 2,
        difficulty: 10),
    Question(
        chapter: const [Chapter.altesTestament],
        question: "In welchem Buch der Bibel findet man die Vision über die Frau in der Tonne?",
        answers: const ["Sacharja", "Hesekiel", "Offenbarung", "Daniel"],
        solutionIndex: 0,
        difficulty: 5,
        solutionNoteHuman: ["Sach 5,5-8"],
        solutionNoteURL: ["https://www.bible.com/de/bible/73/zec.5.5-8"]),
    Question(chapter: const [Chapter.altesTestament], question: "Wer war der Vater von König David?", answers: const ["König Saul", "König Salomo", "Isaak", "Isai"], solutionIndex: 3, difficulty: 11),
    Question(chapter: const [Chapter.altesTestament], question: "Wie viele Verse hat der längste Psalm?", answers: const ["97", "176", "218", "274"], solutionIndex: 1, difficulty: 9),
    Question(
        chapter: const [
          Chapter.altesTestament,
        ],
        question: "In welchem Buch der Bibel wird die Geschichte von Elia und der Feuerprobe erzählt?",
        answers: const ["1. Mose", "2. Könige", "Psalmen", "Jeremia"],
        solutionIndex: 1,
        difficulty: 13),
    Question(
        chapter: const [Chapter.neuesTestament, Chapter.juengerUndApostel],
        question: "Was taten Jesus und die Jünger als letztes bevor sie zum Ölberg gingen?",
        answers: const ["Sie aßen", "Sie sangen ein Loblied", "Sie tranken", "Sie wuschen sich"],
        solutionIndex: 1,
        difficulty: 3),
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
    Question(
        chapter: const [Chapter.neuesTestament],
        question: "Wie groß war die Anzahl der Schafe bei Jesu Geburt?",
        answers: const ["zwölf", "Das wird nirgend in der Bibel erähnt.", "drei", "null"],
        solutionIndex: 1,
        difficulty: 2),
    Question(
        chapter: const [Chapter.altesTestament],
        question: "Wie heißt der erste Vers der Bibel?",
        answers: const ["Am ersten Tag schuf Gott...", "Am Anfang schuf Gott Himmel und Erde.", "Gott sprach...", "Am Anfang schuf Gott Erde und Himmel."],
        solutionIndex: 1,
        difficulty: 3),
    Question(chapter: const [Chapter.neuesTestament], question: "Welches Tier soll ein Vorbild für Faule sein?", answers: const ["Kamel", "Taube", "Ameise", "Esel"], solutionIndex: 2, difficulty: 4),
    Question(
        chapter: const [Chapter.altesTestament],
        question: "Wo wohnte Lot bevor er gefangen genommen wurde?",
        answers: const ["Kanaan", "Gomorra", "Man weiß es nicht", "Sodom"],
        solutionIndex: 3,
        difficulty: 5),
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
    Question(
        chapter: const [Chapter.altesTestament], question: "Auf welchem Berg bekam Mose die Zehn Gebote?", answers: const ["Morija", "Hermon", "Karmel", "Sinai"], solutionIndex: 3, difficulty: 10),
    Question(
        chapter: const [Chapter.altesTestament],
        question: "Was ist über Hiobs Tod überliefert?",
        answers: const ["Er starb einsam und verbittert.", "Er starb alt und lebenssatt.", "Er wurde im Kampf getötet.", "Es ist nichts überliefert."],
        solutionIndex: 1,
        difficulty: 11),
    Question(
        chapter: const [Chapter.altesTestament],
        question: "Noah hatte welchen Beruf?",
        answers: const ["Schäfer", "Ackermann", "Schmied", "Steht nicht in der Bibel!"],
        solutionIndex: 1,
        difficulty: 12),
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
        answers: const [
          "Ehre und Stärke und Lob und Preis und Weisheit.",
          "Weisheit und Stärke und Ehre und Preis und Lob.",
          "Ehre und Preis und Lob und Weisheit und Stärke.",
          "Ehre und Stärke und Lob und Weisheit und Preis."
        ],
        solutionIndex: 1,
        difficulty: 15),
    Question(
        chapter: const [Chapter.altesTestament, Chapter.neuesTestament],
        question: "Was ist laut der Bibel der Anfang aller Erkenntnis?",
        answers: const ["Weisheit", "Gottesfurcht", "Glaube", "Buße"],
        solutionIndex: 1,
        difficulty: 3,
        solutionNoteURL: ["https://www.bible.com/de/bible/73/pro.1.7"],
        solutionNoteHuman: ["Sprüche 1, 7"],
        tip: "Sprüche 1, 7"),
    Question(
        chapter: const [Chapter.juengerUndApostel, Chapter.neuesTestament],
        question: "Welcher Satz stammt von Jesus ?",
        answers: const ["Ich bin bei Euch alle Tage bis zum Ende der Welt.", "Ende gut - Alles gut!", "Bleibt immer cool!", "Und Tschüss!"],
        solutionIndex: 0,
        difficulty: 1),
    Question(
        chapter: const [Chapter.altesTestament, Chapter.Mose],
        question: "Wieso waren Josefs Brüder neidisch auf ihn?",
        answers: const ["Ihr Vater schenkte ihm einen Esel.", "Josef erhielt eine reiche Erbschaft.", "Josef hatte die schönste Frau.", "Ihr Vater liebte Josef mehr als sie."],
        solutionIndex: 3,
        difficulty: 2),
    Question(
        chapter: const [Chapter.juengerUndApostel, Chapter.altesTestament],
        question: "Worüber staunten die Menschen, als an Pfingsten der Geist Gottes auf die Apostel herabgekommen war?",
        answers: const ["Die Apostel begannen zu schweben.", "100 weiße Tauben flogen auf.", "Jeder hörte die Apostel in seiner eigenen Sprache reden.", "Die Apostel hatten Heiligenscheine."],
        solutionIndex: 2,
        difficulty: 1),
    Question(
        chapter: const [Chapter.juengerUndApostel, Chapter.altesTestament],
        question: "Judas wurde für den Verrat an Jesus belohnt mit ...",
        answers: const ["Wein.", "einem Hahn.", "Gold.", "Silbergeld."],
        solutionIndex: 3,
        difficulty: 2),
    Question(
        chapter: const [Chapter.altesTestament],
        question: "Was sagte Gott am ersten Tag der Schöpfung?",
        answers: const ["Das Chaos hat nun ein Ende.", "Es werde Licht.", "Sonne, Mond und Sterne sollen leuchten.", "Ich erschaffe jetzt Mann und Frau."],
        solutionIndex: 1,
        difficulty: 1),
    Question(
        chapter: const [Chapter.altesTestament],
        question: "Wozu erschuf Gott Sonne und Mond?",
        answers: const ["zur Zeitbestimmung", "als Lichtquellen", "aus Spaß ", "als Wärmequellen"],
        solutionIndex: 0,
        difficulty: 5),
    Question(
        chapter: const [Chapter.altesTestament],
        question: "Was wurde zuerst erschaffen?",
        answers: const ["die Menschen", "die Vögel", "die Fische", "die Säugetiere"],
        solutionIndex: 2,
        difficulty: 3,
        tip: "Wurden am 5. Tag erschaffen"),
    Question(
        chapter: const [Chapter.altesTestament],
        question: "Wie beurteilte Gott sein Werk?",
        answers: const ["Er fand es unvollständig.", "Er fand es schlecht.", "Er fand es gut.", "Er fand es langweilig"],
        solutionIndex: 2,
        difficulty: 1),
    Question(
        chapter: const [Chapter.altesTestament],
        question: "Wann wurden die Pflanzen erschaffen?",
        answers: const ["am 2. Tag", "am 3. Tag", "am 4. Tag", "am 5. Tag"],
        solutionIndex: 3,
        difficulty: 4,
        imagePath: "god-creates-plants.png"),
    Question(
        chapter: const [Chapter.altesTestament],
        question: "Wer wird in der Schöpfungsgeschichte nicht genannt?",
        answers: const ["die Vögel", "die Fische", "die Menschen", "die Affen"],
        solutionIndex: 3,
        difficulty: 1),
    Question(
        chapter: const [Chapter.altesTestament],
        question: "Warum durfte Mose das verheißene Land nicht betreten?",
        answers: const ["Er murrte gegen Gott", "Er war bereits zu alt, sodass er das Land nicht erreichen konnte", "Er schlug einen Fels", "Er betete mit den Israeliten Götzen an"],
        solutionIndex: 2,
        difficulty: 4,
        solutionNoteHuman: [
          "Mose erhielt in 2. Mose 17 von Gott den Auftrag auf einen Stein zu schlagen, welcher sich teilte und Wasser zum Überleben fließen ließ, sodass Gottes Volk leben konnte. Dies ist ein Abbild auf Christus, welcher ebenfalls geschlagen und gebrochen werden musste, damit ewiges Leben für Gottes Kindern fließen konnte. Jesus musste nur ein für alle Mal gebrochen werden, somit durfte das vorausgehende Abbild auch nur einmal geschlagen und gebrochen werden. Stattdessen missachtete Mose Gottes Anweisung in 4. Mose 20 als die Israeliten wieder dürsteten, und schlug den Stein zweimal mit dem Stab, statt wie aufgetragen zu dem Stein zu reden."
        ],
        solutionNoteURL: ["https://www.bibelstudium.de/articles/121/mose-schlaegt-den-felsen.html"]),
    Question(
        chapter: const [Chapter.altesTestament, Chapter.Josua],
        question: "Was hängte Rahab als Erkennungszeichen in ihr Fenster?",
        answers: const ["Tuch", "Laken", "Seil", "Korb"],
        solutionIndex: 2,
        difficulty: 7,
        solutionNoteHuman: [
          "Josua 2,18",
          "In manchen Übersetzungen wird das Seil auch als Schnur übersetzt",
        ],
        imagePath: "rahabsHouse.png"),
    Question(
        chapter: const [Chapter.altesTestament, Chapter.Mose],
        question: "Abrahams Frau Sara ist auch seine ...",
        answers: const ["Schwester", "Halbschwester", "Cousine", "Nichte"],
        solutionIndex: 1,
        difficulty: 2,
        solutionNoteHuman: ["1. Mose 20,12"]),
    Question(
        chapter: const [Chapter.neuesTestament, Chapter.Jesus],
        imagePath: "barabbasInPrison.png",
        question: "Wie ist der Name des Mannes, welcher an Stelle von Jesus freigelassen wurde?",
        answers: ["Barabbas", "Stephanus", "Judas", "Barnabas"],
        solutionIndex: 0,
        difficulty: 3,
        solutionNoteHuman: ["Mt 27,20"]),
    Question(
      chapter: const [Chapter.neuesTestament, Chapter.Jesus],
      question: "Was riefen die Menschen Jesus bei seinem Einzug in Jerusalem zu?",
      answers: const [
        "Hosianna dem Sohn Davids! Gepriesen sei der, welcher kommt auf einem Fohlen im Namen des Herrn! Hosianna in der Höhe!",
        "Hosianna dem Höchsten! Gepriesen sei der, welcher kommt im Namen des Herrn! Hosianna im Himmel und der Erde!",
        "Hosianna dem Sohn Davids! Gepriesen sei der, welcher kommt im Namen des Herrn! Hosianna im Himmel und der Erde!",
        "Hosianna dem Sohn Davids! Gepriesen sei der, welcher kommt im Namen des Herrn! Hosianna in der Höhe!"
      ],
      imagePath: "crowd-jerusalem.png",
      solutionIndex: 3,
      difficulty: 8,
    ),
    Question(
        chapter: const [Chapter.Mose, Chapter.altesTestament],
        question: "Wie viele Plagen schickte Gott über Ägypten?",
        answers: const ["5", "7", "9", "10"],
        solutionIndex: 3,
        difficulty: 7,
        solutionNoteURL: ["https://www.bible.com/de/bible/157/exo.7.14"],
        solutionNoteHuman: ["2. Mose 7:14"],
        imagePath: "plagues-egypt.png"),
    Question(
      chapter: const [Chapter.altesTestament],
      question: "Welches Tier sprach zu Bileam?",
      answers: const ["Esel", "Kamel", "Pferd", "Schaf"],
      solutionIndex: 0,
      difficulty: 6,
      solutionNoteURL: ["https://www.bible.com/de/bible/157/num.22.28"],
      solutionNoteHuman: ["4. Mose 22:28"],
    ),
    Question(
      chapter: const [Chapter.neuesTestament, Chapter.juengerUndApostel, Chapter.Jesus],
      question: "Wie viele Jünger hatte Jesus?",
      answers: const ["10", "12", "15", "20"],
      solutionIndex: 1,
      difficulty: 2,
      solutionNoteURL: ["https://www.bible.com/de/bible/157/luk.6.13"],
      solutionNoteHuman: ["Lukas 6:13"],
    ),
    Question(
      chapter: const [Chapter.Jesus, Chapter.neuesTestament],
      question: "Welcher Tag wird als der Tag der Auferstehung Jesu gefeiert?",
      answers: const ["Karfreitag", "Ostersonntag", "Pfingstmontag", "Himmelfahrt"],
      solutionIndex: 1,
      difficulty: 3,
      solutionNoteURL: ["https://www.bible.com/de/bible/157/luk.24.1-7"],
      solutionNoteHuman: ["Lukas 24:1-7"],
    ),
    Question(
      chapter: const [Chapter.Josua, Chapter.altesTestament],
      question: "Welche Stadt eroberte Josua durch den Einzug der Israeliten?",
      answers: const ["Jerusalem", "Jericho", "Damaskus", "Babylon"],
      solutionIndex: 1,
      difficulty: 5,
      solutionNoteURL: ["https://www.bible.com/de/bible/157/jos.6.2-5"],
      solutionNoteHuman: ["Josua 6:2-5"],
    ),
    Question(
        chapter: const [Chapter.Jesus, Chapter.neuesTestament],
        question: "Bei welchem Gleichnis ließ jemand 99 zurück um einen zu finden.",
        answers: const ["Das Gleichnis vom verlorenen Schaf", "Das Gleichnis vom barmherzigen Samariter", "Das Gleichnis vom verlorenen Sohn", "Das Gleichnis vom Sämann"],
        solutionIndex: 0,
        difficulty: 3,
        solutionNoteURL: ["https://www.bible.com/de/bible/157/luk.15.3-7"],
        solutionNoteHuman: ["Lukas 15:3-7"],
        imagePath: "lost-sheep.png"),
    Question(
        chapter: const [Chapter.altesTestament, Chapter.Mose],
        question: "Wer wurde von Gott mit einem brennenden Busch berufen?",
        answers: const ["Mose", "Abraham", "David", "Jona"],
        solutionIndex: 0,
        difficulty: 8,
        solutionNoteURL: ["https://www.bible.com/de/bible/157/exo.3.1-10"],
        solutionNoteHuman: ["2. Mose 3:1-10"],
        imagePath: "burning-thorn-bush.png"),
    Question(
      chapter: const [Chapter.altesTestament],
      question: "Welches Tier sprach zu Adam und Eva?",
      answers: const ["Löwe", "Bär", "Schlange", "Affe"],
      solutionIndex: 2,
      difficulty: 4,
      solutionNoteURL: ["https://www.bible.com/de/bible/157/gen.3.1-6"],
      solutionNoteHuman: ["1. Mose 3:1-6"],
    ),
    Question(
      chapter: const [Chapter.Jesus, Chapter.neuesTestament],
      question: "Wie viele Brote und Fische wurden von Jesus vermehrt, um Tausende zu speisen?",
      answers: const ["3 Brote und 5 Fische", "5 Brote und 2 Fische", "10 Brote und 10 Fische", "7 Brote und 4 Fische"],
      solutionIndex: 1,
      difficulty: 6,
      solutionNoteURL: ["https://www.bible.com/de/bible/157/mat.14.13-21"],
      solutionNoteHuman: ["Matthäus 14:13-21"],
    ),
    Question(
      chapter: const [Chapter.neuesTestament, Chapter.Jesus, Chapter.juengerUndApostel],
      question: "Wie viele Tage nach Jesu Kreuzigung erschien er den Jüngern wieder?",
      answers: const ["1 Tag", "3 Tage", "7 Tage", "40 Tage"],
      solutionIndex: 1,
      difficulty: 7,
      solutionNoteURL: ["https://www.bible.com/de/bible/157/luk.24.1-7"],
      solutionNoteHuman: ["Lukas 24:1-7"],
    ),
    Question(
      chapter: const [Chapter.altesTestament],
      question: "Welches Instrument spielte David, um Saul zu beruhigen?",
      answers: const ["Harfe", "Flöte", "Trompete", "Geige"],
      solutionIndex: 0,
      difficulty: 4,
      solutionNoteURL: ["https://www.bible.com/de/bible/157/1sa.16.23"],
      solutionNoteHuman: ["1. Samuel 16:23"],
    ),
    Question(
      chapter: const [Chapter.Jesus, Chapter.neuesTestament],
      question: "In welcher Stadt wurde Jesus geboren?",
      answers: const ["Jerusalem", "Nazareth", "Bethlehem", "Jericho"],
      solutionIndex: 2,
      difficulty: 3,
      solutionNoteURL: ["https://www.bible.com/de/bible/157/luk.2.4-7"],
      solutionNoteHuman: ["Lukas 2:4-7"],
    ),
    Question(
      chapter: const [Chapter.neuesTestament],
      question: "Wie lautet der erste Buchstabe des griechischen Alphabets?",
      answers: const ["Alpha", "Beta", "Gamma", "Delta"],
      solutionIndex: 0,
      difficulty: 1,
      solutionNoteURL: ["https://de.wikipedia.org/wiki/Griechisches_Alphabet"],
      solutionNoteHuman: ["Alpha"],
    ),
    Question(
      chapter: const [Chapter.Jesus, Chapter.neuesTestament],
      question: "Was bedeutet der Name 'Jesus'?",
      answers: const ["Retter", "König", "Gottessohn", "Lehrer"],
      solutionIndex: 0,
      difficulty: 9,
      solutionNoteURL: ["https://www.bible.com/de/bible/157/mat.1.21"],
      solutionNoteHuman: ["Matthäus 1:21"],
    ),
    Question(
      chapter: const [Chapter.altesTestament],
      question: "Wie viele Tage dauerte die Schöpfungsgeschichte laut der Bibel?",
      answers: const ["4 Tage", "6 Tage", "7 Tage", "10 Tage"],
      solutionIndex: 1,
      difficulty: 10,
      solutionNoteURL: ["https://www.bible.com/de/bible/157/gen.1.1-31"],
      solutionNoteHuman: ["1. Mose 1:1-31", "Die eigentliche Schöpfung dauerte 6 Tage, am 7. ruhte Gott."],
    ),
    Question(
      chapter: const [Chapter.Jesus, Chapter.neuesTestament],
      question: "Welches Gebote nennt Jesus als das größte Gebot?",
      answers: const [
        "Du sollst den Herrn, deinen Gott, lieben",
        "Du sollst deinen Nächsten lieben wie dich selbst",
        "Du sollst den Sabbat heiligen",
        "Du sollst keine anderen Götter haben neben mir"
      ],
      solutionIndex: 0,
      difficulty: 9,
      solutionNoteURL: ["https://www.bible.com/de/bible/157/mat.22.34-40"],
      solutionNoteHuman: ["Matthäus 22:34-40"],
    ),
    Question(
      chapter: const [Chapter.Jesus, Chapter.neuesTestament],
      question: "Welche Jünger begleiteten Jesus auf den Berg der Verklärung?",
      answers: const ["Petrus, Jakobus und Johannes", "Petrus, Andreas und Jakobus", "Jakobus, Johannes und Thomas", "Petrus, Thomas und Johannes"],
      solutionIndex: 0,
      difficulty: 10,
      solutionNoteURL: ["https://www.bible.com/de/bible/157/mat.17.1-8"],
      solutionNoteHuman: ["Matthäus 17:1-8"],
    ),
    Question(
      chapter: const [Chapter.altesTestament],
      question: "Wer war der erste König des israelitischen Reiches?",
      answers: const ["Saul", "David", "Salomo", "Joschija"],
      solutionIndex: 0,
      difficulty: 8,
      solutionNoteURL: ["https://www.bible.com/de/bible/157/1sa.10.1"],
      solutionNoteHuman: ["1. Samuel 10:1"],
    ),
    Question(
        chapter: const [Chapter.altesTestament],
        question: "Welcher Prophet erhielt eine Botschaft von Gott durch eine Schrift an der Wand?",
        answers: const ["Jesaja", "Jeremia", "Daniel", "Hesekiel"],
        solutionIndex: 2,
        difficulty: 12,
        solutionNoteURL: ["https://www.bible.com/de/bible/157/dan.5.1-31"],
        solutionNoteHuman: ["Daniel 5:1-31"],
        imagePath: "schrift-an-wand.png"),
    Question(
        chapter: const [Chapter.altesTestament, Chapter.Koenige],
        question: "Welcher König baute den Tempel in Jerusalem?",
        answers: const ["König David", "König Salomo", "König Joschija", "König Hiskia"],
        solutionIndex: 1,
        difficulty: 13,
        solutionNoteURL: ["https://www.bible.com/de/bible/157/1ki.6.1-38"],
        solutionNoteHuman: ["1. Könige 6:1-38"],
        imagePath: "tempel.png"),
    Question(
        chapter: const [Chapter.Jesus, Chapter.neuesTestament],
        question: "Welche Worte die Jesus am Kreuz sprach sind im Matthäus Evangelium überliefert?",
        answers: const [
          "Es ist vollbracht!",
          "Vater, vergib ihnen, denn sie wissen nicht, was sie tun.",
          "Mein Gott, mein Gott, warum hast du mich verlassen?",
          "In deine Hände befehle ich meinen Geist."
        ],
        solutionIndex: 2,
        difficulty: 15,
        solutionNoteURL: ["https://www.bible.com/de/bible/157/mat.27.45-54"],
        solutionNoteHuman: ["Matthäus 27:45-54"],
        imagePath: "jesus-am-kreuz.png"),
    Question(
        chapter: const [Chapter.altesTestament, Chapter.Sprueche],
        question: "Mit was wird eine zänkische Frau verglichen",
        answers: ["Tropfendes Gebälk", "Feuchten Decke", "Quietschenden Tür", "Ein tropfendes Dach"],
        solutionIndex: 3,
        difficulty: 10,
        solutionNoteURL: ["https://www.bible.com/de/bible/157/PRO.27.15"]),
    Question(
        chapter: const [Chapter.altesTestament],
        question: "Wer wurde in einem feurigen Wagen empor gehoben.",
        answers: ["Elisa", "Joel", "Elia", "Jona"],
        solutionIndex: 2,
        difficulty: 8,
        solutionNoteURL: ["https://www.bible.com/de/bible/73/2KI.2.1-18"]),
    Question(
        chapter: const [Chapter.altesTestament, Chapter.Sprueche],
        question: "Der Umgang mit den Weisen macht ..., wer sich aber mit Narren einlässt ...",
        answers: ["reich ... wird arm", "weise ... wird dumm", "weise ... dem geht es schlecht", "aufmerksam ... wird nachlässig"],
        solutionIndex: 2,
        difficulty: 12,
        solutionNoteURL: ["https://www.bible.com/de/bible/73/pro.13.20"])
  ];
}

enum Chapter { alles, neuesTestament, altesTestament, juengerUndApostel, Josua, Mose, Jesus, Koenige, Sprueche }
