import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Cores/Config/app_session.dart';
import '../../../Cores/Config/urls.dart';
import '../../../Cores/Models/request_result.dart';

//09122000000
class AuthEntity {
  // bool showSplash = true; //for dont show splash many times
  String _helperToken;
  String _token;
  DateTime _expiaryDate;
  // bool _isLoggedIn = false;
  Map<String, dynamic> _userData = {};

  // bool get isAuth {
  //   return token != null;
  // }

  // bool get isLoggedIn {
  //   return _isLoggedIn;
  // }

  // String get token {
  //   if (_expiaryDate != null &&
  //       _expiaryDate.isAfter(DateTime.now()) &&
  //       _token != null) {
  //     return _token;
  //   }
  //   return null;
  // }

// eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjI5YWE5Y2JjYWU0MjkyYTY5MWQwOGU3MTM0MGI1NzBlOGFlMWIwMDlmNDRiMGRjZTU3NDk1ZjMzYTIxMmNjYzg3ZWVjODdhNDNkYzQ3NGM1In0.eyJhdWQiOiIxIiwianRpIjoiMjlhYTljYmNhZTQyOTJhNjkxZDA4ZTcxMzQwYjU3MGU4YWUxYjAwOWY0NGIwZGNlNTc0OTVmMzNhMjEyY2NjODdlZWM4N2E0M2RjNDc0YzUiLCJpYXQiOjE1OTAzMDQwMzIsIm5iZiI6MTU5MDMwNDAzMiwiZXhwIjoxNjIxODQwMDMyLCJzdWIiOiIxNTY5Iiwic2NvcGVzIjpbXX0.G7FlP8l4Fq1PK-iB2otXYnunlQwGA0RgwFhFyHYVmcnuDSCM8NBdhlgxUdNAXTfv2ASuD6GTFehtHlYZoU6LUc8cspxzBnlqapJOi7GVYHasVu7GTKpJ9a2-_io0ikFfyRg-1YV7G-cU1tPhtaaVzCPbZYQ93pISGB9Jx_IZHuO58glHxF9OZQoSoZj-1RxI96e2s3_6-_Dv74_qASxrAdPdtCwbGJu8PI2b8NUaosBp89bDcWdDPfBzOat1fGJViNvSliufAFXrWwHU9oim6W9pzJfbgBApkm4L0Wt7B1ECwyCmP3ZQcY-UvjIsjpk4nJkotrl-nQ19ZfnuBdTob_yTdeddwN2C_mQdF6F0Ilw2Yc_dVFFLn2U3iO25pY9TkETLgQDR8iF1sjQNtUpr41wPIAujb3rc1jIj3aMexPvctelpTQQF_Qqk-iMr8_7mTwPQMrgVFDXT8QU6xgSaxiCC3yuNwFN8JPsjrvYCq6xhEct7uFpwiEUzcTSo3g8ZdM2mbYJj5cpa0LWXx6L_Ffmw7HtxUvlREYkuUrqCu1nfXnVOpWO8Bwo0nauZan2KxJBDEO5bYeViQMcUhMW7rArn3TkK0NCi9Xxco8SL2mO5MfKeNcFZZhxva7aFHvSV3I6fUCZbjlKfK3qEd_b1hdRdcbQvWfRGqBdy_Lk3Xw8
  Future<RequestResult> verifyRegister(String code) async {
    final response = await http.post(
      Uri.parse(Urls.verifyRegisterNumber),
      
      body: {
        'code': code,
      },
      headers: {'X-Requested-With': 'XMLHttpRequest', },
    );
    final responseData = json.decode(response.body);
    // print(responseData);
    try {
      if ((responseData['data'] as List<dynamic>).isEmpty) {
        print('Wrong Code');
        return RequestResult.WrongCode;
      }
    } catch (e) {}

    _token = responseData['data']['token'];
    _userData = responseData['data']['user'];
    _expiaryDate = DateTime.now().add(
      Duration(
        // seconds: responseData['expires_in'],
        seconds: 10000000000,
      ),
    );
    AppSession.token = _token;
    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode({
      'token': _token,
      'expiaryDate': _expiaryDate.toIso8601String(),
      'user': _userData
    });
    prefs.setString('userData', userData);
    AppSession.isLoggedIn = true;
    return RequestResult.Accept;
  }

  Future<RequestResult> forgetPass(String cellNumber) async {
    final response = await http.post(
     Uri.parse( Urls.getForgetPassNumber),
      body: {
        'cell_number': cellNumber,
      },
      headers: {'X-Requested-With': 'XMLHttpRequest'},
    );
    final responseData = json.decode(response.body);
    print(responseData);
    // if (response.statusCode == 401) {
    //   if (responseData['message'] == 'The user credentials were incorrect.') {
    //     return 'badinput'; // incorrect user or pass
    //   }
    //   else{
    //     return 'error';
    //   }
    // }
    try {
      if (responseData['message']['title'] == 'موفق') {
        return RequestResult.VerifyPhone;
      } else {
        return RequestResult.Reject;
      }
    } catch (e) {
      return RequestResult.Reject;
    }
  }

