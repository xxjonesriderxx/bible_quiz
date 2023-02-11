import 'package:bible_quiz/model/Question.dart';
import 'package:bible_quiz/ui/CustomCard.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SolutionContainer extends StatelessWidget {
  final Question question;
  final double paddingBetweenQuestionAndAnswer;
  final double? heightOfCard;

  SolutionContainer({required this.question, required this.paddingBetweenQuestionAndAnswer, this.heightOfCard});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomCard(
          callback: null,
          backgroundColor: Theme.of(context).primaryColor,
          tapAble: false,
          text: "Lösungserklärung",
          height: heightOfCard,
        ),
        ..._getNoteCards(context),
        ..._getLinkCards(context),
      ],
    );
  }

  List<Widget> _getNoteCards(BuildContext context) {
    List<Widget> list = [];
    question.solutionNoteHuman?.forEach((text) {
      list.add(Padding(padding: EdgeInsets.only(top: paddingBetweenQuestionAndAnswer)));
      list.add(CustomCard(
        callback: null,
        backgroundColor: Theme.of(context).primaryColor,
        tapAble: false,
        text: text,
        height: null,
      ));
    });
    return list;
  }

  List<Widget> _getLinkCards(BuildContext context) {
    List<Widget> list = [];
    question.solutionNoteURL?.forEach((url) {
      list.add(Padding(padding: EdgeInsets.only(top: paddingBetweenQuestionAndAnswer)));
      list.add(CustomCard.withContent(
        callback: null,
        backgroundColor: Theme.of(context).primaryColor,
        tapAble: false,
        content: InkWell(
          onTap: () async {
            if (await canLaunchUrlString(url)) {
              await launchUrlString(url);
            }
          },
          child: Text(
            url,
            style: TextStyle(
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        height: null,
      ));
    });
    return list;
  }
}
