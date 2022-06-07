import 'package:flutter/material.dart';

import '../Config/app_session.dart';

class ClosableHeader extends StatelessWidget {
  final String persian;
  final String english;
  final BuildContext ctx;
  ClosableHeader({
    @required this.persian,
    @required this.english,
    @required this.ctx,
  });
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final Color _mainFontColor = _theme.primaryColor;
    return Container(
      margin: EdgeInsets.only(bottom: 2 * AppSession.deviceBlockSize),
      // padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: () => Navigator.of(ctx).pop(),
            child: Icon(
              Icons.close,
              size: 7.5 * AppSession.deviceBlockSize,
            ),
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                persian,
                style: TextStyle(
                  fontSize: 4.5 * AppSession.deviceBlockSize,
                  fontWeight: FontWeight.w700,
                  color: _mainFontColor,
                ),
                textDirection: TextDirection.rtl,
              ),
              Text(
                english,
                style: TextStyle(
                  fontFamily: 'montserrat',
                  letterSpacing: AppSession.deviceBlockSize,
                  color: Colors.grey,
                  fontSize: 2.5 * AppSession.deviceBlockSize,
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
