import 'dart:ui' as ui;

import 'package:bible_quiz/helper/TimerScoreCalculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:games_services/games_services.dart';
import 'package:share_plus/share_plus.dart';

import '../helper/Constants.dart';
import '../model/ResultType.dart';

class Result extends StatefulWidget {
  final int correctAnswered;
  final int totalQuestions;

  Result({Key? key, required this.correctAnswered, required this.totalQuestions}) : super(key: key);

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  GlobalKey _screenshotContainer = GlobalKey();
  late ResultType result;
  late String text;

  static const Color bronze = Color(0xffcc8e34);
  static const Color silver = Color(0xffc0c0c0);
  static const Color gold = Color(0xffe2b007);

  @override
  void initState() {
    super.initState();
    GameAuth.isSignedIn.then((isSignedIn) {
      if (isSignedIn) {
        TimerScoreCalculator.instance.submitScore().then((score) {
          setState(() {
            text += "\n\nDu hast einen Score von $score XP erreicht.";
          });
        });
      }
    });

    double correctRatio = widget.correctAnswered / widget.totalQuestions;

    if (correctRatio < 0.33) {
      text = "Glückwunsch, du hast ${widget.correctAnswered} von ${widget.totalQuestions} Fragen richtig beantwortet. Bleib am Ball, du lernst die Bibel gerade kennen.";
      result = ResultType.bronze;
    } else if (correctRatio < 0.66) {
      text = "Glückwunsch, du hast ${widget.correctAnswered} von ${widget.totalQuestions} Fragen richtig beantwortet, du bist auf bestem Wege Bibelexperte zu werden.";
      result = ResultType.silver;
    } else {
      text =
          "Glückwunsch, du hast ${widget.correctAnswered} von ${widget.totalQuestions} Fragen richtig beantwortet, du bist Bibelexperte. Aber auch du darfst dich darauf freuen in der Bibel immer wieder neues zu erfahren.";
      result = ResultType.gold;
    }
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    double widthHeightTrophy = MediaQuery.of(context).size.width / 2;

    return Scaffold(
      appBar: AppBar(
        title: Text("Auswertung"),
      ),
      body: Container(
        color: themeData.colorScheme.background,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            RepaintBoundary(
              key: _screenshotContainer,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "lib/assets/trophy.svg",
                    color: result == ResultType.bronze
                        ? bronze
                        : result == ResultType.silver
                            ? silver
                            : gold,
                    width: widthHeightTrophy,
                    height: widthHeightTrophy,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: themeData.textTheme.bodyText1?.color),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  padding: EdgeInsets.only(right: 16),
                  color: Constants.cardColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      /*IconButton(
                        icon: Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                        onPressed: _share,
                      ),*/
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _share() async {
    RenderRepaintBoundary boundary = _screenshotContainer.currentContext?.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List? pngBytes = byteData?.buffer.asUint8List();
    XFile file = new XFile.fromData(pngBytes!, mimeType: 'image/png');
    await Share.shareXFiles([file], text: 'Teilen', subject: 'Bibelquiz Ergebnis.png');
  }
}
