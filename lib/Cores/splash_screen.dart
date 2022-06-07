import 'package:flutter/material.dart';

import '../Features/Auth/Entities/auth.dart';
import '../Features/Auth/Screens/login_screen.dart';
import 'Widgets/loading_widget.dart';
import 'main-screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isInit = true;
  bool isLogined = false;
  @override
  void didChangeDependencies() async {
    if (isInit) {
      bool result = await AuthEntity().tryAutoLogin(context);
      setState(() {
        isLogined = result;
        isInit = false;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var primeryColor = Theme.of(context).primaryColor;
    return Scaffold(
      body: isInit
          ? Center(
              child: LoadingWidget(mainFontColor: primeryColor),
            )
          : isLogined ?  MainScreen() : LoginScreen()
    );
  }
}
