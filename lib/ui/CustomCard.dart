import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final VoidCallback? callback;
  final Color? backgroundColor;
  final bool tapAble;
  final String text;
  final double height;

  const CustomCard({Key? key, this.callback, this.backgroundColor, required this.tapAble, required this.text, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
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
              padding: EdgeInsets.all(16),
              child: Text(
                text,
                style: TextStyle(fontSize: 14, color: themeData.textTheme.bodyLarge?.color),
              ),
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
                padding: EdgeInsets.all(16),
                child: Text(
                  text,
                  style: TextStyle(color: themeData.textTheme.bodyLarge?.color),
                ),
              ),
              onPressed: callback,
            ),
    );
  }
}
