import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';

class Result extends StatelessWidget {
  final int correctAnswered;
  final int totalQuestions;

  static const Color bronze = Color(0xffcc8e34);
  static const Color silver = Color(0xffc0c0c0);
  static const Color gold = Color(0xffe2b007);

  GlobalKey _screenshotContainer = new GlobalKey();

  Result({Key? key, required this.correctAnswered, required this.totalQuestions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    double widthHeightTrophy = MediaQuery.of(context).size.width / 2;
    ResultTypes result;
    String text = "";
    if (correctAnswered / totalQuestions < 0.33) {
      //bronze
      text = "Glückwunsch, du hast $correctAnswered von $totalQuestions Fragen richtig beantwortet. Bleib am Ball, du lernst die Bibel gerade kennen.";
      result = ResultTypes.bronze;
    } else if (correctAnswered / totalQuestions < 0.66) {
      //silver
      text = "Glückwunsch, du hast $correctAnswered von $totalQuestions Fragen richtig beantwortet, du bist auf bestem Wege Bibelexperte zu werden.";
      result = ResultTypes.silver;
    } else {
      //gold
      text = "Glückwunsch, du hast $correctAnswered von $totalQuestions Fragen richtig beantwortet, du bist Bibelexperte. Aber auch du darfst dich darauf freuen in der Bibel immer wieder neues zu erfahren.";
      result = ResultTypes.gold;
    }
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
                      color: result == ResultTypes.bronze
                          ? bronze
                          : result == ResultTypes.silver
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
                        style: TextStyle(fontSize: 14, color: themeData.textTheme.bodyLarge?.color),
                      ),
                    ),
                  ],
                )),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  padding: EdgeInsets.only(right: 16),
                  color: Colors.blue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.share,
                            color: Colors.white,
                          ),
                          onPressed: _share)
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

enum ResultTypes { bronze, silver, gold }
