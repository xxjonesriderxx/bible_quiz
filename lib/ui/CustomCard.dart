import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final VoidCallback callback;
  final Color backgroundColor;
  final bool tapAble;
  final String text;
  final double height;

  const CustomCard(
      {Key key,
      this.callback,
      this.backgroundColor,
      this.tapAble,
      this.text,
      this.height})
      : super(key: key);

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
                style: TextStyle(fontSize: 14, color: themeData.accentColor),
              ),
      )
          : ElevatedButton(
              //answer button
              style: ElevatedButton.styleFrom(
                primary: backgroundColor ?? themeData.cardColor, // background
                onPrimary: Colors.black, // foreground
              ),
              child: Container(
                color: backgroundColor ?? themeData.cardColor,
                alignment: Alignment.center,
                height: height,
                padding: EdgeInsets.all(16),
                child: Text(
                  text,
                  style: TextStyle(color: themeData.accentColor),
                ),
              ),
              onPressed: callback,
            ),
    );
  }
}
