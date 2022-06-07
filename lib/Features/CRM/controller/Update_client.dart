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

class UpdateClientController extends GetxController {
  @override
  void onInit() {
    fetchDatas(context);
    super.onInit();
  }

  var requestStatus = RequestStatus.stable.obs;
  final BuildContext context;
  List categories = <OptionModel>[].obs;
  List titles = <OptionModel>[].obs;
  final addFormKey = GlobalKey<FormState>();
  final ClientDetailsModel user;
  final TextEditingController categoryCtrl = new TextEditingController();
  final TextEditingController titleCtrl = new TextEditingController();
  final TextEditingController nameCtrl = new TextEditingController();
  final TextEditingController lNameCtrl = new TextEditingController();
  final TextEditingController birthDayCtrl = new TextEditingController();
  final TextEditingController phoneCtrl = new TextEditingController();
  final TextEditingController detailsCtrl = new TextEditingController();
  var userType = 'natural'.obs;

  UpdateClientController(
    this.user,
    this.context,
  ) {
    categoryCtrl.text = user.customerCategory;
    titleCtrl.text = user.labelName;
    nameCtrl.text = user.fName;
    lNameCtrl.text = user.lName;
    birthDayCtrl.text = user.birthday;
    phoneCtrl.text = user.phone;
    detailsCtrl.text = user.description;
    userType.value = user.userType;
  }

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
      },
      (result) async {
        categories = result;
        final Either<ErrorResult, List<OptionModel>> result2 =
            await ServerRequest<OptionModel>().fetchDatas(Urls.getTitles);
        result2.fold(
          (error) async {
            await ErrorResult.showDlg(error.type, context);
            Get.back();
          },
          (result2) async {
            titles = result2;
            requestStatus.value = RequestStatus.stable;
           
          },
        );
      },
    );
  }

  updateDatas(BuildContext context) async {
    if (!addFormKey.currentState.validate()) return;
    var titleId = ''.obs;
    if (titleCtrl.text.isNotEmpty)
      titleId.value = titles
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
        await ServerRequest<String>().updateData(
      Urls.clients + '/' + user.id,
      datas: datas,
    );
    // final Either<ErrorResult, String> result =
    //     await ServerRequest<String>().sendData(Urls.clients, datas: datas);
    result.fold(
      (error) async {
        await ErrorResult.showDlg(error.type, context);
        requestStatus.value = RequestStatus.error;
        
      },
      (result) {
        Fluttertoast.showToast(
          msg: "مشتری با موفقیت به روز شد.",
        );
        Navigator.pop(context);
      },
    );
  }

  @override
  void reassemble() {}
}
