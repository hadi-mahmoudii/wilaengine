import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:willaEngine/Features/CRM/Widgets/client_info_widgets.dart'
    as widgets;

import '../../../Cores/Widgets/header3.dart';
import '../../../Cores/Widgets/screens_header.dart';
import '../Models/user_details_object.dart';

class ClientInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ClientDetailsModel user =
        ModalRoute.of(context).settings.arguments as ClientDetailsModel;
    return Scaffold(
      body: ListView(
        children: <Widget>[
          GlobalScreensHeader(
            backLabel: user.name,
            eName: 'CLIENT INFO',
            pName: 'اطلاعات مشتری',
            icon: Icons.format_align_left,
          ),
          widgets.HBDRow(
            birthDay: user.birthday,
            labelName: user.labelName,
          ),
          widgets.DataRow(title: 'نام پدر', value: user.father),
          widgets.DataRow(
            title: 'کد ملی',
            value: user.nationId,
            mainColor: Color(0xFFC5C5C5),
          ),
          widgets.DataRow(title: 'کد مشتری', value: user.customerId),
          widgets.DataRow(
            title: 'دسته ی مشتری',
            value: user.customerCategory,
            mainColor: Color(0xFFC5C5C5),
          ),
          widgets.DataRow(title: 'شماره تماس', value: user.phone),
          SizedBox(
            height: 50,
          ),
          SimpleHeader3(
            persian: 'آدرس ها',
            english: 'ADDRESSES',
            icon: FontAwesomeIcons.mapMarkedAlt,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Divider(height: 1),
          ),
          widgets.AddressRow(
            address:
                'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان ',
            number: '021-44449769',
            city: 'تهران، ولنجک',
            postalCode: '142658942',
            index: '1',
          ),
          widgets.AddressRow(
            address:
                'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان ',
            number: '021-44449769',
            city: 'قم، عطاران',
            postalCode: '',
            index: '2',
          ),
          SizedBox(
            height: 50,
          ),
          SimpleHeader3(
            persian: 'شماره تماس ها',
            english: 'CONTACT NUMBERS',
            icon: Icons.call,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Divider(height: 1),
          ),
          widgets.NumberRow(
            index: '1',
            number: '09127004945',
            label: 'شماره همراه',
          ),
          widgets.NumberRow(
            index: '2',
            number: '09121121416',
            label: 'مدیر فروش - محمدی',
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
