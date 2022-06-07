import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../Cores/Config/app_session.dart';
import '../../../Cores/Config/urls.dart';
import '../../../Cores/Entities/server_request.dart';
import '../../../Cores/Models/error_result.dart';
import '../../../Cores/Models/option_model.dart';
import '../../../Cores/Widgets/empty.dart';

class ChangeTaskStatusWidget extends StatefulWidget {
  final TextEditingController controller;
  final task;
  final List<OptionModel> datas;

  const ChangeTaskStatusWidget({
    Key key,
    @required this.controller,
    @required this.datas,
    @required this.task,
  }) : super(key: key);

  @override
  _ChangeTaskStatusWidgetState createState() => _ChangeTaskStatusWidgetState();
}

class _ChangeTaskStatusWidgetState extends State<ChangeTaskStatusWidget> {
  bool isTapped = false;
  List<OptionModel> datas = [];
  bool isInit = true;
  @override
  void didChangeDependencies() {
    if (isInit) {
      datas = widget.datas;
      setState(() {
        isInit = false;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          builder: (mainCtx) => Container(
            padding: EdgeInsets.only(top: 15, right: 10, left: 10, bottom: 10),
            color: Colors.transparent,
            constraints: BoxConstraints(maxHeight: AppSession.deviceHeigth / 2),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Container(
                      height: 4,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(' '),
                    ),
                  ),
                  datas.length > 0
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (ctx, ind) => Container(
                            child: InkWell(
                              onTap: () async {
                                widget.controller.text = datas[ind].title;

                                var data = {
                                  'id': widget.task.id,
                                  'task_status[connect]': datas[ind].id,
                                };
                                final Either<ErrorResult, String> result =
                                    await ServerRequest<String>().updateData(
                                  Urls.tasks + '/' + widget.task.id,
                                  datas: data,
                                );
                                result.fold(
                                  (error) async {
                                    await ErrorResult.showDlg(
                                        error.type, context);
                                  },
                                  (result) {
                                    Fluttertoast.showToast(
                                      msg: "وضعیت به روز شد.",
                                    );
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                );
                              },
                              child: Container(
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                child: Text(
                                  datas[ind].title,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    color: AppSession.mainFontColor,
                                    fontSize: 4 * AppSession.deviceBlockSize,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          itemCount: datas.length,
                        )
                      : Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: EmptyWidget(),
                          ),
                        ),
                ],
              ),
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            color: Color(0xFFAC3773)
            // task.status.title == ''
            //     ? Colors.red
            //     : Color(0xFF32CAD5),
            ),
        child: Text(
          widget.controller.text == '' ? 'بدون وضعیت' : widget.controller.text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 3.5 * AppSession.deviceBlockSize,
          ),
        ),
      ),
    );
  }
}
