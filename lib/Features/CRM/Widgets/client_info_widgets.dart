import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../Cores/Config/app_session.dart';

class HBDRow extends StatelessWidget {
  final String birthDay;
  final String labelName;

  const HBDRow({
    Key key,
    @required this.birthDay,
    @required this.labelName,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            width: (AppSession.deviceWidth - 50) * .5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      'عنوان مشتری',
                      style: TextStyle(color: Colors.grey),
                      textAlign: TextAlign.end,
                      textDirection: TextDirection.rtl,
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Icon(
                      FontAwesomeIcons.tags,
                      color: Colors.grey,
                      size: 4 * AppSession.deviceBlockSize,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  labelName,
                  style: TextStyle(fontSize: 5 * AppSession.deviceBlockSize),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            width: (AppSession.deviceWidth - 50) * .5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      'سالروز تولد',
                      style: TextStyle(color: Colors.grey),
                      textAlign: TextAlign.end,
                      textDirection: TextDirection.rtl,
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Icon(
                      FontAwesomeIcons.birthdayCake,
                      color: Colors.grey,
                      size: 4 * AppSession.deviceBlockSize,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  birthDay,
                  style: TextStyle(fontSize: 5 * AppSession.deviceBlockSize),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DataRow extends StatelessWidget {
  final String title;
  final String value;
  final Color mainColor;

  const DataRow({
    Key key,
    @required this.title,
    @required this.value,
    this.mainColor = Colors.white,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: mainColor),
          bottom: BorderSide(color: mainColor),
        ),
        color: mainColor.withOpacity(.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            width: (AppSession.deviceWidth - 50) * .5,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 5 * AppSession.deviceBlockSize,
              ),
            ),
          ),
          Spacer(),
          Text(
            title,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 5 * AppSession.deviceBlockSize,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}

class AddressRow extends StatelessWidget {
  final String city;
  final String number;
  final String address;
  final String postalCode;
  final String index;
  const AddressRow({
    Key key,
    @required this.city,
    @required this.number,
    @required this.address,
    @required this.postalCode,
    @required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Color(
            0xFFA5A5A5,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                width: AppSession.deviceWidth * .7,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      flex: 2,
                      child: Text(
                        number,
                        style: TextStyle(fontFamily: 'montserrat'),
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Text(
                        city,
                        style:
                            TextStyle(fontSize: 5 * AppSession.deviceBlockSize),
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: AppSession.deviceWidth * .7,
                      child: Text(
                        address,
                        // textAlign: TextAlign.end,
                        textDirection: TextDirection.rtl,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          color: Color(0xFF707070),
                          fontSize: 3 * AppSession.deviceBlockSize,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    postalCode,
                    style: TextStyle(
                      fontFamily: 'montserrat',
                      fontSize: 3 * AppSession.deviceBlockSize,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  Text(
                    'کدپستی : ',
                    style: TextStyle(
                      color: Color(0xFF707070),
                      fontSize: 3 * AppSession.deviceBlockSize,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            ],
          ),
          Text(
            index,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFC5C5C5),
              fontFamily: 'montserrat',
              fontSize: index.length > 1
                  ? AppSession.deviceBlockSize * 8
                  : AppSession.deviceBlockSize * 12,
            ),
          )
        ],
      ),
    );
  }
}

class NumberRow extends StatelessWidget {
  final String label;
  final String number;
  final String index;
  const NumberRow({
    Key key,
    @required this.label,
    @required this.number,
    @required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1, horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Color(
            0xFFA5A5A5,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                width: AppSession.deviceWidth * .7,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      number,
                      style: TextStyle(fontFamily: 'montserrat'),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        label,
                        style: TextStyle(
                          fontSize: 5 * AppSession.deviceBlockSize,
                          color: Color(0xFF707070),
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            index,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFC5C5C5),
              fontFamily: 'montserrat',
              fontSize: index.length > 1
                  ? AppSession.deviceBlockSize * 8
                  : AppSession.deviceBlockSize * 12,
            ),
          )
        ],
      ),
    );
  }
}
