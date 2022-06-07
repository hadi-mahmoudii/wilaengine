import 'package:flutter/material.dart';


import '../../Features/CRM/Models/user_details_object.dart';

class AppSession extends ChangeNotifier {
  static String _token = '';
  static String get token {
    return 'Bearer ' + AppSession._token;
  }

  static set token(String token) {
    AppSession._token = token;
  }

  static String _userId = '';
  static String get userId {
    return AppSession._userId;
  }

  static set userId(String userId) {
    AppSession._userId = userId;
  }

  static bool _isLoggedIn;
  static bool get isLoggedIn {
    return AppSession._isLoggedIn;
  }

  static set isLoggedIn(bool isLoggedIn) {
    AppSession._isLoggedIn = isLoggedIn;
  }

  static double _deviceWidth = 0;
  static double get deviceWidth {
    return AppSession._deviceWidth;
  }

  static set deviceWidth(double deviceWidth) {
    AppSession._deviceWidth = deviceWidth;
  }

  static double _deviceBlockSize = 0;
  static double get deviceBlockSize {
    return AppSession._deviceBlockSize;
  }

  static set deviceBlockSize(double deviceBlockSize) {
    AppSession._deviceBlockSize = deviceBlockSize;
  }

  static double _deviceHeigth = 0;
  static double get deviceHeigth {
    return AppSession._deviceHeigth;
  }

  static set deviceHeigth(double deviceHeigth) {
    AppSession._deviceHeigth = deviceHeigth;
  }

  static Color _mainFontColor;
  static Color get mainFontColor {
    return AppSession._mainFontColor;
  }

  static set mainFontColor(Color mainFontColor) {
    AppSession._mainFontColor = mainFontColor;
  }

  static Color _backgroundColor;
  static Color get backgroundColor {
    return AppSession._backgroundColor;
  }

  static set backgroundColor(Color backgroundColor) {
    AppSession._backgroundColor = backgroundColor;
  }

  List<ClientOverviewModel> _currentShowableUsers;
  List<ClientOverviewModel> get currentShowableUsers {
    return _currentShowableUsers;
  }

  List<ClientOverviewModel> allUsers;

  setCurrentUsers(List<ClientOverviewModel> currentShowableUsers) {
    _currentShowableUsers = currentShowableUsers;
    notifyListeners();
  }

  setAllUsers(List<ClientOverviewModel> users) {
    allUsers = users;
    _currentShowableUsers = allUsers;
    notifyListeners();
  }
}
