import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:willaEngine/Cores/Config/urls.dart';
import 'package:willaEngine/Cores/Entities/server_request.dart';
import 'package:willaEngine/Cores/Models/error_result.dart';
import 'package:willaEngine/Cores/Models/option_model.dart';
import 'package:willaEngine/Cores/Models/request_status.dart';
import 'package:willaEngine/Features/CRM/Models/user_details_object.dart';

class TaskAddController extends GetxController {
  @override
  void onInit() {
    fetchDatas(context);
    super.onInit();
  }

  final BuildContext context;
  var requestStatus = RequestStatus.stable.obs;
  final ClientDetailsModel user;
  List<OptionModel> categories = <OptionModel>[].obs;
  List<OptionModel> users = <OptionModel>[].obs;
  final addFormKey = GlobalKey<FormState>();
  final TextEditingController categoryCtrl = new TextEditingController();
  final TextEditingController userCtrl = new TextEditingController();
  final TextEditingController labelCtrl = new TextEditingController();
  final TextEditingController detailsCtrl = new TextEditingController();
  final TextEditingController sDateCtrl = new TextEditingController();
  final TextEditingController eDateCtrl = new TextEditingController();
  // final TextEditingController categoryCtrl = new TextEditingController();

  TaskAddController(this.user, this.context);
  // final TextEditingController user = new TextEditingController();

  fetchDatas(BuildContext context) async {
    requestStatus.value = RequestStatus.loading;

    final Either<ErrorResult, List<OptionModel>> result =
        await ServerRequest<OptionModel>().fetchDatas(Urls.getTaskCategories);
    result.fold(
      (error) async {
        await ErrorResult.showDlg(error.type, context);
        Get.back();
      },
      (result) async {
        categories = result;
        final Either<ErrorResult, List<OptionModel>> result2 =
            await ServerRequest<OptionModel>()
                .fetchDatas(Urls.getRecieverUsers);
        result2.fold(
          (error) async {
            await ErrorResult.showDlg(error.type, context);
            Get.back();
          },
          (result2) async {
            users = result2;
            requestStatus.value = RequestStatus.stable;
          },
        );
      },
    );
  }

  sendDatas(BuildContext context) async {
    // print(sDateCtrl.text);
    // print(eDateCtrl.text);
    if (!addFormKey.currentState.validate()) return;
    var userId = ''.obs;
    if (userCtrl.text.isNotEmpty)
      userId.value =
          users.firstWhere((element) => element.title == userCtrl.text).id;
    var categoryId = ''.obs;
    if (categoryCtrl.text.isNotEmpty)
      categoryId.value = categories
          .firstWhere((element) => element.title == categoryCtrl.text)
          .id;
    var datas = labelCtrl.text != ''
        ? {
            'begin_date': sDateCtrl.text,
            'end_date': eDateCtrl.text,
            'description': detailsCtrl.text,
            'is_reservation': false.toString(),
            // "client_title[connect]":  user.text,
            'receiver_user[connect]': userId.value,
            'task_category[connect]': categoryId.value,
            'title': labelCtrl.text,
            'rel_id': user.id,
            'rel_type': 'user',
            // 'last_name':'test',
          }
        : {
            'begin_date': sDateCtrl.text,
            'end_date': eDateCtrl.text,
            'description': detailsCtrl.text,
            'is_reservation': false.toString(),
            'receiver_user[connect]': userId.value,
            'task_category[connect]': categoryId.value,
            'rel_id': user.id,
            'rel_type': 'user',
          };
    requestStatus.value = RequestStatus.loading;

    final Either<ErrorResult, String> result =
        await ServerRequest<String>().sendData(Urls.tasks, datas: datas);
    result.fold(
      (error) async {
        await ErrorResult.showDlg(error.type, context);
        requestStatus.value = RequestStatus.error;
      },
      (result) {
        Fluttertoast.showToast(
          msg: "خدمت با موفقیت افزوده شد.",
        );
        Get.back();
      },
    );
  }

  @override
  void reassemble() {}
}
