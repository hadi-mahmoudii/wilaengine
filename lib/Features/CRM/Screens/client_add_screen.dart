import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:willaEngine/Cores/Config/app_session.dart';
import 'package:willaEngine/Cores/Models/request_status.dart';
import 'package:willaEngine/Cores/Widgets/date_picker.dart';
import 'package:willaEngine/Cores/Widgets/input_box.dart';
import 'package:willaEngine/Cores/Widgets/loading_widget.dart';
import 'package:willaEngine/Cores/Widgets/screens_header.dart';
import 'package:willaEngine/Cores/Widgets/static_bottom_selector.dart';
import 'package:willaEngine/Cores/Widgets/submit_button.dart';
import 'package:willaEngine/Features/CRM/controller/Add_client.dart';

// class AddClientScreen extends StatefulWidget {
//   const AddClientScreen({
//     Key key,
//   }) : super(key: key);

//   @override
//   _AddClientScreenState createState() => _AddClientScreenState();
// }

class AddClientScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AddClientController addClientController =
        Get.put(AddClientController(context));
        
    return GetX<AddClientController>(
      builder: (controller) => SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            child: GlobalScreensHeader(
              backLabel: 'لیست مشتریان',
              eName: 'NEW CUSTOMER',
              pName: 'مشتری جدید',
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
                        Container(
                          width: AppSession.deviceWidth - 40,
                          child: Row(
                            children: [
                              Expanded(
                                child: UserTypeSelectorWidget(
                                  fTitle: 'مشتری حقوقی',
                                  eTitle: 'CORPORATIVE',
                                  icon: Icons.apartment,
                                  type: 'juridical',
                                ),
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                child: UserTypeSelectorWidget(
                                  fTitle: 'مشتری حقیقی',
                                  eTitle: 'PERSON',
                                  icon: Icons.person,
                                  type: 'natural',
                                ),
                              ),
                            ],
                          ),
                        ),
                        StaticBottomSelector(
                          color: Colors.black,
                          icon: Icons.format_align_left,
                          label: 'دسته بندی مشتری',
                          controller: controller.categoryCtrl,
                          datas: controller.categories,
                        ),
                        SizedBox(height: 20),
                        StaticBottomSelector(
                          color: Colors.black,
                          icon: Icons.tag,
                          label: 'عنوان مشتری',
                          controller: controller.titleCtrl,
                          datas: controller.titles,
                          // validator: (String value) {
                          //   if (value.isEmpty) return 'مسئول وظیفه الزامی است';
                          //   return null;
                          // },
                        ),
                        SizedBox(height: 20),
                        InputBox(
                            color: Colors.black,
                            icon: Icons.person,
                            label: 'نام مشتری',
                            controller: controller.nameCtrl
                            // validator: (String value) {
                            //   if (value.isEmpty)
                            //     return 'پرکردن این فیلد اجباری است';
                            //   return null;
                            // },
                            ),
                        SizedBox(height: 20),
                        InputBox(
                          color: Colors.black,
                          icon: Icons.family_restroom,
                          label: 'نام خانوادگی مشتری',
                          controller: controller.lNameCtrl,
                          validator: (String value) {
                            if (value.isEmpty)
                              return 'پرکردن این فیلد اجباری است';
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: AppSession.deviceWidth - 40,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: InputBox(
                                  color: Colors.black,
                                  icon: Icons.phone,
                                  label: 'شماره تماس',
                                  controller: controller.phoneCtrl,
                                  validator: (String value) {
                                    if (value.length != 11) {
                                      return 'شماره را بدرستی وارد کنید';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              SizedBox(width: 5),

                              // Expanded(
                              //   child: DatePicker(
                              //     color: Colors.black,
                              //     icon: Icons.calendar_today,
                              //     label: 'تاریخ تولد',
                              //     controller: provider.birthDayCtrl,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
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
                          title: 'ثبت مشتری',
                          function: () => controller.sendDatas(context),
                          color: Color(0XFF32CAD5),
                          fontColor: Colors.white,
                        ),
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

class UserTypeSelectorWidget extends StatelessWidget {
  final String fTitle;
  final String eTitle;
  final IconData icon;
  final String type;

  const UserTypeSelectorWidget({
    Key key,
    @required this.fTitle,
    @required this.eTitle,
    @required this.icon,
    @required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<AddClientController>(
      builder: (controller) => Opacity(
        opacity: controller.userType == type ? 1.0 : .25,
        child: InkWell(
          onTap: () => controller.changeUserType(type),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              border: Border.all(
                color: Color(0XFF32CAD5),
              ),
              // color: Color(0XFF32CAD5),
            ),
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      fTitle,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: Color(0XFF32CAD5),
                        fontSize: AppSession.deviceBlockSize * 5,
                      ),
                    ),
                    Text(
                      eTitle,
                      style: TextStyle(
                        color: Color(0XFF32CAD5),
                        fontSize: AppSession.deviceBlockSize * 4,
                        fontFamily: 'montserratlight',
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 5),
                Icon(
                  icon,
                  size: 8 * AppSession.deviceBlockSize,
                  color: Color(0XFF32CAD5),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
