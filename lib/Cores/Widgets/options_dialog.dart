import 'package:flutter/material.dart';

import 'header2.dart';


class OptionsDialog extends StatefulWidget {
  @override
  _OptionsDialogState createState() => _OptionsDialogState();
}

class _OptionsDialogState extends State<OptionsDialog> {
  TextEditingController _curValue = new TextEditingController();
  final String pName = 'کابل میکرو یو اس بی';
  final String eName = 'MICRO USB CABLE';

  var totalOrgPrice = '680000';
  var totalOffPrice = '20000';
  var totalBalancePrice = '660000';
  String offPercent = '15';

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final Color _mainColor = _theme.primaryColor;
    final _media = MediaQuery.of(context);
    final double _devicewidth = _media.size.width;
    final double _deviceWidthBlockSize = _devicewidth / 100;
    return Container(
      height: 400,
      child: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: SimpleHeader2('گزینه های دلخواه', 'OPTION'),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: Colors.black12,
                    ),
                  ),
                ),
                child: SelectorBox(
                  deviceBlockSize: _deviceWidthBlockSize,
                  packageCTRL: _curValue,
                  datas: [
                    {'name': 'شکلات زیاد', 'value': '15000'},
                    {'name': 'شکلات کم', 'value': '12000'},
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      'شکلات',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontSize: 6 * _deviceWidthBlockSize,
                      ),
                    ),
                    Text(
                      'CHOCLATE',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontFamily: 'montserrat',
                        fontSize: 3 * _deviceWidthBlockSize,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(
            height: 20,
          ),
          CardPricesBox(
            deviceBlockSize: _deviceWidthBlockSize,
            totalOrgPrice: totalOrgPrice,
            totalOffPrice: totalOffPrice,
            totalBalancePrice: totalBalancePrice,
            deviceWidth: _devicewidth,
            offPercent: offPercent,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(
              left: 2 * _deviceWidthBlockSize,
              right: 28 * _deviceWidthBlockSize,
            ),
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.black,
              ),
              color: _mainColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'افزودن آپشن ها به محصول',
                  style: TextStyle(
                    fontSize: 4 * _deviceWidthBlockSize,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          // ItemCard(deviceBlockSize: _deviceWidthBlockSize, pName: pName, eName: eName, itemOrgPrice: _itemOrgPrice, itemOffPrice: _itemOffPrice),
        ],
      ),
    );
  }
}

class CardPricesBox extends StatelessWidget {
  const CardPricesBox({
    Key key,
    @required double deviceBlockSize,
    @required this.totalOrgPrice,
    @required this.totalOffPrice,
    @required this.totalBalancePrice,
    @required this.deviceWidth,
    @required this.offPercent,
  })  : _deviceWidthBlockSize = deviceBlockSize,
        super(key: key);

