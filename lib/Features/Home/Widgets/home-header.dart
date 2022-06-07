import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../Cores/Config/app_session.dart';
import '../../../Cores/Config/routes.dart';
import '../../../Cores/Widgets/header2.dart';
import '../../Auth/Entities/auth.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      margin: EdgeInsets.only(bottom: 25),
      // width: 100,
      // height: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFc5c5c5), Color(0xFFe3e3e3)],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.0, 1.0),
          stops: [0.0, 1.0],
          // tileMode: TileMode.repeated,
        ),
        border: Border(
          bottom: BorderSide(color: Colors.black, width: 2),
        ),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text(
                        'خروج',
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                      ),
                      content: Text(
                        'خروج از حساب کاربری؟',
                        textDirection: TextDirection.rtl,
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(
                            'خیر',
                            style: TextStyle(fontFamily: 'montserrat'),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            AuthEntity().logout();
                            Navigator.of(context)
                                .pushReplacementNamed(Routes.loginScreen);
                          },
                          child: Text(
                            'بله',
                            style: TextStyle(fontFamily: 'montserrat'),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Icon(
                    FontAwesomeIcons.signOutAlt,
                    size: 8 * AppSession.deviceBlockSize,
                  ),
                ),
              ),
              Spacer(),
              Container(
                // width: 300,
                child: SimpleHeader2('خوش آمدید', 'Home'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
