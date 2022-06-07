import 'package:flutter/material.dart';

import '../Config/app_session.dart';

class InputBox extends StatefulWidget {
  final Color color;
  final IconData icon;
  final String label;
  final Function function;
  final Function onTapFunction;
  final TextEditingController controller;
  final bool enable;
  final TextInputType textType;
  final bool readOnly;
  final int minLines;
  final int maxLines;
  final bool mustFill;
  final bool isSecure;
  final String fontFamily;
  final String labelFontFamily;
  final Function validator;
  final IconData seconderyIcon;

  const InputBox({
    Key key,
    @required this.color,
    @required this.icon,
    @required this.label,
    @required this.controller,
    this.function,
    this.onTapFunction,
    this.enable = true,
    this.textType = TextInputType.text,
    this.readOnly = false,
    this.minLines = 1,
    this.maxLines = 5,
    this.mustFill = false,
    this.isSecure = false,
    this.fontFamily = 'iranyekan',
    this.labelFontFamily = 'iranyekan',
    this.validator,
    this.seconderyIcon,
  }) : super(key: key);

  @override
  _InputBoxState createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  bool isTapped = false;
  Function validator;
  @override
  void initState() {
    //this use for set default validator
    if (widget.validator != null)
      validator = widget.validator;
    else
      validator = (value) {
        return null;
      };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(vertical: 10),
      color: Colors.transparent,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: FocusScope(
          onFocusChange: (val) {
            setState(() {
              isTapped = val;
            });
          },
          child: TextFormField(
            controller: widget.controller,
            enabled: widget.enable,
            readOnly: widget.readOnly,
            obscureText: widget.isSecure,
            onTap: widget.onTapFunction != null
                ? () async {
                    widget.onTapFunction();
                  }
                : () {},
            validator: validator,
            // validator: (value) {
            // if (widget.mustFill) {
            // if (value.isEmpty) {
            //   return 'لطفا این فیلد را پرکنید';
            // } else {
            //   return null;
            // }
            // } else {
            //   return null;
            // }
            // },
            decoration: InputDecoration(
              // contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
              isDense: true,
              // border: InputBorder.none,
              labelText: widget.label,
              labelStyle: TextStyle(
                fontSize: 3 * AppSession.deviceBlockSize,
                color: isTapped ? widget.color : widget.color.withOpacity(.5),
                fontFamily: widget.labelFontFamily,
              ),
              // focusedBorder: OutlineInputBorder(
              //   borderSide: BorderSide(
              //     color: widget.color,
              //   ),
              //   borderRadius: BorderRadius.circular(15),
              // ),
              // enabledBorder: OutlineInputBorder(
              //   borderSide: BorderSide(
              //     color: widget.color.withOpacity(.5),
              //   ),
              //   borderRadius: BorderRadius.circular(15),
              // ),
              // errorBorder: InputBorder.none,
              // disabledBorder: InputBorder.none,s
              prefixIcon: InkWell(
                onTap: widget.function ?? widget.function,
                child: Icon(
                  widget.icon,
                  color: isTapped ? widget.color : widget.color.withOpacity(.5),
                  size: 6 * AppSession.deviceBlockSize,
                ),
              ),
              suffixIcon: widget.seconderyIcon != null
                  ? Icon(
                      Icons.expand_more,
                      color: isTapped
                          ? widget.color
                          : widget.color.withOpacity(.5),
                      size: 7 * AppSession.deviceBlockSize,
                    )
                  : null,
            ),
            cursorColor: widget.color,
            style: TextStyle(
              fontSize: 5 * AppSession.deviceBlockSize,
              color: widget.color,
              fontFamily: widget.fontFamily,
            ),
            keyboardType: widget.textType,
            minLines: widget.minLines,
            maxLines: widget.maxLines,
          ),
        ),
      ),
    );
  }
}
