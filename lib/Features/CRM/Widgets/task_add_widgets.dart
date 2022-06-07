import 'package:flutter/material.dart';

import '../../../Cores/Config/app_session.dart';
import '../../../Cores/Config/routes.dart';
import '../Entities/clients.dart';
import '../Models/client_task_object.dart';
import '../Models/user_details_object.dart';

class SaveBTN extends StatefulWidget {
  final TaskAddObject task;
  final ClientDetailsModel user;
  SaveBTN({
    @required this.task,
    @required this.user,
  });

  @override
  _SaveBTNState createState() => _SaveBTNState();
}

class _SaveBTNState extends State<SaveBTN> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!isLoading) {
          setState(() {
            isLoading = true;
          });
          ClientsEntity().createNewTask(widget.task).then((result) {
            Navigator.of(context).pop();
            Navigator.of(context).popAndPushNamed(Routes.clientTasksScreen,
                arguments: widget.user);
            showDialog(
              context: context,
              builder: (ctx) => Directionality(
                textDirection: TextDirection.rtl,
                child: AlertDialog(
                  title: Text(result ? 'موفقیت' : 'خطا'),
                  content: Text(
                    result
                        ? 'کار جدید با موفقیت اضافه شد'
                        : 'خطا در اضافه کردن کارجدید!',
                  ),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () async {
                          Navigator.of(ctx).pop();
                        },
                        child: Text('Ok'))
                  ],
                ),
              ),
            );
          });
        }
        print(widget.task.category.text);
        print(widget.task.user.text);
        print(widget.task.sDate.text);
        print(widget.task.eDate.text);
        print(widget.task.label.text);
        print(widget.task.details.text);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Color(0xFFAC3773),
        ),
        child: Center(
          child: Text(
            'ثبت خدمت',
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
