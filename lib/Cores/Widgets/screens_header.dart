import 'package:flutter/material.dart';

import 'global-appbar.dart';
import 'header2.dart';

class GlobalScreensHeader extends StatelessWidget {
  final String backLabel;
  final String eName;
  final String pName;
  final IconData icon;

  const GlobalScreensHeader({
    Key key,
    @required this.backLabel,
    @required this.eName,
    @required this.pName,
    @required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      margin: EdgeInsets.only(bottom: 5),
      // width: 100,
      // height: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFc5c5c5), Color(0xFFe3e3e3)],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.0, 1.0),
          stops: [0.0, 1.0],
          // tileMode: TileMode.repeated,
        ),
        border: Border(
          bottom: BorderSide(color: Colors.black, width: 2),
        ),
      ),
      child: Column(
        children: <Widget>[
          backLabel != ''
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SimpleAppbar(backLabel),
                )
              : SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: eName == ''
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
              children: <Widget>[
                Icon(icon),
                Spacer(),
                SimpleHeader2(pName, eName),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
