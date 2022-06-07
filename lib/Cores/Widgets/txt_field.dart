import 'package:flutter/material.dart';

import '../Config/app_session.dart';

class TXTFeild extends StatelessWidget {
  final String label;
  final TextEditingController textCtrl;
  final IconData icon;
  final TextInputType keyType;
  final int minline;
  final int maxline;
  final currentFocosNode;
  final nextFocosNode;
  final TextInputAction inputAction;
  final Function validate;
  final bool readOnly;
  final double marginLeft;
  final double marginRight;

  const TXTFeild({
    Key key,
    @required this.label,
    @required this.textCtrl,
    @required this.icon,
    @required this.validate,
    this.minline,
    this.maxline,
    this.keyType,
    this.currentFocosNode,
    this.nextFocosNode,
    this.inputAction,
    this.readOnly = false,
    this.marginRight = 25,
    this.marginLeft = 25,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: marginLeft,
        right: marginRight,
        top: 10,
        bottom: 10,
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          validator: validate,
          controller: textCtrl,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 0),
            labelText: label,
            labelStyle: TextStyle(
              fontFamily: 'iranyekan',
              fontSize: 4 * AppSession.deviceBlockSize,
            ),
            suffixIcon: Icon(
              icon,
              size: 7 * AppSession.deviceBlockSize,
            ),
            isDense: true,
          ),
          textInputAction: inputAction,
          onFieldSubmitted: (_) {
            try {
              FocusScope.of(context).requestFocus(nextFocosNode);
            } catch (e) {}
          },
          readOnly: readOnly,
          focusNode: currentFocosNode,
          style: TextStyle(fontSize: 5 * AppSession.deviceBlockSize),
          keyboardType: keyType != null ? keyType : TextInputType.text,
          minLines: minline != null ? minline : 1,
          maxLines: maxline != null ? maxline : 1,
        ),
      ),
    );
  }
}
