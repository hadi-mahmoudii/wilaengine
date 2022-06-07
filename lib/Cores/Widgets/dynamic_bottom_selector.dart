import 'package:flutter/material.dart';

import '../Config/app_session.dart';
import 'input_box.dart';

class DynamicBottomSelector extends StatefulWidget {
  final Color color;
  final IconData icon;
  final String label;
  final Function function;
  final TextEditingController controller;
  // final BuildContext ctx;
  final bool enable;

  const DynamicBottomSelector({
    Key key,
    @required this.color,
    @required this.label,
    @required this.controller,
    @required this.icon,
    // @required this.ctx,
    this.function,
    this.enable = true,
  }) : super(key: key);

  @override
  _DynamicBottomSelectorState createState() => _DynamicBottomSelectorState();
}

class _DynamicBottomSelectorState extends State<DynamicBottomSelector> {
  bool isTapped = false;
  List<String> datas = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InputBox(
      color: widget.color,
      icon: widget.icon,
      label: widget.label,
      controller: widget.controller,
      readOnly: true,
      onTapFunction: () async {
        await showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          builder: (mainCtx) => Container(
            padding: EdgeInsets.all(10),
            color: Colors.transparent,
            constraints: BoxConstraints(maxHeight: AppSession.deviceHeigth / 2),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: FocusScope(
                      onFocusChange: (val) {
                        setState(() {
                          isTapped = val;
                        });
                      },
                      child: TextField(
                        controller: widget.controller,
                        enabled: widget.enable,
                        // readOnly: true,
                        // onTap: () async {},
                        onChanged: (value) {
                          // datas = [];
                          // widget.datas.forEach((element) {
                          //   if (element.contains(value)) datas.add(element);
                          // });
                          // setState(() {});
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 5),
                          isDense: true,
                          border: InputBorder.none,
                          labelText: widget.label,
                          labelStyle: TextStyle(
                            fontSize: 3 * AppSession.deviceBlockSize,
                            color: isTapped
                                ? widget.color
                                : widget.color.withOpacity(.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: widget.color,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: widget.color.withOpacity(.5),
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          suffixIcon: InkWell(
                            onTap: widget.function ?? widget.function,
                            child: Icon(
                              Icons.search,
                              color: isTapped
                                  ? widget.color
                                  : widget.color.withOpacity(.5),
                            ),
                          ),
                        ),
                        cursorColor: widget.color,
                        style: TextStyle(
                          fontSize: 5 * AppSession.deviceBlockSize,
                          color: widget.color,
                        ),
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.end,
                        minLines: 1,
                        maxLines: 3,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, ind) => Container(
                      child: InkWell(
                        onTap: () {
                          widget.controller.text = datas[ind];
                          Navigator.of(mainCtx).pop();
                        },
                        child: Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Text(
                            datas[ind],
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              color: AppSession.mainFontColor,
                              fontSize: 4 * AppSession.deviceBlockSize,
                            ),
                          ),
                        ),
                      ),
                    ),
                    itemCount: datas.length,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
