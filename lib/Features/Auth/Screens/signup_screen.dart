import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../Cores/Config/routes.dart';
import '../../../Cores/Models/request_result.dart';
import '../../../Cores/Widgets/alert_dialog.dart';
import '../../../Cores/Widgets/header2.dart';
import '../../../Cores/Widgets/loading_widget.dart';
import '../Entities/auth.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isLoading = false;
  final TextEditingController _usernameCtrl = new TextEditingController();
  final TextEditingController _cellNumberCtrl = new TextEditingController();
  final TextEditingController _passwordCtrl = new TextEditingController();
  final TextEditingController _rePasswordCtrl = new TextEditingController();
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
      body: Form(
        key: _form,
        child: ListView(
          children: <Widget>[
            // Image.asset(
            //   'assets/Images/signup.png',
            //   height: 30 * _deviceHeightBlockSize,
            //   width: 30 * _deviceHeightBlockSize,
            //   fit: BoxFit.fitWidth,
            // ),
            SignUpHeader(deviceBlockSize: _deviceBlockSize),
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
              child: SimpleHeader2('ثبت نام', 'REGISTER'),
            ),
            isLoading
                ? LoadingWidget(mainFontColor: _mainFontColor)
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: <Widget>[
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'لطفا نام و نام خانوادگی خود را وارد کنید.';
                              } else {
                                return null;
                              }
                            },
                            controller: _usernameCtrl,
                            decoration: InputDecoration(
                              icon: SizedBox(
                                width: 10,
                                height: 20,
                                child: Icon(
                                  FontAwesomeIcons.userAlt,
                                  size: 5 * _deviceBlockSize,
                                ),
                              ),
                              labelText: 'نام و نام خانوادگی',
                              isDense: true,
                            ),
                            textDirection: TextDirection.rtl,
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
                              if (value.length != 11) {
                                return 'شماره وارد شده صحیح نمی باشد!';
                              }
                              if (value[0] != '0' || value[1] != '9') {
                                return 'شماره وارد شده صحیح نمی باشد!';
                              }
                              return null;
                            },
                            controller: _cellNumberCtrl,
                            decoration: InputDecoration(
                              icon: SizedBox(
                                width: 10,
                                height: 20,
                                child: Icon(
                                  FontAwesomeIcons.phone,
                                  size: 5 * _deviceBlockSize,
                                ),
                              ),
                              labelText: 'شماره تماس',
                              isDense: true,
                            ),
                            textDirection: TextDirection.rtl,
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                        SizedBox(
                          height: _deviceHeightBlockSize,
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'لطفا رمز خود را وارد کنید.';
                              }
                              if (value.length < 8) {
                                return 'طول رمز باید حداقل 8 کاراکتر باشد!';
                              }
                              return null;
                            },
                            controller: _passwordCtrl,
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
                            textDirection: TextDirection.rtl,
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
                              if (value.isEmpty) {
                                return 'لطفا رمز خود را مجددا وارد کنید.';
                              }
                              if (value.length < 8) {
                                return 'طول رمز باید حداقل 8 کاراکتر باشد!';
                              }
                              if (value != _passwordCtrl.text) {
                                return 'رمز های واردشده یکسان نمی باشند !';
                              }
                              return null;
                            },
                            controller: _rePasswordCtrl,
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
                            textDirection: TextDirection.rtl,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ],
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
                    _form.currentState.save();
                    setState(() {
                      isLoading = true;
                    });
                    await AuthEntity()
                        .signUp(
                      _usernameCtrl.text,
                      _passwordCtrl.text,
                      _cellNumberCtrl.text,
                    )
                        .then((result) {
                      print(result);
                      if (result == RequestResult.VerifyPhone) {
                        Navigator.of(context)
                            .popAndPushNamed(Routes.registerVerify);
                      } else if (result == RequestResult.DuplicateNumber) {
                        showDialog(
                          context: context,
                          builder: (ctx) => GlobalAlertDialog(
                            title: 'خطا',
                            content: 'این شماره تلفن قبلااستفاده شده است!',
                          ),
                        );
                        setState(() {
                          isLoading = false;
                        });
                        // print('duplicate');
                      } else {
                        Navigator.of(context).pop();
                      }
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
                        'ثبت نام',
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
    );
  }
}

class SignUpHeader extends StatelessWidget {
  const SignUpHeader({
    Key key,
    @required double deviceBlockSize,
  })  : _deviceBlockSize = deviceBlockSize,
        super(key: key);

  final double _deviceBlockSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
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
              FontAwesomeIcons.plus,
              color: Colors.black,
              size: _deviceBlockSize * 17,
            ),
            SizedBox(
              width: _deviceBlockSize,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "JOIN THE",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: _deviceBlockSize * 7.5,
                    fontFamily: 'montserrat',
                  ),
                ),
                Text(
                  "CLUB",
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
