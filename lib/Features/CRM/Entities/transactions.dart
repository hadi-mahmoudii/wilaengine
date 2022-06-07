import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../Cores/Config/app_session.dart';
import '../../../Cores/Config/urls.dart';
import '../../../Cores/Entities/global.dart';
import '../Models/transaction_object.dart';

class TransactionsEntity {
  Future<bool> deleteTransaction(String id) async {
    var response = await http.delete(Uri.parse(Urls.deleteTransaction(id)), headers: {
      'X-Requested-With': 'XMLHttpRequest',
    
      'Module': 'crm',
      'Authorization': AppSession.token,
    });
    var responseData = json.decode(response.body);
    try {
      if (responseData['message']['title'] == 'موفق') {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<dynamic> getClientTransactions(String id, String page) async {
    var response = await http.get(Uri.parse(Urls.getUserTransactions(id, page)), headers: {
      'X-Requested-With': 'XMLHttpRequest',
      
      'Module': 'crm',
      'Authorization': AppSession.token,
    });
    final responseData = json.decode(response.body);
    GlobalEntity gl = new GlobalEntity();
    List<TransactionOverviewModel> transactions = [];
    for (var transaction in responseData['data']) {
      // print(transaction);
      transactions.add(
        TransactionOverviewModel(
          id: gl.dataFilter(transaction['id'].toString()),
          amount: gl.dataFilter(transaction['amount'].toString()),
          date: gl.dateConvert(gl.dataFilter(transaction['date'].toString())),
          transactionTitle:
              gl.dataFilter(transaction['transaction_title'].toString()),
        ),
      );
    }
    return transactions;
  }
}
