import 'package:bible_quiz/helper/Constants.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final VoidCallback? callback;
  final Color? backgroundColor;
  final bool tapAble;
  final String? text;
  final double? height;
  final Widget? content;
  final double widthPercentage;
  final EdgeInsets edgeInset;

  CustomCard({Key? key, this.callback, this.backgroundColor, required this.tapAble, required this.text, required this.height, this.widthPercentage = 1.0, this.edgeInset = const EdgeInsets.all(12.0)})
      : this.content = null,
        super(key: key);

  CustomCard.withContent({Key? key, this.callback, this.backgroundColor, required this.tapAble, required this.content, required this.height, this.widthPercentage = 1.0, this.edgeInset = const EdgeInsets.all(12.0)})
      : this.text = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    var textColor = themeData.textTheme.bodyLarge?.color;
    if (backgroundColor == Constants.cardHeadlineColor) {
      textColor = themeData.textTheme.displayLarge?.color;
    }
    var width = MediaQuery.of(context).size.width * widthPercentage;

    return Card(
      clipBehavior: Clip.antiAlias,
      color: backgroundColor ?? themeData.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: !tapAble
          ? Container(
              //question container
              alignment: Alignment.center,
              height: height,
              width: width,
              padding: edgeInset,
              child: content == null
                  ? Text(
                      text!,
                      style: TextStyle(fontSize: 14, color: textColor),
                    )
                  : content,
            )
          : ElevatedButton(
        //answer button
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black, backgroundColor: backgroundColor ?? themeData.cardColor, // foreground
        ),
        child: Container(
          color: backgroundColor ?? themeData.cardColor,
                alignment: Alignment.center,
                height: height,
                width: width,
                padding: edgeInset,
                child: content == null
                    ? Text(
                        text!,
                        style: TextStyle(color: textColor),
                      )
                    : content,
              ),
        onPressed: callback,
      ),
    );
  }
}
