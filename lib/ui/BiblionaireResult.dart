import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';

import '../helper/Constants.dart';

class BiblionaireResult extends StatelessWidget {
  final int correctAnswered;
  final bool failed;

  GlobalKey _screenshotContainerKey = new GlobalKey();

  BiblionaireResult({Key? key, required this.correctAnswered, required this.failed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    double widthHeightOfPictures = MediaQuery.of(context).size.width / 2;
    String text = "";
    if (failed) {
      text = "Deine letzte Antwort war leider falsch, du hast $correctAnswered von 15 Fragen richtig beantwortet. Bleib am Ball, du lernst die Bibel gerade kennen.";
    } else {
      text = "Glückwunsch, du bist reich an Bibelwissen!";
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("Auswertung"),
        ),
        body: Container(
          child: Stack(
            children: [
              RepaintBoundary(
                key: _screenshotContainerKey,
                child: Container(
                  color: themeData.colorScheme.background,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      !failed
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "lib/assets/bible2.svg",
                                  width: widthHeightOfPictures / 2,
                                  height: widthHeightOfPictures / 2,
                                  color: Constants.cardColor,
                                ),
                                Icon(
                                  Icons.attach_money,
                                  size: widthHeightOfPictures / 2,
                                  color: Constants.cardColor,
                                ),
                              ],
                            )
                          : Text(
                              "🥺",
                              style: TextStyle(fontSize: 64),
                            ),
                      Padding(padding: EdgeInsets.only(top: 16)),
                      Text(
                        text,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, color: themeData.textTheme.bodyLarge?.color),
                      ),
                    ],
                  ),
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
        ));
  }

  _share() async {
    RenderRepaintBoundary boundary = _screenshotContainerKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List? pngBytes = byteData?.buffer.asUint8List();
    XFile file = new XFile.fromData(pngBytes!, mimeType: 'image/png');
    await Share.shareXFiles([file], text: 'Teilen', subject: 'Bibelquiz Ergebnis.png');
  }
}
