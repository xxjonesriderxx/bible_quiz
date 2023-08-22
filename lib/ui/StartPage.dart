import 'package:bible_quiz/ui/BiblionaireMode.dart';
import 'package:bible_quiz/ui/CustomCard.dart';
import 'package:bible_quiz/ui/QuizFilter.dart';
import 'package:flutter/material.dart';
import 'package:games_services/games_services.dart';

import '../helper/Constants.dart';

class StartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<StartPage> {
  @override
  void initState() {
    super.initState();
    GamesServices.signIn();
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Bibelquiz"),
        ),
        body: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: Constants.rootContainerPadding,
          //color: themeData.colorScheme.background,
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage("lib/assets/questionmarks.jpg"), fit: BoxFit.fitHeight)),
          child: Stack(
            children: [
              /*SvgPicture.asset(
                "lib/assets/papyrus3.svg",
                fit: BoxFit.fitHeight,
              ),*/
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomCard.withContent(
                    widthPercentage: 0.4,
                    tapAble: true,
                    callback: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => QuizFilter()),
                      );
                    },
                    //text: "Quiz starten",
                    content: Row(
                      children: [
                        /*Container(
                          child: SvgPicture.asset("lib/assets/quiz.svg", semanticsLabel: 'Quiz Logo'),
                          width: 150,
                        ),*/
                        Expanded(
                            child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Quiz starten",
                            style: TextStyle(color: themeData.textTheme.displayLarge?.color, fontSize: 16),
                          ),
                        ))
                      ],
                    ),
                    height: 80,
                    backgroundColor: Constants.uiSelectableColor /*.withOpacity(0.3)*/,
                  ),
                  CustomCard.withContent(
                    widthPercentage: 0.4,
                    tapAble: true,
                    callback: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BiblionaireMode()),
                      );
                    },
                    content: Row(children: [
                      Expanded(
                          child: Container(
                        alignment: Alignment.center,
                        //padding: EdgeInsets.all(16),
                        child: Text(
                          "Wer wird Biblionär?",
                          style: TextStyle(color: themeData.textTheme.displayLarge?.color, fontSize: 16),
                        ),
                      )),
                      /*Container(
                        child: SvgPicture.asset("lib/assets/playing-card.svg", semanticsLabel: 'Quiz Logo'),
                        width: 150,
                      ),*/
                    ]),
                    height: 80,
                    backgroundColor: Constants.uiSelectableColor /*.withOpacity(0.3)*/,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomCard.withContent(
                        widthPercentage: 0.3,
                        tapAble: true,
                        callback: _showLeaderboards,
                        //text: "Quiz starten",
                        content: Row(
                          children: [
                            Expanded(
                                child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                "Bestenliste",
                                style: TextStyle(color: themeData.textTheme.displayLarge?.color, fontSize: 16),
                              ),
                            ))
                          ],
                        ),
                        height: 50,
                        backgroundColor: Constants.googlePlayColor /*.withOpacity(0.3)*/,
                      ),
                      CustomCard.withContent(
                        widthPercentage: 0.3,
                        tapAble: true,
                        callback: _showAchievements,
                        //text: "Quiz starten",
                        content: Row(
                          children: [
                            Expanded(
                                child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                "Erfolge",
                                style: TextStyle(color: themeData.textTheme.displayLarge?.color, fontSize: 16),
                              ),
                            ))
                          ],
                        ),
                        height: 50,
                        backgroundColor: Constants.googlePlayColor /*.withOpacity(0.3)*/,
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ));
  }

  void _showLeaderboards() async {
    await Leaderboards.showLeaderboards();
  }

  void _showAchievements() async {
    final result = await Achievements.showAchievements();
    print(result);
  }
}
