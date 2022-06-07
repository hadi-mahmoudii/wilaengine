import 'package:flutter/material.dart';

class GlobalAlertDialog extends StatelessWidget {
  final String title;
  final String content;

  const GlobalAlertDialog({Key key, this.title, this.content})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
      ),
      content: Text(
        content,
        textDirection: TextDirection.rtl,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child:
          Text(
            'OK',
            style: TextStyle(fontFamily: 'montserrat'),
          ),
        )
      ],
    );
  }
}
