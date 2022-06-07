import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:willaEngine/Cores/Models/option_model.dart';
import '../../../Cores/Config/urls.dart';
import '../../../Cores/Entities/server_request.dart';
import '../../../Cores/Models/error_result.dart';
import '../../../Cores/Models/request_status.dart';
import '../Models/client_task_object.dart';
import '../Models/user_details_object.dart';

class TasksController extends GetxController {
  @override
  void onInit() {
    fetchDatas(context);
    super.onInit();
  }

  final BuildContext context;
  var requestStatus = RequestStatus.init.obs;

  var loadMoreStatus = RequestStatus.init.obs;

  TextEditingController statusCtrl = TextEditingController();
  List datas = <ClientTaskOverviewModel>[].obs;
  var currentPage = 1.obs;
  final ScrollController scrollController = new ScrollController();
  final ClientDetailsModel user;
  List statuses = <OptionModel>[].obs;

  TasksController({
    @required this.user,
    @required this.context,
  });

  fetchDatas(BuildContext context, {bool resetPage = false}) async {
    if (resetPage) currentPage.value = 1;
    if (currentPage == 1) {
      datas = [];
      requestStatus.value = RequestStatus.loading;
      if (scrollController.hasClients) {
scrollController.jumpTo(0);
      }
      

      final Either<ErrorResult, List<OptionModel>> result =
          await ServerRequest<OptionModel>().fetchDatas(Urls.taskStatuses);
      result.fold(
        (error) async {
          await ErrorResult.showDlg(error.type, context);
          Get.back();
        },
        (result) async {
          statuses = result;
        },
      );
    } else {
      loadMoreStatus.value = RequestStatus.loading;
    }
    final Either<ErrorResult, List<ClientTaskOverviewModel>> result =
        await ServerRequest<ClientTaskOverviewModel>().fetchDatas(
            Urls.getUserTasks(user.id, user.scheme, currentPage.toString()));
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
