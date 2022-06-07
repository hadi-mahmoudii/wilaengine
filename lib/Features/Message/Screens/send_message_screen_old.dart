import 'package:flutter/material.dart';

import '../../../Cores/Widgets/drop_down.dart';
import '../../../Cores/Widgets/screens_header.dart';
import '../Entities/message.dart';
import '../Models/messages.dart';
import '../Widgets/send_messages_widgets.dart';

class SendMessageScreen extends StatefulWidget {
  @override
  _SendMessageScreenState createState() => _SendMessageScreenState();
}

class _SendMessageScreenState extends State<SendMessageScreen> {
  final formKey = GlobalKey<FormState>();
  String senderOperator = 'advertise';
  bool isInit = true;
  List<MessageTemplateObject> templates = [];
  List<String> templateNames = [];
  List<Map<String, String>> operators = [
    {'name': 'سیم کارت', 'value': 'simcard'},
    {'name': 'تبلیغاتی', 'value': 'advertise'},
  ];
  List<String> operatorNames = ['تبلیغاتی', 'سیم کارت'];
  final TextEditingController _templateCtrl = new TextEditingController();
  final TextEditingController _numberCtrl = new TextEditingController();
  final TextEditingController _messageCtrl = new TextEditingController();
  var user;
  @override
  void didChangeDependencies() async {
    if (isInit) {
      user = ModalRoute.of(context).settings.arguments as String;
      templates = await MessageEntity().getMessageTemplates();
      for (var template in templates) {
        templateNames.add(template.name);
      }
      setState(() {
        isInit = false;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isInit
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: formKey,
              child: ListView(
                children: <Widget>[
                  GlobalScreensHeader(
                    backLabel: 'لیست پیام ها',
                    eName: 'SEND A MESSAGE',
                    pName: 'ارسال پیام کوتاه',
                    icon: Icons.comment,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DropDownBox(
                    label: 'قالب پیام کوتاه',
                    icon: Icons.format_align_left,
                    values: templateNames,
                    ctrl: _templateCtrl,
                    func: (var data) {
                      templates.forEach((element) {
                        if (element.name == data) {
                          _messageCtrl.text = element.template;
                        }
                      });
                    },
                  ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  DropDownBox(
                    label: 'شماره خط ارسال کننده',
                    icon: Icons.format_align_left,
                    values: operatorNames,
                    ctrl: _numberCtrl,
                    func: (var data) {
                      operators.forEach((element) {
                        if (element['name'] == data) {
                          setState(() {
                            senderOperator = element['value'];
                          });
                        }
                      });
                    },
                  ),
                  // MessageBox(
                  //   label: 'متن پیام',
                  //   textCtrl: _messageCtrl,
                  //   icon: Icons.format_quote,
                  //   // user: user,
                  // ),
                  SendBtn(
                    id: user,
                    operat: senderOperator,
                    contentCtrl: _messageCtrl,
                    formKey: formKey,
                  ),
                ],
              ),
            ),
    );
  }
}
