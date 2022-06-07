import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:willaEngine/Features/Message/Controllers/Message.dart';

import '../../../Cores/Config/app_session.dart';
import '../../../Cores/Models/request_status.dart';
import '../../../Cores/Widgets/loading_widget.dart';
import '../../../Cores/Widgets/screens_header.dart';
import '../../../Cores/Widgets/static_bottom_selector.dart';
import '../../../Cores/Widgets/submit_button.dart';

import '../Widgets/send_messages_widgets.dart';

// class SendMessageScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<MessageProvider>(
//       create: (_) => MessageProvider(ModalRoute.of(context).settings.arguments),
//       child: SendMessageTile(),
//     );
//   }
// }

// class SendMessageScreen extends StatefulWidget {
//   const SendMessageTile({
//     Key key,
//   }) : super(key: key);

//   @override
//   _SendMessageTileState createState() => _SendMessageTileState();
// }

class SendMessageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MessageController messageController =
        Get.put(MessageController(Get.arguments, context));

    return GetX<MessageController>(builder: (controller) {
      print('messagescreen');
      
      return SafeArea(
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
          body: controller.requestStatus.value == RequestStatus.loading
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
                          label: 'قالب پیام کوتاه',
                          controller: controller.templateCtrl,
                          datas: controller.templates,
                        ),
                        SizedBox(height: 20),
                        StaticBottomSelector(
                          color: Colors.black,
                          icon: Icons.sim_card,
                          label: 'شماره خط ارسال کننده',
                          controller: controller.operatorCtrl,
                          datas: controller.operators,
                        ),
                        MessageBox(controller: controller,),
                        SizedBox(height: 25),
                        SubmitButton(
                          title: 'ارسال پیام',
                          function: () => controller.sendDatas(context),
                          color: Color(0XFFEB5E00),
                          fontColor: Colors.white,
                        ),
                        SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
        ),
      );
    });
  }
}
