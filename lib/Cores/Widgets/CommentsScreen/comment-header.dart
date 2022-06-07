import 'package:flutter/material.dart';

class CommentsHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context);
    final double _devicewidth = _media.size.width;
    final double _deviceWidthBlockSize = _devicewidth / 100;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: <Widget>[
          Text(
            '27',
            style: TextStyle(
              fontSize: 8 * _deviceWidthBlockSize,
              fontFamily: 'montserrat',
            ),
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                'نظرات کاربران',
                style: TextStyle(
                  fontFamily: 'iranyekan',
                  fontSize: 6 * _deviceWidthBlockSize,
                  fontWeight: FontWeight.w700,
                ),
                textDirection: TextDirection.rtl,
              ),
              Text(
                'COMMENTS',
                style: TextStyle(
                  fontFamily: 'montserrat',
                  letterSpacing: 5,
                  color: Colors.grey,
                  fontSize: 4 * _deviceWidthBlockSize,
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