  final double _deviceWidthBlockSize;
  final String totalOrgPrice;
  final String totalOffPrice;
  final String totalBalancePrice;
  final double deviceWidth;
  final String offPercent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Divider(
          height: .1,
          color: Colors.grey,
        ),
        Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: deviceWidth * .4,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: Colors.grey,
                          ), // provides to left side
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(bottom: 3),
                            child: Text(
                              'تومان',
                              style: TextStyle(
                                fontSize: 2.5 * _deviceWidthBlockSize,
                                color: Color.fromRGBO(0, 0, 70, 2),
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                          Container(
                            width: deviceWidth * .3,
                            child: Text(
                              totalOrgPrice,
                              style: TextStyle(
                                fontFamily: 'montserrat',
                                fontSize: 4 * _deviceWidthBlockSize,
                                fontWeight: FontWeight.w700,
                                color: Color.fromRGBO(0, 0, 70, 2),
                              ),
                              textDirection: TextDirection.ltr,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  width: deviceWidth * .25,
                  child: Text(
                    'مبلغ کل آپشن ها',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 4 * _deviceWidthBlockSize,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: .05,
          color: Colors.red,
        ),
        Container(
          // color: Color.fromRGBO(235, 235, 235, 2),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: deviceWidth * .4,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: Colors.grey,
                          ), // provides to left side
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(bottom: 3),
                            child: Text(
                              'تومان',
                              style: TextStyle(
                                fontSize: 2.5 * _deviceWidthBlockSize,
                                color: Colors.red,
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                          Container(
                            child: Text(
                              totalOffPrice,
                              style: TextStyle(
                                fontFamily: 'montserrat',
                                fontSize: 4 * _deviceWidthBlockSize,
                                fontWeight: FontWeight.w700,
                                color: Colors.red,
                              ),
                              textDirection: TextDirection.ltr,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 5, left: 2),
                            padding: EdgeInsets.symmetric(
                              horizontal: 2,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(7),
                                topLeft: Radius.circular(7),
                                bottomRight: Radius.circular(7),
                              ),
                              color: Colors.redAccent,
                            ),
                            child: Text(
                              '%$offPercent',
                              style: TextStyle(
                                fontFamily: 'montserrat',
                                fontSize: 2.5 * _deviceWidthBlockSize,
                                color: Colors.white,
                              ),
                              textDirection: TextDirection.ltr,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  width: deviceWidth * .25,
                  child: Text(
                    'تخفیف',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 4 * _deviceWidthBlockSize,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: .1,
          color: Color.fromRGBO(0, 0, 70, 2),
        ),
        Container(
          color: Color.fromRGBO(0, 30, 60, 2),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: deviceWidth * .4,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: Colors.grey,
                          ), // provides to left side
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(bottom: 3),
                            child: Text(
                              'تومان',
                              style: TextStyle(
                                fontSize: 2.5 * _deviceWidthBlockSize,
                                color: Colors.white,
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                          Container(
                            width: deviceWidth * .3,
                            child: Text(
                              totalBalancePrice,
                              style: TextStyle(
                                fontFamily: 'montserrat',
                                fontSize: 5 * _deviceWidthBlockSize,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                              textDirection: TextDirection.ltr,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  width: deviceWidth * .25,
                  child: Text(
                    'مبلغ افزوده شده',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 4 * _deviceWidthBlockSize,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: .1,
          color: Colors.grey,
        ),
      ],
    );
  }
}

class SelectorBox extends StatefulWidget {
  const SelectorBox({
    Key key,
    @required List<Map<String, String>> datas,
    @required double deviceBlockSize,
    @required this.packageCTRL,
  })  : _deviceBlockSize = deviceBlockSize,
        _datas = datas,
        super(key: key);

  final double _deviceBlockSize;
  final List<Map<String, String>> _datas;

  final TextEditingController packageCTRL;

  @override
  _SelectorBoxState createState() => _SelectorBoxState();
}

class _SelectorBoxState extends State<SelectorBox> {
  String curValue = '';

  @override
  void initState() {
    widget.packageCTRL.text = widget._datas[0]['name'];
    curValue = widget._datas[0]['value'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: 65,
      width: 52 * widget._deviceBlockSize,
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: <Widget>[
          Column(
            // crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                    width: widget._deviceBlockSize,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: 5.5 * widget._deviceBlockSize,
                    ),
                    child: Text(
                      'انتخاب کنید',
                      style: TextStyle(
                        fontSize: 3.5 * widget._deviceBlockSize,
                        color: Colors.grey,
                        fontWeight: FontWeight.w700,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ],
              ),
              Container(
                width: 52 * widget._deviceBlockSize,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        // height: 30,
                        child: DropdownButtonFormField(
                          style: TextStyle(
                            fontSize: 3 * widget._deviceBlockSize,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: widget._deviceBlockSize),
                            isDense: true,
                            // border: InputBorder.none,
                          ),
                          iconSize: 7 * widget._deviceBlockSize,
                          icon: Icon(
                            Icons.expand_more,
                            color: Colors.grey,
                          ),
                          isExpanded: true,
                          hint: Container(
                            width: deviceWidth * .4,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: deviceWidth * .2,
                                  child: Text(
                                    widget.packageCTRL.text,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  width: deviceWidth * .15,
                                  child: Text(
                                    curValue,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontFamily: 'montserrat',
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Text(
                                  '+',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                          isDense: true,
                          items: widget._datas.map((val) {
                            return new DropdownMenuItem<String>(
                              value: val['name'],
                              child: Container(
                                // width: double.infinity,
                                width: deviceWidth * .5,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      '+',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    Container(
                                      width: deviceWidth * .2,
                                      child: Text(
                                        val['value'],
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontFamily: 'montserrat',
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      width: deviceWidth * .25,
                                      child: Text(
                                        val['name'],
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (val) {
                            setState(() {
                              widget.packageCTRL.text = val;
                              widget._datas.forEach((data) {
                                if (data['name'] == val) {
                                  curValue = data['value'];
                                }
                              });
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: widget._deviceBlockSize,
                    ),
                    Icon(
                      Icons.format_align_right,
                      size: 5 * widget._deviceBlockSize,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
