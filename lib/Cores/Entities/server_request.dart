// Read

import 'dart:convert';

import 'package:either_option/either_option.dart';
import 'package:http/http.dart' as http;
import 'package:willaEngine/Features/CRM/Models/transaction_object.dart';
import 'package:willaEngine/Features/Comment/Models/comment_object.dart';

import '../../Features/CRM/Models/client_task_object.dart';
import '../../Features/CRM/Models/user_details_object.dart';
import '../Config/app_session.dart';
import '../Config/urls.dart';
import '../Models/error_result.dart';
import '../Models/option_model.dart';

class ServerRequest<T> {
  Future<Either<ErrorResult, List<T>>> fetchDatas(String url,
      {List<dynamic> datas}) async {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': AppSession.token,
          'Module': 'crm',
        },
      );

      return Right(parseDatas(response.body));
    } catch (e) {
      return Left(ErrorResult.fromException(e));
    }
  }

  Future<Either<ErrorResult, T>> fetchData(String url,
      {List<dynamic> datas}) async {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': AppSession.token,
          'Module': 'crm',
        },
      );
      return Right(parseData(response.body));
    } catch (e) {
      return Left(ErrorResult.fromException(e));
    }
  }

  List<T> parseDatas(String datas) {
    var results = [];
    var values = json.decode(datas);
    switch (T) {
      case OptionModel:
        results = <OptionModel>[];
        values['data'].forEach((element) {
          results.add(OptionModel.fromJson(element));
        });
        break;
      case ClientOverviewModel:
        results = <ClientOverviewModel>[];
        values['data'].forEach((element) {
          results.add(ClientOverviewModel.fromJson(element));
        });
        break;
      case ClientTaskOverviewModel:
        results = <ClientTaskOverviewModel>[];
        values['data'].forEach((element) {
          results.add(ClientTaskOverviewModel.fromJson(element));
        });
        break;
      case TransactionOverviewModel:
        results = <TransactionOverviewModel>[];
        values['data'].forEach((element) {
          results.add(TransactionOverviewModel.fromJson(element));
        });
        break;
      case CommentModel:
        results = <CommentModel>[];
        values['data'].forEach((element) {
          results.add(CommentModel.fromJson(element));
        });
        break;
      default:
    }

    return results;
  }

  T parseData(String datas) {
    var result;
    var value = json.decode(datas);
    switch (T) {
      case ClientDetailsModel:
        result = ClientDetailsModel.fromJson(value['data']);
        break;
      case ClientTaskModel:
        result = ClientTaskModel.fromJson(value['data']);
        break;
      case ClientTransactionModel:
        result = ClientTransactionModel.fromJson(value['data']);
        break;
      default:
    }
    return result;
  }

  Future<Either<ErrorResult, String>> sendData(String url,
      {Map datas, Map<String, String> headers}) async {
    try {
      Map<String, String> header;
      if (headers == null) {
        header = {
          'X-Requested-With': 'XMLHttpRequest',
          'Module': 'crm',
          'Authorization': AppSession.token,
        };
      } else {
        header = headers;
      }
      final response = await http.post(
        Uri.parse(url),
        headers: header,
        body: datas,
      );
      print('yeaaaap');

      return Right(response.body);
    } catch (e) {
      print('error');
      return Left(ErrorResult.fromException(e));
    }
  }

  Future<Either<ErrorResult, String>> updateData(String url,
      {Map datas, Map<String, String> headers}) async {
    try {
      Map<String, String> header;
      if (headers == null) {
        header = {
          'X-Requested-With': 'XMLHttpRequest',
          'Module': 'crm',
          'Authorization': AppSession.token,
        };
      } else {
        header = headers;
      }
      final response = await http.put(
        Uri.parse(url),
        headers: header,
        body: datas,
      );
      return Right(response.body);
    } catch (e) {
      return Left(ErrorResult.fromException(e));
    }
  }

  Future<Either<ErrorResult, String>> deleteData(String url,
      {List<dynamic> datas}) async {
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {
          'Authorization': AppSession.token,
          'Module': 'crm',
          'X-Requested-With': 'XMLHttpRequest'
        },
      );
      return Right(response.body);
    } catch (e) {
      return Left(ErrorResult.fromException(e));
    }
  }

  // T parsePostData(String datas) {
  //   var result;
  //   var value = json.decode(datas);
  //   switch (T) {
  //     case RequestResult:
  //       if (value['message']['title'] == 'موفق') result = RequestResult.Accept;
  //       else result = RequestResult.Reject;
  //       break;
  //     default:
  //   }
  //   return result;
  // }
}
