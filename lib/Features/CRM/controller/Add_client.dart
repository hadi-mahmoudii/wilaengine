import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:willaEngine/Cores/Config/urls.dart';
import 'package:willaEngine/Cores/Entities/server_request.dart';
import 'package:willaEngine/Cores/Models/error_result.dart';
import 'package:willaEngine/Cores/Models/option_model.dart';
import 'package:willaEngine/Cores/Models/request_status.dart';

class AddClientController extends GetxController {
  @override
  void onInit() {
    fetchDatas(context);
    super.onInit();
  }

  final BuildContext context;
  var requestStatus = RequestStatus.stable.obs;

  var categories = <OptionModel>[].obs;
  var titles = <OptionModel>[].obs;
  final addFormKey = GlobalKey<FormState>();
  final TextEditingController categoryCtrl = new TextEditingController();
  final TextEditingController titleCtrl = new TextEditingController();
  final TextEditingController nameCtrl = new TextEditingController();
  final TextEditingController lNameCtrl = new TextEditingController();
  final TextEditingController birthDayCtrl = new TextEditingController();
  final TextEditingController phoneCtrl = new TextEditingController();
  final TextEditingController detailsCtrl = new TextEditingController();
  var userType = 'natural'.obs;

  AddClientController(this.context);

  changeUserType(String value) {
    userType.value = value;
  }

  fetchDatas(BuildContext context) async {
    requestStatus.value = RequestStatus.loading;

    final Either<ErrorResult, List<OptionModel>> result =
        await ServerRequest<OptionModel>().fetchDatas(Urls.getCategories);

    result.fold(
      (error) async {
        await ErrorResult.showDlg(error.type, context);
        Get.back();
        // Navigator.of(context).pop();
      },
      (result) async {
        categories.value = result;
        final Either<ErrorResult, List<OptionModel>> result2 =
            await ServerRequest<OptionModel>().fetchDatas(Urls.getTitles);
        result2.fold(
          (error) async {
            await ErrorResult.showDlg(error.type, context);
            Get.back();
            // Navigator.of(context).pop();
          },
          (result2) async {
            titles.value = result2;
            requestStatus.value = RequestStatus.stable;
          },
        );
      },
    );
  }

  sendDatas(BuildContext context) async {
    if (!addFormKey.currentState.validate()) return;
    var titleId = ''.obs;
    if (titleCtrl.text.isNotEmpty)
      titleId.value = titles.value
          .firstWhere(
            (element) => element.title == titleCtrl.text,
          )
          .id;
    var categoryId = ''.obs;
    if (categoryCtrl.text.isNotEmpty)
      categoryId.value = categories
          .firstWhere((element) => element.title == categoryCtrl.text)
          .id;
    var datas = categoryCtrl.text != ''
        ? {
            'first_name': nameCtrl.text,
            'last_name': lNameCtrl.text,
            'user_type': userType.value,
            "client_title[connect]": titleId.value,
            'birthday': birthDayCtrl.text,
            'cell_number': phoneCtrl.text,
            'description': detailsCtrl.text,
            'client_categories[sync][]': categoryId.value,
          }
        : {
            'first_name': nameCtrl.text,
            'last_name': lNameCtrl.text,
            'user_type': userType.value,
            "client_title[connect]": titleId.value,
            'birthday': birthDayCtrl.text,
            'cell_number': phoneCtrl.text,
            'description': detailsCtrl.text,
          };
    requestStatus.value = RequestStatus.loading;

    final Either<ErrorResult, String> result =
        await ServerRequest<RxString>().sendData(Urls.clients, datas: datas);
    result.fold(
      (error) async {
        print(error);
        await ErrorResult.showDlg(error.type, context);
        requestStatus.value = RequestStatus.error;
      },
      (result) {
        Fluttertoast.showToast(
          msg: "مشتری با موفقیت ساخته شد.",
        );
        Navigator.pop(context);
      },
    );
  }

  @override
  void reassemble() {}
}
