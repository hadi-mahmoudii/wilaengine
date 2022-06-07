import 'package:flutter/material.dart';

import '../../../Cores/Config/app_session.dart';
import '../../../Cores/Config/routes.dart';
import '../../../Cores/Widgets/screens_header.dart';
import '../Widgets/messages_list_widgets.dart';

class MessagesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        margin: EdgeInsets.only(left: AppSession.deviceWidth * .1),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: InkWell(
            onTap: () =>
                Navigator.of(context).pushNamed(Routes.sendMessageScreen),
            child: CircleAvatar(
              radius: 8 * AppSession.deviceBlockSize,
              backgroundColor: Color(0xFFEB5E00),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 15 * AppSession.deviceBlockSize,
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          GlobalScreensHeader(
            backLabel: 'بازگشت',
            eName: 'SMS LIST',
            pName: 'لیست پیام کوتاه',
            icon: Icons.format_align_left,
          ),
          MessageRow(
            numberSender: 'خط تبلیغاتی',
            date: 'سه شنبه، 11 تیر 1399، 13:32',
            index: '1',
            message:
                'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد، کتابهای زیادی در شصت و سه درصد گذشته حال و آینده، ',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Divider(),
          ),
          MessageRow(
            numberSender: 'خط تبلیغاتی',
            date: 'سه شنبه، 11 تیر 1399، 13:32',
            index: '2',
            message:
                'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد، کتابهای زیادی در شصت و سه درصد گذشته حال و آینده، ',
          ),
        ],
      ),
    );
  }
}
