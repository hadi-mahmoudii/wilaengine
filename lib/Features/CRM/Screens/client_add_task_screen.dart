import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:willaEngine/Cores/Widgets/submit_button.dart';

import '../../../Cores/Config/app_session.dart';
import '../../../Cores/Models/request_status.dart';
import '../../../Cores/Widgets/date_picker.dart';
import '../../../Cores/Widgets/input_box.dart';
import '../../../Cores/Widgets/loading_widget.dart';
import '../../../Cores/Widgets/screens_header.dart';
import '../../../Cores/Widgets/static_bottom_selector.dart';
import '../controller/Task_add.dart';



// class ClientAddTaskScreen extends StatefulWidget {
//   const ClientAddTaskScreen({
//     Key key,
//   }) : super(key: key);

//   @override
//   _ClientAddTaskScreenState createState() => _ClientAddTaskScreenState();
// }

class ClientAddTaskScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    TaskAddController taskAddController =
      Get.put(TaskAddController(Get.arguments , context));

    return GetX<TaskAddController>(
      builder: (controller) => SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            child: GlobalScreensHeader(
              backLabel: 'لیست خدمات',
              eName: 'Add a new Service',
              pName: 'تعریف خدمت جدید',
              icon: FontAwesomeIcons.plus,
            ),
            preferredSize: Size(
              double.infinity,
              AppSession.deviceHeigth * 0.155,
            ),
          ),
          body: controller.requestStatus == RequestStatus.loading
              ? Center(
                  child: LoadingWidget(mainFontColor: AppSession.mainFontColor),
                )
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Form(
                    key: controller.addFormKey,
                    child: ListView(
                      children: <Widget>[
                        SizedBox(height: 10),
                        StaticBottomSelector(
                          color: Colors.black,
                          icon: Icons.format_align_left,
                          label: 'دسته بندی خدمت',
                          controller: controller.categoryCtrl,
                          datas: controller.categories,
                        ),
                        SizedBox(height: 20),
                        InputBox(
                          color: Colors.black,
                          icon: Icons.tag,
                          label: 'عنوان(اختیاری)',
                          controller: controller.labelCtrl,
                          // validator: (String value) {
                          //   if (value.isEmpty)
                          //     return 'پرکردن این فیلد اجباری است';
                          //   return null;
                          // },
                        ),
                        SizedBox(height: 20),
                        StaticBottomSelector(
                          color: Colors.black,
                          icon: Icons.person,
                          label: 'مسئول انجام خدمت',
                          controller: controller.userCtrl,
                          datas: controller.users,
                          validator: (String value) {
                            if (value.isEmpty) return 'مسئول وظیفه الزامی است';
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        // DatePicker(
                        //   color: Colors.black,
                        //   icon: Icons.calendar_today,
                        //   label: 'تاریخ شروع',
                        //   controller: provider.sDateCtrl,
                        // ),
                        // SizedBox(height: 20),
                        // DatePicker(
                        //   color: Colors.black,
                        //   icon: Icons.calendar_today,
                        //   label: 'تاریخ پایان',
                        //   controller: provider.eDateCtrl,
                        //   dependency: provider.sDateCtrl,
                        //   validator: (String value) {
                        //     if (DateTime.parse(provider.eDateCtrl.text)
                        //             .compareTo(DateTime.parse(
                        //                 provider.sDateCtrl.text)) >
                        //         0) {
                        //       return null;
                        //     } else {
                        //       return 'تاریخ پایان باید پس از تاریخ شروع باشد.';
                        //     }
                        //   },
                        // ),
                        SizedBox(height: 20),
                        InputBox(
                          color: Colors.black,
                          icon: Icons.format_quote,
                          label: 'توضیحات',
                          controller: controller.detailsCtrl,
                          minLines: 3,
                          maxLines: 5,
                        ),
                        SizedBox(height: 25),
                        SubmitButton(
                            title: 'ثبت خدمت',
                            function: () => controller.sendDatas(context),
                            color: Color(0XFFAC3773),
                            fontColor: Colors.white),
                        SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
