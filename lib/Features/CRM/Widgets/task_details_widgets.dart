import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:willaEngine/Cores/Models/option_model.dart';
import 'package:willaEngine/Features/CRM/Widgets/change_task_status.dart';

import '../../../Cores/Config/app_session.dart';
import '../../../Cores/Config/routes.dart';
import '../../../Cores/Widgets/alert_dialog.dart';
import '../Entities/tasks.dart';
import '../Models/client_task_object.dart';
import '../Models/user_details_object.dart';

class FourTopButtons extends StatelessWidget {
  final ClientTaskModel task;
  final ClientDetailsModel user;
  const FourTopButtons({
    Key key,
    @required this.task,
    @required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (ctx) => Directionality(
                textDirection: TextDirection.rtl,
                child: AlertDialog(
                  title: Text('حذف'),
                  content: Text('آیا برای حذف این کار مطمئن هستید؟'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () async {
                        var result = await TasksEntity().deleteTask(task.id);
                        if (result) {
                          Navigator.of(ctx).pop();
                          await showDialog(
                            context: context,
                            builder: (ct) => GlobalAlertDialog(
                              content: 'این کار با موفقیت حذف شد.',
                              title: 'موفقیت',
                            ),
                          );
                          Navigator.of(context).pop();
                          Navigator.of(context).popAndPushNamed(
                            Routes.clientTasksScreen,
                            arguments: user,
                          );
                        } else {
                          Navigator.of(ctx).pop();
                          await showDialog(
                            context: context,
                            builder: (ct) => GlobalAlertDialog(
                              content:
                                  'متاسفانه خطایی رخ داده است.دوباره تلاش کنید.',
                              title: 'خطا',
                            ),
                          );
                        }
                      },
                      child: Text('بله'),
                    ),
                    TextButton(
                      onPressed: () async {
                        Navigator.of(ctx).pop();
                      },
                      child: Text('خیر'),
                    ),
                  ],
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFEE3552).withOpacity(.5),
                  spreadRadius: 1,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 6 * AppSession.deviceBlockSize,
              backgroundColor: Color(0xFFEE3552),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  // color: Color(0xFFAC3773).withOpacity(.5),
                  color: Colors.grey.withOpacity(.5),
                  spreadRadius: 1,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 6 * AppSession.deviceBlockSize,
              backgroundColor: Colors.grey,
              // backgroundColor: Color(0xFFAC3773),
              child: Icon(
                FontAwesomeIcons.solidEnvelope,
                color: Colors.white,
                size: 6 * AppSession.deviceBlockSize,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.of(context)
              .pushNamed(Routes.commentsScreen, arguments: [task, 'task']).then(
            (value) => Navigator.of(context).popAndPushNamed(
              Routes.clienttaskDetailsScreen,
              arguments: [task, user],
            ),
          ),
          child: Container(
            height: 16 * AppSession.deviceBlockSize,
            width: 16 * AppSession.deviceBlockSize,
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.5),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 3 * AppSession.deviceBlockSize,
                      backgroundColor: Colors.black,
                      child: Text(
                        task.commentCount,
                        style: TextStyle(
                          fontFamily: 'montserrat',
                          fontSize: 3.5 * AppSession.deviceBlockSize,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.5),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 6 * AppSession.deviceBlockSize,
                      backgroundColor: Colors.black,
                      child: Icon(
                        FontAwesomeIcons.solidCommentAlt,
                        color: Colors.white,
                        size: 6 * AppSession.deviceBlockSize,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.of(context)
              .pushNamed(Routes.updateTaskScreen, arguments: task)
              .then(
                (value) => Navigator.of(context).popAndPushNamed(
                  Routes.clienttaskDetailsScreen,
                  arguments: [task, user],
                ),
              ),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  // color: Colors.grey.withOpacity(.5),
                  color: Color(0xFF32CAD5).withOpacity(.5),
                  spreadRadius: 1,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 6 * AppSession.deviceBlockSize,
              backgroundColor: Color(0xFF32CAD5),
              // backgroundColor: Colors.grey,
              child: Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class RowReport extends StatelessWidget {
  final String label;
  final String details;
  final IconData icon;
  final int fontSize;
  final textDirection;
  const RowReport({
    Key key,
    @required this.label,
    @required this.details,
    @required this.icon,
    @required this.fontSize,
    this.textDirection = TextDirection.rtl,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 25, left: 25, bottom: 15, top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                label,
                style: TextStyle(
                  color: Color(0xFFA5A5A5),
                  fontSize: 3 * AppSession.deviceBlockSize,
                ),
                textDirection: TextDirection.rtl,
              ),
              SizedBox(width: 3),
              Icon(
                icon,
                color: Color(0xFFA5A5A5),
                size: 5 * AppSession.deviceBlockSize,
              ),
            ],
          ),
          Text(
            details,
            textDirection: textDirection,
            style: TextStyle(
              fontSize: fontSize * AppSession.deviceBlockSize,
            ),
          ),
        ],
      ),
    );
  }
}

class TaskRow extends StatelessWidget {
  final ClientTaskModel task;
  final ClientDetailsModel user;
  final List<OptionModel> statuses;

  const TaskRow({
    Key key,
    @required this.task,
    @required this.user,
    @required this.statuses,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController statusCtrl =
        TextEditingController(text: task.status.title);
    return Container(
      // decoration: BoxDecoration(
      //     border: Border(
      //   bottom: BorderSide(
      //     color: Color(0xFFE3E3E3),
      //   ),
      // )),
      margin: EdgeInsets.only(
        left: 25,
        right: 25,
        top: 25,
      ),
      child: InkWell(
        onTap: () => Navigator.of(context)
            .pushNamed(Routes.clienttaskDetailsScreen, arguments: [task, user]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  task.sDate,
                  style: TextStyle(
                    fontSize: 4 * AppSession.deviceBlockSize,
                    color: Color(0xFFAC3773),
                  ),
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(width: 5),
                Container(
                  width: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF717171),
                  ),
                  child: Text(' '),
                ),
              ],
            ),
            Container(
              width: AppSession.deviceWidth - 40,
              child: Row(
                children: <Widget>[
                  ChangeTaskStatusWidget(
                    controller: statusCtrl,
                    task: task,
                    datas: statuses,
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          task.category,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontSize: 5 * AppSession.deviceBlockSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
