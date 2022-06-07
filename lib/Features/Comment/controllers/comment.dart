import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../Cores/Config/urls.dart';
import '../../../Cores/Entities/server_request.dart';
import '../../../Cores/Models/error_result.dart';
import '../../../Cores/Models/request_status.dart';
import '../Models/comment_object.dart';

class CommentController extends GetxController {
  @override
  void onInit() {
    fetchDatas(context);
    super.onInit();
  }

  final BuildContext context;
  var requestStatus = RequestStatus.init.obs;

  var loadMoreStatus = RequestStatus.init.obs;

  var addCommentStatus = RequestStatus.init.obs;

  TextEditingController commentCtrl = TextEditingController();
  var datas = <CommentModel>[].obs;
  var currentPage = 1.obs;
  final ScrollController scrollController = new ScrollController();
  final object; // client or task
  final String objectType;

  CommentController({
    @required this.object,
    @required this.objectType,
    @required this.context,
  });

  fetchDatas(BuildContext context, {bool resetPage = false}) async {
    if (resetPage) currentPage.value = 1;
    if (currentPage.value == 1) {
      datas.value = [];
      requestStatus.value = RequestStatus.loading;
      if (scrollController.hasClients) {
scrollController.jumpTo(0);
      }
      
    } else {
      loadMoreStatus.value = RequestStatus.loading;
    }
    final Either<ErrorResult, List<CommentModel>> result =
        await ServerRequest<CommentModel>().fetchDatas(
      Urls.getComments(object.id, objectType, currentPage.toString()),
    );
    result.fold(
      (error) async {
        await ErrorResult.showDlg(error.type, context);
        requestStatus.value = RequestStatus.error;
      },
      (result) {
        if (currentPage == 1) {
          datas.value = result;
          currentPage += 1;
          requestStatus.value = RequestStatus.stable;
        } else {
          scrollController.animateTo(
            scrollController.position.pixels - 75,
            duration: Duration(milliseconds: 500),
            curve: Curves.decelerate,
          );
          if (result.length > 0) currentPage += 1;
          datas.value += result;
          loadMoreStatus.value = RequestStatus.stable;
        }
      },
    );
  }

  sendDatas(BuildContext context) async {
    var datas = {
      'rel_id': object.id,
      'message': commentCtrl.text,
      'rel_type': objectType,
    };
    addCommentStatus.value = RequestStatus.loading;

    final Either<ErrorResult, String> result =
        await ServerRequest<String>().sendData(Urls.sendComment, datas: datas);
    result.fold(
      (error) async {
        await ErrorResult.showDlg(error.type, context);
        addCommentStatus.value = RequestStatus.error;
      },
      (result) {
        Fluttertoast.showToast(
          msg: "نظرشما ثبت شد.",
        );
        Get.back();
      },
    );
  }

  @override
  void reassemble() {}
}
