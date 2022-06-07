import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:willaEngine/Features/CRM/Widgets/client_details_widgets.dart'
    as widgets;

import '../../../Cores/Widgets/header.dart';
import '../../../Cores/Widgets/screens_header.dart';
import '../Entities/clients.dart';

class ClientDetailsScreenOld extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String userId = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      body: FutureBuilder(
        builder: (ctx, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(
              child: Text('Error'),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              children: <Widget>[
                GlobalScreensHeader(
                  backLabel: 'لیست مشتریان',
                  eName: '',
                  pName: snapshot.data.name,
                  icon: FontAwesomeIcons.userAlt,
                ),
                SizedBox(
                  height: 10,
                ),
                widgets.FiveTopButtons(user: snapshot.data),
                SizedBox(
                  height: 30,
                ),
                widgets.LoadedFiles(
                  number: snapshot.data.medias.length.toString(),
                  title: 'فایــــــــــــــل\nبارگزاری شده',
                  color: Color(0xFF32CAD5),
                  user: snapshot.data,
                ),
                widgets.TaskDone(
                  number: snapshot.data.tasksCount,
                  title: 'خــــــــدمت\nانجام شده',
                  color: Color(0xFFAC3773),
                  user: snapshot.data,
                ),
                widgets.TransactionDone(
                  number: snapshot.data.transactions.toString(),
                  title: 'مجموع تراکنش ها - تومان',
                  color: Colors.black,
                  user: snapshot.data,
                ),
                SizedBox(
                  height: 50,
                ),
                SimpleHeader('سایر اطلاعات', 'OTHER DETAILS'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Divider(height: 1),
                ),
                widgets.HBDRow(
                  birthDay: snapshot.data.birthday,
                  labelName: snapshot.data.labelName,
                ),
                widgets.DataRow(title: 'نام پدر', value: snapshot.data.father),
                widgets.DataRow(
                  title: 'کد ملی',
                  value: snapshot.data.nationId,
                  mainColor: Color(0xFFC5C5C5),
                ),
                widgets.DataRow(
                    title: 'کد مشتری', value: snapshot.data.customerId),
                widgets.DataRow(
                  title: 'دسته ی مشتری',
                  value: snapshot.data.customerCategory,
                  mainColor: Color(0xFFC5C5C5),
                ),
                widgets.DataRow(
                    title: 'شماره تماس', value: snapshot.data.phone),
                widgets.AllInfo(
                  bigTitle: 'همه ی اطلاعات مشتری',
                  title: 'شامل آدرس ها، شماره تماس ها و...',
                  color: Colors.black,
                  user: snapshot.data,
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            );
          }
        },
        future: ClientsEntity().getSingleClientData(userId),
      ),
    );
  }
}
