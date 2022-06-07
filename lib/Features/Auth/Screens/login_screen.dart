import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../Cores/Config/routes.dart';
import '../../../Cores/Models/request_result.dart';
import '../../../Cores/Widgets/alert_dialog.dart';
import '../../../Cores/Widgets/header2.dart';
import '../../../Cores/Widgets/loading_widget.dart';
import '../Entities/auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  final TextEditingController _usernameCTRL = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final Color _mainFontColor = _theme.primaryColor;
    // final Color _secondColor = _theme.accentColor;
    final _media = MediaQuery.of(context);
    final double _devicewidth = _media.size.width;
    final double _deviceBlockSize = _devicewidth / 100;
    final double _deviceHeight = _media.size.height;
    final double _deviceHeightBlockSize = _deviceHeight / 100;
    
    return AnnotatedRegion<SystemUiOverlayStyle>(
      child: Scaffold(
        body: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              // Image.asset(
              //   'assets/Images/signin.png',
              //   height: 30 * _deviceHeightBlockSize,
              //   width: 30 * _deviceHeightBlockSize,
              //   fit: BoxFit.fitWidth,
              // ),
              LoginHeader(deviceBlockSize: _deviceBlockSize),
              SizedBox(
                height: 2 * _deviceHeightBlockSize,
              ),
              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: 20),
              //   child: Row(
              //     children: <Widget>[
              //       Spacer(),
              //       InkWell(
              //         // padding: EdgeInsets.symmetric(vertical: 5),
              //         onTap: () => Navigator.of(context).pop(),
              //         child: Container(
              //           padding: EdgeInsets.only(
              //             top: 10,
              //             left: 20,
              //             bottom: 10,
              //           ),
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.end,
              //             children: <Widget>[
              //               Text('بازگشت'),
              //               Icon(
              //                 Icons.arrow_forward_ios,
              //                 size: 3 * _deviceBlockSize,
              //               )
              //             ],
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(
                height: 5,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: SimpleHeader2('ورود', 'LOG IN'),
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
                                  return 'لطفا شماره تلفن خود را وارد کنید.';
                                }
                                if (value.length != 11) {
                                  return 'لطفا فرمت شماره را بدرستی وارد کنید';
                                } else {
                                  return null;
                                }
                              },
                              controller: _usernameCTRL,
                              decoration: InputDecoration(
                                icon: SizedBox(
                                  width: 10,
                                  height: 20,
                                  child: Icon(
                                    FontAwesomeIcons.phone,
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
                        ],
                      ),
                    ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child:  IgnorePointer(
                    ignoring: isLoading,
                    child: InkWell(
                      onTap: () async {
                        if (!_form.currentState.validate()) {
                          return;
          
                  }
setState(() {
isLoading = true;  
});
                        

                        _form.currentState.save();
                        await AuthEntity()
                            .login(
                          _usernameCTRL.text,
                          _password.text,
                        )
                            .then((result) async {
                          if (result == RequestResult.Accept) {
                            Get.toNamed(Routes.mainScreen);
                          } else if (result == RequestResult.VerifyPhone) {
                            await showDialog(
                              context: context,
                              builder: (ctx) => GlobalAlertDialog(
                                title: 'خطا',
                                content:
                                    'مشکلی حین ورود رخ داده است.لطفا دوباره امتحان کنید.',
                              ),
                            );
                            setState(() {
                              isLoading = false;
                            });
                            
                          } else {
                            await showDialog(
                              context: context,
                              builder: (ctx) => GlobalAlertDialog(
                                title: 'خطا',
                                content:
                                    'نام کاربری یا رمز واردشده صحیح نمی باشد.',
                              ),
                            );
                            setState(() {
                              isLoading = false;
                            });
                          }
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          top: 4 * _deviceHeightBlockSize,
                          bottom: 2 * _deviceHeightBlockSize,
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
                            'ورود',
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
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: IgnorePointer(
                    ignoring: isLoading,
                    child: InkWell(
                      onTap: () => Get.toNamed(Routes.registerScreen),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: LinearGradient(
                            colors: [Color(0xFFc5c5c5), Color(0xFFe3e3e3)],
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
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              
              SizedBox(
                height: 20,
              ),
              Center(
                child: InkWell(
                  onTap: () => Get.toNamed(Routes.forgetPassScreen),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: _mainFontColor,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        'رمز عبور خود را فراموش کرده ام',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(),
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
      value: SystemUiOverlayStyle(
        statusBarColor: Color(0xffc5c5c5),
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }
}

class LoginHeader extends StatelessWidget {
  const LoginHeader({
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
              Icons.power_settings_new,
              color: Colors.black,
              size: _deviceBlockSize * 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "LET'S",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: _deviceBlockSize * 7.5,
                    fontFamily: 'montserrat',
                  ),
                ),
                Text(
                  "DIG IN",
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
