import 'package:flutter/material.dart';

class DialogHelper {
  static final DialogHelper _instance = DialogHelper._internal();

  factory DialogHelper() => _instance;

  DialogHelper._internal();

  void showInformationDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
