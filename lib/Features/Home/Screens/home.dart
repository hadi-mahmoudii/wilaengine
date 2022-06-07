import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../Cores/Config/routes.dart';
import '../Widgets/gradient_row_navigator.dart';
import '../Widgets/home-header.dart';
import '../Widgets/row_navigator.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          HomeHeader(),
          // HomeRowNavigator(
          //   mainColor: Color(0xffEE3552),
          //   title: 'مدیریت ارتباط\nبا مشتـــــــــــــری',
          //   icon: FontAwesomeIcons.users,
          //   number: '1',
          //   routeName: Routes.clientListScreen,
          // ),
          GradientRowNavigator(
            mainColor: Colors.white,
            firstColor: Color(0xFFEB5E00),
            secondColor: Color(0xFFEE3552),
            title: 'مدیریت ارتباط\nبا مشتـــــــــــــری',
            icon: FontAwesomeIcons.users,
            number: '1',
            routeName: Routes.clientListScreen,
          ),
          HomeRowNavigator(
            mainColor: Color(0xff32CAD5),
            title: 'محصـــــــــــولات\nو خدمــــــــــــــات',
            icon: FontAwesomeIcons.users,
            number: '12',
            routeName: '',
          ),
          HomeRowNavigator(
            mainColor: Color(0xffEB5E00),
            title: 'مــــــــــدیریت\nفـــــــــــروشگاه',
            icon: FontAwesomeIcons.users,
            number: '547',
            routeName: '',
          ),
        ],
      ),
    );
  }
}
