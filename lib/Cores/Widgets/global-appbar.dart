import 'package:flutter/material.dart';

import '../Config/app_session.dart';

class SimpleAppbar extends StatelessWidget {
  final String title;
  SimpleAppbar(this.title);
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final Color _mainFontColor = _theme.primaryColor;
    return InkWell(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        alignment: Alignment.topRight,
        padding: EdgeInsets.all(10),
        // margin: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: 3.5 * AppSession.deviceBlockSize,
                // fontWeight: FontWeight.w700,
                color: _mainFontColor,
              ),
              // textScaleFactor: _pixelRatio,
              textDirection: TextDirection.rtl,
            ),
            Container(
              margin: const EdgeInsets.only(left: 3.0),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 3 * AppSession.deviceBlockSize,
              ),
            )
          ],
        ),
      ),
    );
  }
}
