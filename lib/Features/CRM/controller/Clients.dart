import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Cores/Config/urls.dart';
import '../../../Cores/Entities/server_request.dart';
import '../../../Cores/Models/error_result.dart';
import '../../../Cores/Models/request_status.dart';
import '../Models/user_details_object.dart';

class ClientsController extends GetxController {
  @override
  void onInit() {
    fetchDatas(context);
    print('client controller');
    super.onInit();
  }

  final BuildContext context;
  var requestStatus = RequestStatus.init.obs;

  var loadMoreStatus = RequestStatus.init.obs;

  var _requestUrl = ''.obs;
  var searchCtrl = TextEditingController().obs;
  List<ClientOverviewModel> datas = <ClientOverviewModel>[].obs;
  var currentPage = 1.obs;
  final ScrollController scrollController = new ScrollController();
  
  // List<OptionModel> mentorsList = [];
  // TextEditingController minValueCtrl = new TextEditingController();
  // TextEditingController maxValueCtrl = new TextEditingController();
  // TextEditingController sortValueCtrl = new TextEditingController();
  // TextEditingController mentorValueCtrl = new TextEditingController();
  // TextEditingController minDateCtrl = new TextEditingController();
  // TextEditingController maxDateCtrl = new TextEditingController();
  ClientsController(this.context);

  resetFilters() {
    // mentorValueCtrl.text = '';
    // minDateCtrl.text = '';
    // maxDateCtrl.text = '';
  }

  fetchDatas(BuildContext context,
      {bool resetPage = false, bool resetFilter = false}) async {
    // if (resetFilter) nameFilterCtrl.text = "";
    if (resetPage) currentPage.value = 1;
    setUrl();
    if (currentPage.value == 1) {
      
      datas = [];
      requestStatus.value = RequestStatus.loading;
      if(scrollController.hasClients){
scrollController.jumpTo(0);
      }
        
      
    } else {
      loadMoreStatus.value = RequestStatus.loading;
    }
    // print(_requestUrl);
    final Either<ErrorResult, List<ClientOverviewModel>> result =
        await ServerRequest<ClientOverviewModel>()
            .fetchDatas(_requestUrl.value);
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
          if (result.length > 0) currentPage += 1;
          datas += result;
          loadMoreStatus.value = RequestStatus.stable;
          // scrollController
          //     .jumpTo(scrollController.position.maxScrollExtent - 200);

        }
      },
    );
  }

  setUrl() {
    _requestUrl.value =
        Urls.getClients('1') + '?page=${currentPage.toString()}';
    if (searchCtrl.value.text.isNotEmpty)
      _requestUrl.value += '&filters[name]=%${searchCtrl.value.text}%';
    // if (maxValueCtrl.text.isNotEmpty)
    //   _requestUrl += '&max_price=${maxValueCtrl.text}';
    // if (mentorValueCtrl.text.isNotEmpty)
    //   _requestUrl +=
    //       '&mentor_id=${mentorsList.firstWhere((element) => element.title == mentorValueCtrl.text).id}';
    // if (sortValueCtrl.text.isNotEmpty)
    //   _requestUrl +=
    //       '&sort=${sortDatas.firstWhere((element) => element.title == sortValueCtrl.text).id}';
    // if (minDateCtrl.text.isNotEmpty)
    //   _requestUrl += '&min_date=${minDateCtrl.text}';
    // if (maxDateCtrl.text.isNotEmpty)
    //   _requestUrl += '&max_date=${maxDateCtrl.text}';
    // if (currentPage != 1) _requestUrl += '&page=${currentPage.toString()}';
    // if (nameFilterCtrl.text.isNotEmpty)
    //   _requestUrl += '&name=${nameFilterCtrl.text}';
  }

  @override
  void reassemble() {}
}