  Future<RequestResult> sendRePass(String password) async {
    final response = await http.post(
    Uri.parse( Urls.sendRePass),
      body: {
        'password': password,
        'password_confirmation': password,
      },
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        
        'Authorization': 'Bearer ' + _helperToken,
      },
    );
    final responseData = json.decode(response.body);
    print(responseData['message']['title']);
    if (responseData['message']['title'] == 'موفق') {
      return RequestResult.Accept;
    } else {
      return RequestResult.Reject;
    }
  }

  Future<RequestResult> verifyForgetPass(String code) async {
    final response = await http.post(
    Uri.parse(  Urls.verifyForgetPassNumber),
      body: {
        'code': code,
      },
      headers: {'X-Requested-With': 'XMLHttpRequest'},
    );
    final responseData = json.decode(response.body);
    if (responseData['data'] == null) {
      return RequestResult.WrongCode;
    }
    print(responseData['data']);
    _helperToken = responseData['data']['token'];
    return RequestResult.Accept;

    // if (response.statusCode == 401) {
    //   if (responseData['message'] == 'The user credentials were incorrect.') {
    //     return 'badinput'; // incorrect user or pass
    //   }
    //   else{
    //     return 'error';
    //   }
    // }
    // try {
    //   if (responseData['message']['title'] == 'موفق') {
    //     return RequestResult.VerifyPhone;
    //   } else {
    //     return RequestResult.Reject;
    //   }
    // } catch (e) {
    //   return RequestResult.Reject;
    // }
  }

  Future<RequestResult> signUp(
      String userName, String password, String cellNumber) async {
    print(userName);
    print(password);
    print(cellNumber);
    
    final response = await http.post(
     Uri.parse( Urls.signUp),
      body: {
        'last_name': userName,
        'cell_number': cellNumber,
        'password': password,
        'password_confirmation': password,
      },
      headers: {'X-Requested-With': 'XMLHttpRequest'},
    );
    final responseData = json.decode(response.body);
    print(responseData);
    try {
      var result = responseData['message']['title'];
      if (result == 'موفق') {
        return RequestResult.VerifyPhone;
      }
    } catch (e) {}
    try {
      if (responseData['errors']['cell_number'][0] ==
          'تلفن همراه قبلا انتخاب شده است.') {
        return RequestResult.DuplicateNumber;
      }
    } catch (e) {}
    return RequestResult.Reject;
  }

  Future<RequestResult> login(String userName, String password) async {
    final response = await http.post(
     Uri.parse( Urls.login),
      body: {
        'username': userName,
        'password': password,
      },
      headers: {'X-Requested-With': 'XMLHttpRequest'},
    );
    final responseData = json.decode(response.body);
    print(responseData );
    try {
      if (responseData['errors']['verification'] ==
          'تأیید شماره تلفن انجام نشده است.') {
        return RequestResult.VerifyPhone;
      }
    } catch (e) {}
    try {
      if (responseData['errors']['credentials'] ==
          'نام کاربری و یا رمز عبور نادرست می باشد.') {
        return RequestResult.WrongLogin;
      }
      if (responseData['message'] == 'The given data was invalid.') {
        return RequestResult.WronNumber;
      }
    } catch (e) {}
    _token = responseData['data']['token'];
    _userData = responseData['data']['user'];
    AppSession.token = _token;
    _expiaryDate = DateTime.now().add(
      Duration(
        // seconds: responseData['expires_in'],
        seconds: 10000000000,
      ),
    );
    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode({
      'token': _token,
      'expiaryDate': _expiaryDate.toIso8601String(),
      'user': _userData
    });
    prefs.setString('userData', userData);
    AppSession.isLoggedIn = true;
    return RequestResult.Accept;
  }

  Future<bool> tryAutoLogin(BuildContext context) async {
    await Future.delayed(Duration(seconds: 2));
    print('try auto');
    var sizes = MediaQuery.of(context).size;
    AppSession.deviceWidth = sizes.width;
    AppSession.deviceHeigth = sizes.height;
    AppSession.deviceBlockSize = sizes.width / 100;
    AppSession.isLoggedIn = false;
    AppSession.mainFontColor = Theme.of(context).primaryColor;
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      print('undone');

      return false;
    }
    final userData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    final expiaryDate = DateTime.parse(userData['expiaryDate']);
    if (expiaryDate.isBefore(DateTime.now())) {
      return false;
    }
    // _token = userData['token'];
    AppSession.token = userData['token'];
    var data = HashMap.from(userData['user']);
    AppSession.userId = data['id'].toString();
    print(AppSession.userId);
    // _expiaryDate = expiaryDate;
    // print(userData['user']);
    AppSession.isLoggedIn = true;
    print('done');
    return true;
  }

  void logout() async {
    AppSession.isLoggedIn = false;
    AppSession.token = '';
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
  }
}
