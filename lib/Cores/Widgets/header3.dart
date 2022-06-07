import 'package:flutter/material.dart';

import '../Config/app_session.dart';

class SimpleHeader3 extends StatelessWidget {
  final String persian;
  final String english;
  final IconData icon;
  SimpleHeader3({
    @required this.persian,
    @required this.english,
    @required this.icon,
  });
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final Color _mainFontColor = _theme.primaryColor;
    // final _media = MediaQuery.of(context);
    // final double _devicewidth = _media.size.width;
    // final double _deviceBlockSize = _devicewidth / 100;
    return Container(
      margin: EdgeInsets.only(bottom: 2 * AppSession.deviceBlockSize),
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            size: 9 * AppSession.deviceBlockSize,
          ),
          Spacer(),
          Column(
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
              ),
              Text(
                english.toUpperCase(),
                style: TextStyle(
                  fontFamily: 'montserrat',
                  letterSpacing: AppSession.deviceBlockSize,
                  color: Colors.grey,
                  fontSize: 3.5 * AppSession.deviceBlockSize,
                ),
                textDirection: TextDirection.rtl,
              ),
            ],
          )
        ],
      ),
    );
  }
}
