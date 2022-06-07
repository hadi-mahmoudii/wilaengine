import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:willaEngine/Features/CRM/Widgets/client_details_widgets.dart'
    as widgets;

import '../../../Cores/Config/app_session.dart';
import '../../../Cores/Models/request_status.dart';
import '../../../Cores/Widgets/header.dart';
import '../../../Cores/Widgets/loading_widget.dart';
import '../../../Cores/Widgets/screens_header.dart';
import '../controller/Client.dart';


// class ClientDetailsScreen extends StatefulWidget {
//   const ClientDetailsScreen({
//     Key key,
//   }) : super(key: key);

//   @override
//   _ClientDetailsScreenState createState() => _ClientDetailsScreenState();
// }

class ClientDetailsScreen extends StatelessWidget {
  
  

  @override
  Widget build(BuildContext context) {
    ClientController clientController = Get.put(ClientController(Get.arguments , context));
    return GetX<ClientController>(
      builder: (controller) => SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            child: GlobalScreensHeader(
              backLabel: 'لیست مشتریان',
              eName: '',
              pName: controller.requestStatus == RequestStatus.stable
                  ? controller.user.value.name
                  : '',
              icon: FontAwesomeIcons.userAlt,
            ),
            preferredSize: Size(
              double.infinity,
              AppSession.deviceHeigth * 0.155,
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () => controller.fetchDatas(context),
            child: controller.requestStatus == RequestStatus.loading
                ? Center(
                    child:
                        LoadingWidget(mainFontColor: AppSession.mainFontColor),
                  )
                : ListView(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      widgets.FiveTopButtons(user: controller.user.value),
                      SizedBox(
                        height: 30,
                      ),
                      widgets.LoadedFiles(
                        number: controller.user.value.medias.length.toString(),
                        title: 'فایــــــــــــــل\nبارگزاری شده',
                        color: Color(0xFF32CAD5),
                        user: controller.user.value,
                      ),
                      widgets.TaskDone(
                        number: controller.user.value.tasksCount,
                        title: 'خــــــــدمت\nانجام شده',
                        color: Color(0xFFAC3773),
                        user: controller.user.value,
                      ),
                      widgets.TransactionDone(
                        number: controller.user.value.transactions.toString(),
                        title: 'مجموع تراکنش ها - تومان',
                        color: Colors.black,
                        user: controller.user.value,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      SimpleHeader('سایر اطلاعات', 'OTHER DETAILS'),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Divider(height: 1),
                      ),
                      widgets.HBDRow(
                        birthDay: controller.user.value.birthday,
                        labelName: controller.user.value.labelName,
                      ),
                      widgets.DataRow(
                          title: 'نام پدر', value: controller.user.value.father),
                      widgets.DataRow(
                        title: 'کد ملی',
                        value: controller.user.value.nationId,
                        mainColor: Color(0xFFF1F1F1),
                        borderColor: Color(0xFFC5C5C5),
                      ),
                      widgets.DataRow(
                          title: 'کد مشتری', value: controller.user.value.customerId),
                      widgets.DataRow(
                        title: 'دسته ی مشتری',
                        value: controller.user.value.customerCategory,
                        mainColor: Color(0xFFF1F1F1),
                        borderColor: Color(0xFFC5C5C5),
                      ),
                      widgets.DataRow(
                          title: 'شماره تماس', value: controller.user.value.phone),
                      widgets.AllInfo(
                        bigTitle: 'همه ی اطلاعات مشتری',
                        title: 'شامل آدرس ها، شماره تماس ها و...',
                        color: Colors.black,
                        user: controller.user.value,
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
