import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:willaEngine/Cores/Config/urls.dart';
import 'package:willaEngine/Cores/Entities/server_request.dart';
import 'package:willaEngine/Cores/Models/error_result.dart';
import 'package:willaEngine/Cores/Models/request_status.dart';
import 'package:willaEngine/Features/CRM/Models/transaction_object.dart';
import 'package:willaEngine/Features/CRM/Models/user_details_object.dart';

class TransactionController extends GetxController {
  @override
  void onInit() {
    fetchDatas(context);
    super.onInit();
  }

  final BuildContext context;
  var transaction = ClientTransactionModel().obs;
  var requestStatus = RequestStatus.loading.obs;
  var newFilesLoadingStatus = RequestStatus.stable.obs;
  var isUpdating = RequestStatus.stable.obs;
  var newImages = 0.obs;

  final TransactionOverviewModel transactionOverview;
  final ClientDetailsModel user;

  TransactionController(
      {@required this.transactionOverview,
      @required this.user,
      @required this.context});

  fetchDatas(BuildContext context) async {
    requestStatus.value = RequestStatus.loading;

    final Either<ErrorResult, ClientTransactionModel> result =
        await ServerRequest<ClientTransactionModel>()
            .fetchData(Urls.getTransactionDetails(transactionOverview.id));
    result.fold(
      (error) async {
        await ErrorResult.showDlg(error.type, context);
        Get.back();
        // requestStatus = RequestStatus.error;
        // notifyListeners();
      },
      (result) {
        transaction.value = result;
        requestStatus.value = RequestStatus.stable;
      },
    );
  }

  @override
  void reassemble() {}
}
