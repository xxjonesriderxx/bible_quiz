import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

//TODO add WcFlutterShare and take Screenshot
class Result extends StatelessWidget {
  final int correctAnswered;
  final int totalQuestions;

  static const Color bronze = Color(0xffcc8e34);
  static const Color silver = Color(0xffc0c0c0);
  static const Color gold = Color(0xffe2b007);

  const Result(
      {Key key, @required this.correctAnswered, @required this.totalQuestions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthHeightTrophy = MediaQuery.of(context).size.width / 2;
    ResultTypes result;
    String text = "";
    if (correctAnswered / totalQuestions < 0.33) {
      //bronze
      text =
          "Glückwunsch, du hast $correctAnswered von $totalQuestions Fragen richtig beantwortet. Bleib am Ball, du lernst die Bibel gerade kennen.";
      result = ResultTypes.bronze;
    } else if (correctAnswered / totalQuestions < 0.66) {
      //silver
      text =
          "Glückwunsch, du hast $correctAnswered von $totalQuestions Fragen richtig beantwortet, du bist auf bestem Wege Bibelexperte zu werden.";
      result = ResultTypes.silver;
    } else {
      //gold
      text =
          "Glückwunsch, du hast $correctAnswered von $totalQuestions Fragen richtig beantwortet, du bist Bibelexperte. Aber auch du darfst dich darauf freuen in der Bibel immer wieder neues zu erfahren.";
      result = ResultTypes.gold;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Auswertung"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "lib/assets/trophy.svg",
              color: result == ResultTypes.bronze
                  ? bronze
                  : result == ResultTypes.silver
                      ? silver
                      : gold,
              width: widthHeightTrophy,
              height: widthHeightTrophy,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

enum ResultTypes { bronze, silver, gold }
