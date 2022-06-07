import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../Cores/Models/request_result.dart';
import '../../../Cores/Widgets/alert_dialog.dart';
import '../../../Cores/Widgets/header2.dart';
import '../../../Cores/Widgets/loading_widget.dart';
import '../Entities/auth.dart';

class RegisterVerifyScreen extends StatefulWidget {
  @override
  _RegisterVerifyScreenState createState() => _RegisterVerifyScreenState();
}

class _RegisterVerifyScreenState extends State<RegisterVerifyScreen> {
  int timerValue = 60;
  bool isLoading = false;
  Timer globalTimer;
  bool isInit = true;
  final TextEditingController _verifyCodeCtrl = new TextEditingController();
  static GlobalKey<FormState> _form = new GlobalKey<FormState>();

  void checkCode() async {
    setState(() {
      isLoading = true;
    });
    await AuthEntity()
        .verifyRegister(_verifyCodeCtrl.text)
        .then((result) async {
      if (result == RequestResult.Accept) {
        await showDialog(
          context: context,
          builder: (ctx) => GlobalAlertDialog(
            title: 'ثبت نام',
            content: 'ثبت نام شما با موفقیت انجام شد',
          ),
        );
        Navigator.of(context).popUntil((route) => route.isFirst);
        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(
        //     builder: (ctx) => MainScreen(),
        //   ),
        // );
      } else if (result == RequestResult.WrongCode) {
        await showDialog(
          context: context,
          builder: (ctx) => GlobalAlertDialog(
            title: 'کد نادرست',
            content: 'کد وارد شده صحیح نمی باشد!',
          ),
        );
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print('done');
      }
    });
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    globalTimer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          // if (!this.mounted) {
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

  @override
  void dispose() {
    try {
      globalTimer.cancel();
    } catch (e) {}
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      startTimer();
      setState(() {
        isInit = false;
      });
    }
    super.didChangeDependencies();
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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // SizedBox(
              //   height: 20,
              // ),
              // Image.asset(
              //   'assets/Images/registerVerify.png',
              //   height: 30 * _deviceHeightBlockSize,
              //   width: double.infinity,
              //   fit: BoxFit.fitWidth,
              // ),
              RegisterVerifyHeader(deviceBlockSize: _deviceBlockSize),
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
                            Text('ثبت نام'),
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
                child: SimpleHeader2('تایید تلفن همراه', 'SMS VERIFICATION'),
              ),
              SizedBox(
                height: 40,
              ),
              isLoading
                  ? LoadingWidget(mainFontColor: _mainFontColor)
                  : Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: <Widget>[
                          Form(
                            key: _form,
                            child: Center(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'کد ارسال شده به شماره تماس خود را وارد نمایید.',
                                    textDirection: TextDirection.rtl,
                                  ),
                                  Container(
                                    width: 100,
                                    child: TextFormField(
                                      onChanged: (value) {
                                        if (value.length == 6) {
                                          checkCode();
                                        }
                                      },
                                      validator: (value) {
                                        if (value.length == 0) {
                                          return 'کد دریافتی را وارد کنید.';
                                        }
                                        if (value.length < 6) {
                                          return 'کد دریافتی را کامل وارد کنید.';
                                        }
                                        return null;
                                      },
                                      controller: _verifyCodeCtrl,
                                      decoration:
                                          InputDecoration(isDense: true),
                                      style: TextStyle(
                                        fontFamily: 'montserrat',
                                        letterSpacing: 5,
                                      ),
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      maxLength: 6,
                                    ),
                                  )
                                ],
                              ),
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
                    ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: IgnorePointer(
                  ignoring: isLoading,
                  // ignoring: true,
                  child: InkWell(
                    onTap: () async {
                      if (!_form.currentState.validate()) {
                        return;
                      }
                      checkCode();
                      // Navigator.of(context).pushReplacementNamed(Routes.loginScreen);
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

class RegisterVerifyHeader extends StatelessWidget {
  const RegisterVerifyHeader({
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
              FontAwesomeIcons.commentAlt,
              color: Colors.black,
              size: _deviceBlockSize * 17,
            ),
            SizedBox(
              width: 2 * _deviceBlockSize,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "JUST A\nQUICK\nCHECK",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: _deviceBlockSize * 7.5,
                    fontFamily: 'montserrat',
                    height: 1,
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

//old timerbox ui
// Container(
//                             width: _deviceBlockSize * 50,
//                             decoration: BoxDecoration(
//                               color: _secondFontColor.withOpacity(.5),
//                               borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(15),
//                                 bottomLeft: Radius.circular(15),
//                                 bottomRight: Radius.circular(15),
//                               ),
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: <Widget>[
//                                 Text(
//                                   'ارسال مجدد کد تا${timerValue.toString()} ثانیه دیگر',
//                                   textDirection: TextDirection.rtl,
//                                   style:
//                                       TextStyle(fontSize: 3 * _deviceBlockSize),
//                                 ),
//                                 SizedBox(
//                                   width: _deviceBlockSize,
//                                 ),
//                                 Container(
//                                   decoration: BoxDecoration(
//                                     color: _secondFontColor,
//                                     borderRadius: BorderRadius.only(
//                                       topLeft: Radius.circular(15),
//                                       bottomLeft: Radius.circular(15),
//                                       bottomRight: Radius.circular(15),
//                                     ),
//                                   ),
//                                   padding: EdgeInsets.symmetric(
//                                       vertical: 7, horizontal: 10),
//                                   child: Icon(
//                                     FontAwesomeIcons.starOfLife,
//                                     size: 5 * _deviceBlockSize,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )
