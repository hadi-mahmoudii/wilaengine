import 'package:flutter/material.dart';

import '../../../Cores/Config/app_session.dart';
import '../../../Cores/Config/routes.dart';
import '../Entities/clients.dart';
import '../Models/client_add_object.dart';

class SaveBTN extends StatefulWidget {
  final ClientAddObject newUser;
  final GlobalKey<FormState> formKey;
  SaveBTN({
    @required this.newUser,
    @required this.formKey,
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
        print(widget.newUser.birthday);
        if (!isLoading) {
          if (!widget.formKey.currentState.validate()) {
            return;
          }
          setState(() {
            isLoading = true;
          });
          ClientsEntity().createNewClient(widget.newUser).then((result) {
            Navigator.of(context).pop();
            Navigator.of(context).popAndPushNamed(Routes.clientListScreen);
            showDialog(
              context: context,
              builder: (ctx) => Directionality(
                textDirection: TextDirection.rtl,
                child: AlertDialog(
                  title: Text(result ? 'موفقیت' : 'خطا'),
                  content: Text(
                    result
                        ? 'مشتری جدید با موفقیت اضافه شد'
                        : 'خطا در اضافه کردن کاربر!',
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
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Color(0xFF32CAD5),
        ),
        child: Center(
          child: isLoading
              ? CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF32CAD5)),
                )
              : Text(
                  'ثبت مشتری',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 4.5 * AppSession.deviceBlockSize),
                ),
        ),
      ),
    );
  }
}
