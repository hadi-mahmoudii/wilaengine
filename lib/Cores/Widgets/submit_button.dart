import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String title;
  final Function function;
  final Color color;
  final Color fontColor;

  const SubmitButton({
    Key key,
    @required this.title,
    @required this.function,
    this.color = Colors.transparent,
    this.fontColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                color: fontColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
