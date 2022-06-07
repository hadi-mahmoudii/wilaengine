import 'package:flutter/material.dart';

import '../../../Cores/Config/app_session.dart';

class MessageRow extends StatelessWidget {
  final String numberSender;
  final String date;
  final String index;
  final String message;

  const MessageRow({
    Key key,
    @required this.numberSender,
    @required this.date,
    @required this.index,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFEB5E00),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Text(
                  numberSender,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 3.5 * AppSession.deviceBlockSize,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Spacer(),
              Text(
                date,
                style: TextStyle(
                  color: Color(0xFFEB5E00),
                  fontSize: 3.5 * AppSession.deviceBlockSize,
                ),
                textDirection: TextDirection.rtl,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                index,
                style: TextStyle(
                  color: Color(0xFFEB5E00),
                  fontFamily: 'montserrat',
                  fontSize: 8 * AppSession.deviceBlockSize,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                width: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFEB5E00),
                ),
                child: Text(' '),
              )
            ],
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: Text(
              message,
              textDirection: TextDirection.rtl,
              style: TextStyle(color: Color(0xFF707070)),
            ),
          ),
        ],
      ),
    );
  }
}
