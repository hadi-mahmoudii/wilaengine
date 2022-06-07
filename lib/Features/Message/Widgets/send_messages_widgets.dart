import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:willaEngine/Features/Message/Controllers/Message.dart';

import '../../../Cores/Config/app_session.dart';
import '../../../Cores/Widgets/alert_dialog.dart';
import '../../../Cores/Widgets/input_box.dart';
import '../Entities/message.dart';

class MessageBox extends StatelessWidget {
  // final String label;
  // final TextEditingController textCtrl;
  // final IconData icon;
  // final ClientDetailsModel user;

  const MessageBox({
    Key key,
    // @required this.label,
    // @required this.textCtrl,
    // @required this.icon,
    // @required this.user,
    this.controller,
  }) : super(key: key);
  final controller;

  // MessageController _messageController =
  //     Get.put(MessageController(Get.arguments[0], Get.arguments[1]));
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> variables = [
      {
        'name': 'تاریخ امروز',
        'value': '{date_today}',
        // 'value': PersianDate().now.substring(0, 11),
      },
      {
        'name': 'نام مشتری',
        'value': '{name}',
        // 'value': user.name,
      },
      {
        'name': 'عنوان مشتری',
        'value': '{client_title}',
        // 'value': user.labelName,
      },
      {
        'name': 'تاریخ تولد',
        'value': '{birthday}',
        // 'value': user.labelName,
      },
      {
        'name': 'کد ملی مشتری',
        'value': '{national_code}',
        // 'value': user.nationId,
      },
      {
        'name': 'شماره همراه مشتری',
        'value': '{cell_number}',
        // 'value': user.phone,
      },
    ];
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          SizedBox(height: 20),
          InputBox(
            color: Colors.black,
            icon: Icons.format_quote,
            label: 'متن پیام',
            controller: controller.messageCtrl,
            minLines: 3,
            maxLines: 5,
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Color(0xFFE3E3E3),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SizedBox(width: 5 * AppSession.deviceBlockSize),
                Text(
                  ' متغیر های زیر را میتوانید در متن پیام خود استفاده کنید',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontSize: 3 * AppSession.deviceBlockSize,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Color(0xFFC5C5C5),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Icon(
                    FontAwesomeIcons.starOfLife,
                    color: Colors.black,
                    size: 4 * AppSession.deviceBlockSize,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Wrap(
              alignment: WrapAlignment.end,
              children: <Widget>[
                for (var variable in variables)
                  InkWell(
                    onTap: () =>
                        controller.messageCtrl.text += variable['value'],
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Color(0xFFEB5E00),
                        ),
                      ),
                      child: Text(
                        variable['name'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFEB5E00),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SendBtn extends StatefulWidget {
  final String id;
  final String operat;
  final TextEditingController contentCtrl;
  final GlobalKey<FormState> formKey;

  const SendBtn({
    Key key,
    @required this.id,
    @required this.operat,
    @required this.contentCtrl,
    @required this.formKey,
  }) : super(key: key);

  @override
  _SendBtnState createState() => _SendBtnState();
}

class _SendBtnState extends State<SendBtn> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (isLoading) {
          return;
        }
        if (!widget.formKey.currentState.validate()) {
          return;
        }
        setState(() {
          isLoading = true;
        });
        bool result = await MessageEntity()
            .sendMessage(widget.id, widget.contentCtrl.text, widget.operat);
        if (result) {
          widget.contentCtrl.text = '';
          await showDialog(
            context: context,
            builder: (ct) => GlobalAlertDialog(
              content: 'پیام با موفقیت ارسال شد.',
              title: 'موفقیت',
            ),
          );
          // Navigator.of(context).pop();
          // Navigator.of(context).popAndPushNamed(
          //   Routes.transactionsListScreen,
          //   arguments: user,
          // );
        } else {
          await showDialog(
            context: context,
            builder: (ct) => GlobalAlertDialog(
              content: 'متاسفانه خطایی رخ داده است.دوباره تلاش کنید.',
              title: 'خطا',
            ),
          );
        }
        setState(() {
          isLoading = false;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Color(0xFFEB5E00),
        ),
        child: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : Text(
                  'ارسال پیام',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 4.5 * AppSession.deviceBlockSize,
                  ),
                ),
        ),
      ),
    );
  }
}
