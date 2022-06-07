import 'package:flutter/cupertino.dart';
import 'package:willaEngine/Cores/Entities/global.dart';
import 'package:willaEngine/Cores/Models/date-convertor.dart';

class ClientTransactionModel {
  final String id;
  final String price;
  final String date;
  final String category;
  final String itemcount;
  final String paymentType;
  final String details;
  final List<dynamic> paymentItems;

  ClientTransactionModel({
    @required this.id,
    @required this.price,
    @required this.date,
    @required this.category,
    @required this.itemcount,
    @required this.paymentType,
    @required this.details,
    @required this.paymentItems,
  });

  factory ClientTransactionModel.fromJson(Map datas) {
    GlobalEntity gl = new GlobalEntity();
    String payments = '\n';
    print(datas['payment_types']);
    for (var payment in datas['payment_types'].keys) {
      // print(payment.toString());
      payments +=
          '${gl.paymentTranslate(payment.toString())} : ${datas['payment_types'][payment].toString()}\n\n';
    }
    return ClientTransactionModel(
      id: gl.dataFilter(datas['id'].toString()),
      price: gl.dataFilter(datas['amount'].toString()),
      date: DateConvertor(gl.dataFilter(datas['date'].toString())).convert(),
      category: gl.dataFilter(datas['transaction_title'].toString()),
      itemcount: gl.dataFilter(datas['transaction_items'].length.toString()),
      paymentType: payments,
      details: gl.dataFilter(datas['description'].toString()),
      paymentItems: datas['transaction_items'],
    );
  }
}

class TransactionOverviewModel {
  final String id;
  final String amount;
  final String date;
  final String transactionTitle;

  TransactionOverviewModel({
    @required this.id,
    @required this.amount,
    @required this.date,
    @required this.transactionTitle,
  });

  factory TransactionOverviewModel.fromJson(Map datas) {
    print(datas['transaction_title']);
    GlobalEntity gl = new GlobalEntity();
    return TransactionOverviewModel(
      id: gl.dataFilter(datas['id'].toString()),
      amount: gl.dataFilter(datas['amount'].toString()),
      date: DateConvertor(gl.dataFilter(datas['date'].toString())).convert(),
      transactionTitle:
          gl.dataFilter(datas['transaction_title'].toString()) != ''
              ? gl.dataFilter(datas['transaction_title']['name'].toString())
              : '',
    );
  }
}
