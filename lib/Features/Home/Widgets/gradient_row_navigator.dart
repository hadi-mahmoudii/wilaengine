import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Cores/Config/app_session.dart';

class GradientRowNavigator extends StatelessWidget {
  final Color mainColor;
  final Color firstColor;
  final Color secondColor;
  final String title;
  final IconData icon;
  final String number;
  final String routeName;
  const GradientRowNavigator({
    Key key,
    @required this.mainColor,
    @required this.firstColor,
    @required this.secondColor,
    @required this.title,
    @required this.icon,
    @required this.number,
    @required this.routeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(routeName);
    return InkWell(
      onTap: () =>
          routeName != '' ? Get.toNamed(routeName) : print('not rdy yet'),
      child: Container(
        // width: 100,
        // height: 200,
        margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(
            colors: [firstColor, secondColor],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            // tileMode: TileMode.repeated,
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                    color: mainColor, fontSize: 5 * AppSession.deviceBlockSize),
                // textAlign:TextAlign.right ,
                textDirection: TextDirection.rtl,
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                // width: 20 * AppSession.deviceBlockSize,
                // color: Colors.green,
                child: Column(
                  // mainAxisSize: MainAxisSize.max,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      icon,
                      color: mainColor,
                      size: 10 * AppSession.deviceBlockSize,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 2.5 * AppSession.deviceBlockSize),
                      child: Text(
                        number,
                        style: TextStyle(
                          color: mainColor,
                          fontFamily: 'montserrat',
                          fontSize: 2.5 * AppSession.deviceBlockSize,
                          // fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
