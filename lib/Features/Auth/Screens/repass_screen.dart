import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../Cores/Config/routes.dart';
import '../../../Cores/Models/request_result.dart';
import '../../../Cores/Widgets/alert_dialog.dart';
import '../../../Cores/Widgets/header2.dart';
import '../../../Cores/Widgets/loading_widget.dart';
import '../Entities/auth.dart';

class RePassScreen extends StatefulWidget {
  @override
  _RePassScreenState createState() => _RePassScreenState();
}

class _RePassScreenState extends State<RePassScreen> {
  bool isLoading = false;
  TextEditingController _password = new TextEditingController();
  TextEditingController _rePassword = new TextEditingController();
  static GlobalKey<FormState> _form = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final Color _mainFontColor = _theme.primaryColor;
    final _media = MediaQuery.of(context);
    final double _devicewidth = _media.size.width;
    final double _deviceBlockSize = _devicewidth / 100;
    final double _deviceHeight = _media.size.height;
    final double _deviceHeightBlockSize = _deviceHeight / 100;
    return Scaffold(
      body: ListView(
        children: <Widget>[
          RePassScreenHeader(deviceBlockSize: _deviceBlockSize),
          // Image.asset(
          //   'assets/Images/signin.png',
          //   height: 30 * _deviceHeightBlockSize,
          //   width: 30 * _deviceHeightBlockSize,
          //   fit: BoxFit.fitWidth,
          // ),
          SizedBox(
            height: 2 * _deviceHeightBlockSize,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: <Widget>[
                Spacer(),
                InkWell(
                  // padding: EdgeInsets.symmetric(vertical: 5),
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    padding: EdgeInsets.only(
                      top: 10,
                      left: 20,
                      bottom: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text('ورود'),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 3 * _deviceBlockSize,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: SimpleHeader2('رمز عبور جدید', 'NEW PASSWORD'),
          ),
          SizedBox(
            height: 20,
          ),
          isLoading
              ? LoadingWidget(mainFontColor: _mainFontColor)
              : Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: _form,
                    child: Column(
                      children: <Widget>[
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextFormField(
                            validator: (value) {
                              if (value.length < 8) {
                                return 'طول رمز باید حداقل 8 کاراکتر باشد.';
                              }
                              return null;
                            },
                            controller: _password,
                            decoration: InputDecoration(
                              icon: SizedBox(
                                width: 10,
                                height: 20,
                                child: Icon(
                                  FontAwesomeIcons.lock,
                                  size: 5 * _deviceBlockSize,
                                ),
                              ),
                              labelStyle: TextStyle(fontFamily: 'iranyekan'),
                              labelText: 'کلمه ی عبور',
                              isDense: true,
                            ),
                            style: TextStyle(fontFamily: 'montserrat'),
                            obscureText: true,
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.right,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        SizedBox(
                          height: _deviceHeightBlockSize,
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextFormField(
                            validator: (value) {
                              if (value.length < 8) {
                                return 'طول رمز باید حداقل 8 کاراکتر باشد.';
                              }
                              if (value != _password.text) {
                                return 'پسورد ها یکسان نیستند.';
                              }
                              return null;
                            },
                            controller: _rePassword,
                            decoration: InputDecoration(
                              icon: SizedBox(
                                width: 10,
                                height: 20,
                                child: Icon(
                                  FontAwesomeIcons.lock,
                                  size: 5 * _deviceBlockSize,
                                ),
                              ),
                              labelStyle: TextStyle(fontFamily: 'iranyekan'),
                              labelText: 'تکرار کلمه ی عبور',
                              isDense: true,
                            ),
                            style: TextStyle(fontFamily: 'montserrat'),
                            obscureText: true,
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.right,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: IgnorePointer(
              ignoring: isLoading,
              child: InkWell(
                onTap: () async {
                  if (!_form.currentState.validate()) {
                    return;
                  }
                  print(_password.text);
                  await AuthEntity()
                      .sendRePass(_password.text)
                      .then((result) async {
                    if (result == RequestResult.Accept) {
                      await showDialog(
                        context: context,
                        builder: (ctx) => GlobalAlertDialog(
                          title: '',
                          content: 'رمز شما با موفقیت تغییر یافت.',
                        ),
                      );
                    } else {
                      await showDialog(
                        context: context,
                        builder: (ctx) => GlobalAlertDialog(
                          title: 'خطا',
                          content:
                              'متاسفانه خطایی رخ داده است.دقایقی دیگر امتحان کنید!',
                        ),
                      );
                    }
                    Navigator.of(context).pushReplacementNamed(
                      Routes.loginScreen,
                    );
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(
                    top: 4 * _deviceHeightBlockSize,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: LinearGradient(
                      colors: [Color(0xFFee3552), Color(0xFFeb5e00)],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      // tileMode: TileMode.repeated,
                    ),
                  ),
                  height: 40,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'تنظیم مجدد',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}

class RePassScreenHeader extends StatelessWidget {
  const RePassScreenHeader({
    Key key,
    @required double deviceBlockSize,
  })  : _deviceBlockSize = deviceBlockSize,
        super(key: key);

  final double _deviceBlockSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFc5c5c5), Color(0xFFe3e3e3)],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.0, 1.0),
          stops: [0.0, 1.0],
          // tileMode: TileMode.repeated,
        ),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/Icons/key.png',
              color: Colors.black,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "KEEP IT",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: _deviceBlockSize * 7.5,
                    fontFamily: 'montserrat',
                  ),
                ),
                Text(
                  "SAFE",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: _deviceBlockSize * 7.5,
                    fontFamily: 'montserrat',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
