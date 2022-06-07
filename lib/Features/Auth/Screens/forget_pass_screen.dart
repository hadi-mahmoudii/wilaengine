import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../Cores/Config/routes.dart';
import '../../../Cores/Models/request_result.dart';
import '../../../Cores/Widgets/alert_dialog.dart';
import '../../../Cores/Widgets/header2.dart';
import '../../../Cores/Widgets/loading_widget.dart';
import '../Entities/auth.dart';

class ForgetPassScreen extends StatefulWidget {
  @override
  _ForgetPassScreenState createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
  int timerValue = 60;
  bool isLoading = false;
  bool codeSended = false;
  Timer globalTimer;
  final TextEditingController _cellNumberCtrl = new TextEditingController();
  final TextEditingController _verificationCodeCtrl =
      new TextEditingController();
  static GlobalKey<FormState> _form = new GlobalKey<FormState>();
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    globalTimer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          // if(!this.mounted){
          //   timer.cancel();
          // }
          if (timerValue < 1) {
            timerValue = 60;
            timer.cancel();
          } else {
            setState(() {
              timerValue -= 1;
            });
          }
        },
      ),
    );
  }

  bool letTextBoxEnable() {
    if (!isLoading && !codeSended) {
      return true;
    } else {
      return false;
    }
  }

  bool letCodeBoxEnable() {
    if (!isLoading && codeSended) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> checkCode(String value) {
    setState(() {
      isLoading = true;
    });
    AuthEntity().verifyForgetPass(value).then((result) async {
      if (result == RequestResult.WrongCode) {
        await showDialog(
          context: context,
          builder: (ctx) => GlobalAlertDialog(
            title: 'کد نادرست',
            content: 'کد واردشده صحیح نمی باشد!',
          ),
        );
        Navigator.popAndPushNamed(context, Routes.forgetPassScreen);
      } else {
        Navigator.of(context).pushReplacementNamed(Routes.rePassScreen);
      }
      // setState(() {
      //   isLoading = false;
      //   codeSended = true;
      // });
    });
    return null;
  }

  Future<void> requestCode(String cellNumber) {
    setState(() {
      isLoading = true;
    });
    AuthEntity().forgetPass(cellNumber).then((result) {
      if (result == RequestResult.VerifyPhone) {
        setState(() {
          isLoading = false;
          codeSended = true;
        });
        startTimer();
      } else {
        showDialog(
          context: context,
          builder: (ctx) => GlobalAlertDialog(
            title: 'خطا',
            content: 'این شماره قبلا ثبت نام نکرده است!',
          ),
        );
        setState(() {
          isLoading = false;
          // codeSended = true;
        });
      }
    });
    return null;
  }

  @override
  void dispose() {
    try {
      globalTimer.cancel();
    } catch (e) {}
    _cellNumberCtrl.dispose();
    _verificationCodeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final Color _mainFontColor = _theme.primaryColor;
    // final Color _secondFontColor = _theme.accentColor;
    final _media = MediaQuery.of(context);
    final double _devicewidth = _media.size.width;
    final double _deviceBlockSize = _devicewidth / 100;
    final double _deviceHeight = _media.size.height;
    final double _deviceHeightBlockSize = _deviceHeight / 100;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              // SizedBox(
              //   height: 20,
              // ),
              // Image.asset(
              //   'assets/Images/forgetpass.png',
              //   height: 30 * _deviceHeightBlockSize,
              //   width: double.infinity,
              //   fit: BoxFit.fitWidth,
              //   // fit: BoxFit.contain,
              // ),
              ForgetPassScreenHeader(deviceBlockSize: _deviceBlockSize),
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
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: SimpleHeader2('بازیابی رمز عبور', 'PASSWORD RECOVERY'),
              ),
              SizedBox(
                height: 20,
              ),
              letTextBoxEnable()
                  ? Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Form(
                        key: _form,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextFormField(
                            validator: (value) {
                              if (value.length != 11) {
                                return 'شماره وارد شده صحیح نمی باشد!';
                              }
                              if (value[0] != '0' || value[1] != '9') {
                                return 'شماره وارد شده صحیح نمی باشد!';
                              }
                              return null;
                            },
                            controller: _cellNumberCtrl,
                            enabled: !isLoading,
                            readOnly: codeSended,
                            decoration: InputDecoration(
                              icon: SizedBox(
                                width: 10,
                                height: 20,
                                child: Icon(
                                  Icons.call,
                                  size: 5 * _deviceBlockSize,
                                ),
                              ),
                              labelText: 'شماره تماس خود را وارد نمایید',
                              isDense: true,
                            ),
                            textDirection: TextDirection.rtl,
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                      ),
                    )
                  : Container(),
              SizedBox(
                height: 5 * _deviceHeightBlockSize,
              ),
              isLoading
                  ? LoadingWidget(mainFontColor: _mainFontColor)
                  : Container(),
              letCodeBoxEnable()
                  ? Center(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'کد ارسال شده به شماره تماس خود را وارد نمایید.',
                            textDirection: TextDirection.rtl,
                          ),
                          Container(
                            width: 100,
                            child: TextFormField(
                              onChanged: (value) async {
                                if (value.length == 6) {
                                  await checkCode(value);
                                }
                              },
                              controller: _verificationCodeCtrl,
                              decoration: InputDecoration(isDense: true),
                              style: TextStyle(
                                fontFamily: 'montserrat',
                                letterSpacing: 5,
                              ),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              maxLength: 6,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: _deviceBlockSize * 50,
                            decoration: BoxDecoration(
                              color: Color(0xFFe3e3e3),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  'ارسال مجدد کد تا ${timerValue.toString()} ثانیه دیگر',
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    fontSize: 3 * _deviceBlockSize,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  width: _deviceBlockSize,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFc5c5c5),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15),
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 7, horizontal: 10),
                                  child: Icon(
                                    FontAwesomeIcons.starOfLife,
                                    size: 5 * _deviceBlockSize,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: InkWell(
                  onTap: () async {
                    if (!_form.currentState.validate()) {
                      return;
                    }
                    codeSended
                        ? await checkCode(_verificationCodeCtrl.text)
                        : await requestCode(_cellNumberCtrl.text);
                    // Navigator.of(context)
                    //     .pushReplacementNamed(Routes.rePassScreen);
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
                        'تایید',
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
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgetPassScreenHeader extends StatelessWidget {
  const ForgetPassScreenHeader({
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
            Icon(
              Icons.refresh,
              color: Colors.black,
              size: _deviceBlockSize * 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "FORGOT",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: _deviceBlockSize * 7.5,
                    fontFamily: 'montserrat',
                  ),
                ),
                Text(
                  "SOMETHING?",
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
