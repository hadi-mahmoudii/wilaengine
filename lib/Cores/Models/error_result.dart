import 'dart:io';

import 'package:flutter/material.dart';

import '../Widgets/alert_dialog.dart';

enum ErrorType {
  Network,
  Server,
  ExpireToken,
  FillDatas,
  BadData,
  BadCode,
  UnRegister,
  UnVerify,
}

class ErrorResult {
  final ErrorType type;

  ErrorResult({
    @required this.type,
  });
  factory ErrorResult.fromException(e) {
    ErrorType error;
    print(e);
    switch (e) {
      case SocketException:
        error = ErrorType.Network;
        break;
      case HttpException:
        error = ErrorType.Server;
        break;
      case RedirectException:
        error = ErrorType.ExpireToken;
        break;
      default:
        error = ErrorType.Server;
    }
    return ErrorResult(type: error);
  }

  static showDlg(ErrorType type, BuildContext context) async {
    switch (type) {
      case ErrorType.Network:
        await showDialog(
          context: context,
          builder: (ctx) => GlobalAlertDialog(
            title: 'خطا',
            content: 'مشکل در اتصال به اینترنت',
          ),
        );
        break;
      case ErrorType.Server:
        await showDialog(
          context: context,
          builder: (ctx) => GlobalAlertDialog(
            title: 'خطا',
            content: 'مشکل در اتصال به سرور',
          ),
        );
        break;
      case ErrorType.FillDatas:
        await showDialog(
          context: context,
          builder: (ctx) => GlobalAlertDialog(
            title: 'خطا',
            content: 'لطفا تمامی فیلد ها را پر نمایید',
          ),
        );
        break;
      case ErrorType.BadData:
        await showDialog(
          context: context,
          builder: (ctx) => GlobalAlertDialog(
            title: 'خطا',
            content: 'نام کاربری و یا رمز عبور نادرست است',
          ),
        );
        break;
      case ErrorType.BadCode:
        await showDialog(
          context: context,
          builder: (ctx) => GlobalAlertDialog(
            title: 'خطا',
            content: 'کد وارد شده نادرست است',
          ),
        );
        break;
      case ErrorType.UnRegister:
        await showDialog(
          context: context,
          builder: (ctx) => GlobalAlertDialog(
            title: 'خطا',
            content: 'این شماره قبلا ثبت نام نکرده است',
          ),
        );
        break;
      case ErrorType.UnVerify:
        await showDialog(
          context: context,
          builder: (ctx) => GlobalAlertDialog(
            title: 'خطا',
            content:
                'تایید شماره تلفن انجام نشده است.از بخش فراموشی رمز شماره ی خودرا تایید کنید.',
          ),
        );
        break;
      default:
    }
  }
}
