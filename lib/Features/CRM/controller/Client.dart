import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Cores/Config/urls.dart';
import '../../../Cores/Entities/server_request.dart';
import '../../../Cores/Models/error_result.dart';
import '../../../Cores/Models/request_status.dart';
import '../Models/user_details_object.dart';

class ClientController extends GetxController {
  @override
  void onInit() {
    fetchDatas(context);
    super.onInit();
  }

  final BuildContext context;
  var user = ClientDetailsModel().obs;
  var requestStatus = RequestStatus.loading.obs;

  final String userId;

  ClientController(this.userId , this.context);
  fetchDatas(BuildContext context) async {
    requestStatus.value = RequestStatus.loading;

    final Either<ErrorResult, ClientDetailsModel> result =
        await ServerRequest<ClientDetailsModel>()
            .fetchData(Urls.getSingleClient(userId));
    result.fold(
      (error) async {
        await ErrorResult.showDlg(error.type, context);
        requestStatus.value = RequestStatus.error;
      },
      (result) {
        user.value = result;
        requestStatus.value = RequestStatus.stable;
      },
    );
  }

  @override
  void reassemble() {}

  @override
  void dispose() {
    // print('here');
    super.dispose();
  }
}
