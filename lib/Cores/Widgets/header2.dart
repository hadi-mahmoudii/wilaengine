import 'package:flutter/material.dart';

import '../Config/app_session.dart';

class SimpleHeader2 extends StatelessWidget {
  // this header have no icon
  final String persian;
  final String english;
  SimpleHeader2(this.persian, this.english);
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final Color _mainFontColor = _theme.primaryColor;
    // final Color _secondFontColor = Colors.grey;
    // final _media = MediaQuery.of(context);
    // final double _pixelRatio = (_media.size.height / _media.size.width * 7 / 5);
    // final double _devicewidth = _media.size.width;
    // final double _deviceBlockSize = _devicewidth / 100;
    return Container(
        // padding: EdgeInsets.only(right: 20,top: 8),
        // padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text(
          persian,
          style: TextStyle(
            fontSize: 6 * AppSession.deviceBlockSize,
            fontWeight: FontWeight.w700,
            color: _mainFontColor,
          ),
          textDirection: TextDirection.rtl,
          // textScaleFactor: _pixelRatio,
        ),
        Text(
          english.toUpperCase(),
          style: TextStyle(
            fontFamily: 'montserrat',
            letterSpacing: 4,
            color: Colors.black,
            fontSize: 3.5 * AppSession.deviceBlockSize,
          ),
          textDirection: TextDirection.rtl,
          // textScaleFactor: _pixelRatio,
        ),
      ],
    ));
  }
}
