import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:willaEngine/Cores/Widgets/header3.dart';
import 'package:willaEngine/Features/CRM/Widgets/client_details_widgets.dart'
    as widgets;
import 'package:willaEngine/Features/CRM/Widgets/client_details_widgets.dart';

import '../../../Cores/Config/app_session.dart';
import '../../../Cores/Widgets/screens_header.dart';
import '../Models/user_details_object.dart';

class ClientMoreDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ClientDetailsModel user = ModalRoute.of(context).settings.arguments;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          child: GlobalScreensHeader(
            backLabel: 'اطلاعات مشتری',
            eName: '',
            pName: 'همه ی اطلاعات مشتری',
            icon: FontAwesomeIcons.userAlt,
          ),
          preferredSize: Size(
            double.infinity,
            AppSession.deviceHeigth * 0.155,
          ),
        ),
        body: ListView(
          children: <Widget>[
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Divider(height: 1),
            ),
            widgets.HBDRow(birthDay: user.birthday, labelName: user.labelName),
            widgets.DataRow(title: 'نام پدر', value: user.father),
            widgets.DataRow(
              title: 'کد ملی',
              value: user.nationId,
              mainColor: Color(0xFFF1F1F1),
              borderColor: Color(0xFFC5C5C5),
              fontFamily: 'montserrat',
            ),
            widgets.DataRow(title: 'کد مشتری', value: user.customerId),
            widgets.DataRow(
              title: 'دسته ی مشتری',
              value: user.customerCategory,
              mainColor: Color(0xFFF1F1F1),
              borderColor: Color(0xFFC5C5C5),
            ),
            widgets.DataRow(
              title: 'شماره تماس',
              value: user.phone,
              fontFamily: 'montserrat',
            ),
            widgets.VerticalDataRow(
              title: 'توضیحات',
              value: user.description,
              mainColor: Color(0xFFF1F1F1),
              borderColor: Color(0xFFC5C5C5),
            ),
            widgets.DataRow(
              title: 'صفحه ی اینستاگرام',
              value: user.instagram,
              fontFamily: 'montserrat',
            ),
            widgets.TagsRow(
              title: 'برچسب ها',
              tags: user.tags,
              mainColor: Color(0xFFF1F1F1),
              borderColor: Color(0xFFC5C5C5),
            ),
            SizedBox(height: 40),
            SimpleHeader3(
              persian: 'آدرس ها',
              english: 'Addresses',
              icon: Icons.location_city,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (ctx, index) => AddressRow(
                address: user.addresses[index],
                index: (index + 1).toString(),
              ),
              itemCount: user.addresses.length,
            ),
            SizedBox(height: 40),
            SimpleHeader3(
              persian: 'شماره تماس ها',
              english: 'Contact numbers',
              icon: Icons.phone,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (ctx, index) => PhoneRow(
                phone: user.phones[index],
                index: (index + 1).toString(),
              ),
              itemCount: user.phones.length,
            ),
            SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}

