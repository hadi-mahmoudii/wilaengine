import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:willaEngine/Features/CRM/Models/user_details_object.dart';

import '../../../Cores/Config/urls.dart';
import '../../../Cores/Entities/server_request.dart';
import '../../../Cores/Models/error_result.dart';
import '../../../Cores/Models/option_model.dart';
import '../../../Cores/Models/request_status.dart';

class MessageController extends GetxController {
  @override
  void onInit() {
    fetchDatas(context);
    super.onInit();
  }

  final BuildContext context;
  
  var requestStatus = RequestStatus.stable.obs;

  var templates = <OptionModel>[].obs;
  List<OptionModel> operators = [
    OptionModel(
      id: 'advertise',
      title: 'تبلیغاتی',
    ),
    OptionModel(
      id: 'simcard',
      title: 'سیم کارت',
    ),
  ];
  final addFormKey = GlobalKey<FormState>();
  final TextEditingController templateCtrl = new TextEditingController();
  final TextEditingController operatorCtrl = new TextEditingController();
  final TextEditingController messageCtrl = new TextEditingController();
  final  user; //clientDetailsModel or ClientOverviewModel

  MessageController(this.user, this.context);

  fetchDatas(BuildContext context) async {

    requestStatus.value = RequestStatus.loading;

    final Either<ErrorResult, List<OptionModel>> result =
        await ServerRequest<OptionModel>().fetchDatas(Urls.getMessageTemplates);

    result.fold(
      (error) async {
        print('not okkk');
        await ErrorResult.showDlg(error.type, context);
        Get.back();
      },
      (result) async {
        print('okkkkk');
        templates.value = result;
        operatorCtrl.text = operators[0].title;
        
        requestStatus.value = RequestStatus.stable;
      },
    );
  }

  sendDatas(BuildContext context) async {
    if (!addFormKey.currentState.validate()) return;
    String operatorId = operators
        .firstWhere((element) => element.title == operatorCtrl.text)
        .id;
    String templateId = '';
    if (templateCtrl.text.isNotEmpty)
      templateId = templates
          .firstWhere((element) => element.title == templateCtrl.text)
          .id;
    var datas = templateCtrl.text != ''
        ? {
            'content': messageCtrl.text,
            'ids[0]': user.id,
            "operator": operatorId,
            'message_template_id': templateId,
          }
        : {
            'content': messageCtrl.text,
            'ids[0]': user.id,
            "operator": operatorId,
          };
    requestStatus.value = RequestStatus.loading;

    final Either<ErrorResult, String> result =
        await ServerRequest<String>().sendData(Urls.sendMessage, datas: datas);
    result.fold(
      (error) async {
        await ErrorResult.showDlg(error.type, context);
        requestStatus.value = RequestStatus.error;
      },
      (result) {
        print(result);
        Fluttertoast.showToast(
          msg: "پیام با موفقیت ارسال شد.",
        );
        Get.back();
      },
    );
  }

  @override
  void reassemble() {}
}
