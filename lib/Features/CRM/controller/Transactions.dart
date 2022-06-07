import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:willaEngine/Cores/Config/urls.dart';
import 'package:willaEngine/Cores/Entities/server_request.dart';
import 'package:willaEngine/Cores/Models/error_result.dart';
import 'package:willaEngine/Cores/Models/request_status.dart';
import 'package:willaEngine/Features/CRM/Models/transaction_object.dart';
import 'package:willaEngine/Features/CRM/Models/user_details_object.dart';

class TransactionsController extends GetxController {
  @override
  void onInit() {
    fetchDatas(context);
    super.onInit();
  }

  final BuildContext context;
  var requestStatus = RequestStatus.init.obs;

  var loadMoreStatus = RequestStatus.init.obs;

  var searchCtrl = TextEditingController().obs;
  List datas = <TransactionOverviewModel>[].obs;
  var currentPage = 1.obs;

  final ScrollController scrollController = new ScrollController();
  final ClientDetailsModel user;

  TransactionsController({
    @required this.user,
    @required this.context
  });

  fetchDatas(BuildContext context, {bool resetPage = false}) async {
    if (resetPage) currentPage.value = 1;
    if (currentPage == 1) {
      datas = [];
      requestStatus.value = RequestStatus.loading;
      if (scrollController.hasClients) {
scrollController.jumpTo(0);
      }
      
    } else {
      loadMoreStatus.value = RequestStatus.loading;
    }
    final Either<ErrorResult, List<TransactionOverviewModel>> result =
        await ServerRequest<TransactionOverviewModel>().fetchDatas(
            Urls.getUserTransactions(user.id, currentPage.toString()));
    result.fold(
      (error) async {
        await ErrorResult.showDlg(error.type, context);
        requestStatus.value = RequestStatus.error;
      },
      (result) {
        if (currentPage == 1) {
          datas = result;
          currentPage += 1;
          requestStatus.value = RequestStatus.stable;
        } else {
          scrollController.animateTo(
            scrollController.position.pixels - 75,
            duration: Duration(milliseconds: 500),
            curve: Curves.decelerate,
          );
          if (result.length > 0) currentPage += 1;
          datas += result;
          loadMoreStatus.value = RequestStatus.stable;
        }
      },
    );
  }

  @override
  void reassemble() {}
}
