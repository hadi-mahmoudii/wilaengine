import 'package:flutter/material.dart';

import '../../../Cores/Config/app_session.dart';
import '../../../Cores/Config/routes.dart';
import '../../../Cores/Entities/global.dart';
import '../Models/user_details_object.dart';

class SaveBTN extends StatefulWidget {
  final ClientDetailsModel user;
  // final List<File> files;
  final String batchId;
  SaveBTN({
    @required this.user,
    @required this.batchId,
  });

  @override
  _SaveBTNState createState() => _SaveBTNState();
}

class _SaveBTNState extends State<SaveBTN> {
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!isloading) {
          setState(() {
            isloading = true;
          });
          GlobalEntity().addFiles(widget.user, widget.batchId).then((result) {
            Navigator.of(context).pop();
            Navigator.of(context).popAndPushNamed(Routes.clientDetailsScreen,
                arguments: widget.user.id);
            showDialog(
              context: context,
              builder: (ctx) => Directionality(
                textDirection: TextDirection.rtl,
                child: AlertDialog(
                  title: Text(result ? 'موفقیت' : 'خطا'),
                  content: Text(
                    result
                        ? 'فایل های جدید با موفقیت اضافه شد'
                        : 'خطا در اضافه کردن فایل!',
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
        } else {}
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.green,
        ),
        child: Center(
          child: isloading
              ? CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                )
              : Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 12 * AppSession.deviceBlockSize,
                ),
        ),
      ),
    );
  }
}
