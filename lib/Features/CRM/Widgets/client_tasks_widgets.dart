import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:willaEngine/Cores/Models/option_model.dart';
import 'package:willaEngine/Features/CRM/Widgets/change_task_status.dart';

import '../../../Cores/Config/app_session.dart';
import '../../../Cores/Config/routes.dart';
import '../../../Cores/Widgets/closable_header.dart';
import '../Models/client_task_object.dart';
import '../Models/user_details_object.dart';

class TaskRow extends StatelessWidget {
  final ClientTaskOverviewModel task;
  final ClientDetailsModel user;
  final List<OptionModel> statuses;
  final String index;

  const TaskRow({
    Key key,
    @required this.task,
    @required this.user,
    @required this.statuses,
    @required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController statusCtrl =
        TextEditingController(text: task.status.title);
    return Container(
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(
          color: Color(0xFFE3E3E3),
        ),
      )),
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
                  task.date,
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
                  // InkWell(
                  //   onTap: () => showDialog(
                  //     context: context,
                  //     builder: (ctx) => AlertDialog(
                  //       content: ChangeStatus(
                  //         ctx: ctx,
                  //       ),
                  //       contentPadding: EdgeInsets.all(10),
                  //     ),
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(3),
                  //     child: Icon(Icons.more_vert,
                  //         size: 8 * AppSession.deviceBlockSize),
                  //   ),
                  // ),
                  ChangeTaskStatusWidget(
                    controller: statusCtrl,
                    task: task,
                    datas: statuses,
                    // user: user,
                    // isOverview: true,
                  ),
                  // InkWell(
                  //   onTap: () => showDialog(
                  //     context: context,
                  //     builder: (ctx) => AlertDialog(
                  //       content: ChangeStatus(
                  //         ctx: ctx,
                  //       ),
                  //       contentPadding: EdgeInsets.all(10),
                  //     ),
                  //   ),
                  //   child: Container(
                  //     padding:
                  //         EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.only(
                  //           topLeft: Radius.circular(10),
                  //           bottomLeft: Radius.circular(10),
                  //           bottomRight: Radius.circular(10),
                  //         ),
                  //         color: Color(0xFFAC3773)
                  //         // task.status.title == ''
                  //         //     ? Colors.red
                  //         //     : Color(0xFF32CAD5),
                  //         ),
                  //     child: Text(
                  //       task.status.title == ''
                  //           ? 'بدون وضعیت'
                  //           : task.status.title,
                  //       style: TextStyle(
                  //         color: Colors.white,
                  //         fontSize: 3.5 * AppSession.deviceBlockSize,
                  //       ),
                  //     ),
                  //   ),
                  // ),
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
                        Text(
                          task.user,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontSize: 3.5 * AppSession.deviceBlockSize,
                            color: Color(0xFF717171),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    index,
                    style: TextStyle(
                      fontSize: 10 * AppSession.deviceBlockSize,
                      color: Color(0xFFAC3773),
                      fontFamily: 'montserrat',
                      height: 1.25,
                      fontWeight: FontWeight.w700,
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

class ChangeStatus extends StatefulWidget {
  const ChangeStatus({Key key, @required this.ctx}) : super(key: key);

  @override
  _ChangeStatusState createState() => _ChangeStatusState();
  final BuildContext ctx;
}

class _ChangeStatusState extends State<ChangeStatus> {
  int index = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          ClosableHeader(
            persian: 'تغییر وضعیت',
            english: 'CHANGE THE STATUS',
            ctx: widget.ctx,
          ),
          Divider(),
          GestureDetector(
            onTap: () {
              setState(() {
                index = 1;
              });
            },
            child: StatusRow(
              index: index,
              orgIndex: 1,
              color: Color(0xFFAC3773),
              pTitle: 'در حـــــــال انجــــــام',
              eTitle: 'working on it',
              icon: FontAwesomeIcons.redo,
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                index = 2;
              });
            },
            child: StatusRow(
              index: index,
              orgIndex: 2,
              color: Color(0xFF32CAD5),
              pTitle: 'انجــــــــــــام شـــــــــــده',
              eTitle: "It's done",
              icon: FontAwesomeIcons.check,
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                index = 3;
              });
            },
            child: StatusRow(
              index: index,
              orgIndex: 3,
              color: Color(0xFFEB5E00),
              pTitle: 'نیـــــــــــــاز به پیگیری',
              eTitle: 'Tracking',
              icon: Icons.person,
            ),
          ),
        ],
      ),
    );
  }
}

class StatusRow extends StatelessWidget {
  const StatusRow({
    Key key,
    @required this.index,
    @required this.orgIndex,
    @required this.color,
    @required this.pTitle,
    @required this.eTitle,
    @required this.icon,
  }) : super(key: key);

  final int index;
  final int orgIndex;
  final Color color;
  final String pTitle;
  final String eTitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        border: Border.all(
          color: color.withOpacity(index == orgIndex ? 1 : 0.4),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                pTitle,
                style: TextStyle(
                  fontSize: 4.5 * AppSession.deviceBlockSize,
                  fontWeight: FontWeight.w700,
                  color: color.withOpacity(index == orgIndex ? 1 : 0.4),
                ),
                textDirection: TextDirection.rtl,
                // textScaleFactor: _pixelRatio,
              ),
              Text(
                eTitle,
                style: TextStyle(
                  fontFamily: 'montserrat',
                  letterSpacing: 4,
                  color: color.withOpacity(index == orgIndex ? 1 : 0.4),
                  fontSize: 2.5 * AppSession.deviceBlockSize,
                ),
                textDirection: TextDirection.rtl,
                // textScaleFactor: _pixelRatio,
              ),
            ],
          ),
          SizedBox(width: 5),
          Icon(
            icon,
            color: color.withOpacity(index == orgIndex ? 1 : 0.4),
          ),
        ],
      ),
    );
  }
}
