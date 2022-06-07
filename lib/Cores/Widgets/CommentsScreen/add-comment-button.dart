import 'package:flutter/material.dart';

import 'new-comment.dart';

class AddCommentButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final Color _mainFontColor = _theme.primaryColor;
    final _media = MediaQuery.of(context);
    final double _devicewidth = _media.size.width;
    final double _deviceWidthBlockSize = _devicewidth / 100;

    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.only(left: 40),
        child: CircleAvatar(
          radius: 6 * _deviceWidthBlockSize,
          backgroundColor: _mainFontColor,
          child: IconButton(
            icon: Icon(Icons.add),
            onPressed: () => showDialog(

              context: context,
              builder: (context)=> AlertDialog(
                content: Container(child: NewComment()),
                contentPadding: EdgeInsets.all(15),
              ),
            ),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
