import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../Cores/Config/app_session.dart';
import '../../../Cores/Config/routes.dart';
import '../../../Cores/Widgets/alert_dialog.dart';
import '../Entities/clients.dart';
import '../Models/user_details_object.dart';

class FiveTopButtons extends StatelessWidget {
  final ClientDetailsModel user;
  const FiveTopButtons({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        GestureDetector(
          onTap: () async {
            showDialog(
              context: context,
              builder: (ctx) => Directionality(
                textDirection: TextDirection.rtl,
                child: AlertDialog(
                  title: Text('حذف'),
                  content: Text('آیا برای حذف این مشتری مطمئن هستید؟'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () async {
                        var result =
                            await ClientsEntity().deleteClient(user.id);
                        if (result) {
                          Navigator.of(ctx).pop();
                          await showDialog(
                            context: context,
                            builder: (ct) => GlobalAlertDialog(
                              content: 'این مشتری با موفقیت حذف شد.',
                              title: 'موفقیت',
                            ),
                          );
                          Navigator.of(context).pop();
                          Navigator.of(context)
                              .popAndPushNamed(Routes.clientListScreen);
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
        Opacity(
          opacity: .25,
          child: GestureDetector(
            // onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    // color: Color(0xFFAC3773).withOpacity(.5),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 6 * AppSession.deviceBlockSize,
                // backgroundColor: Color(0xFFAC3773),
                backgroundColor: Colors.grey,
                child: Icon(
                  FontAwesomeIcons.solidEnvelope,
                  color: Colors.white,
                  size: 6 * AppSession.deviceBlockSize,
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          // onTap: () => Navigator.of(context).pushNamed(Routes.messagesScreen),
          onTap: () => Navigator.of(context).pushNamed(
            Routes.sendMessageScreen,
            arguments: user,
          ),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFEB5E00).withOpacity(.5),
                  spreadRadius: 1,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 6 * AppSession.deviceBlockSize,
              backgroundColor: Color(0xFFEB5E00),
              child: Icon(
                Icons.message,
                color: Colors.white,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.of(context)
              .pushNamed(Routes.commentsScreen, arguments: [user, 'user']).then(
            (value) => Navigator.of(context).popAndPushNamed(
              Routes.clientDetailsScreen,
              arguments: user.id,
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
                        user.commentCount,
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
              .pushNamed(Routes.updateClientScreen, arguments: user)
              .then(
                (value) => Navigator.of(context).popAndPushNamed(
                  Routes.clientDetailsScreen,
                  arguments: user.id,
                ),
              ),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF32CAD5).withOpacity(.5),
                  // color: Colors.grey,
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

class LoadedFiles extends StatelessWidget {
  final ClientDetailsModel user;
  final String number;

  final String title;
  final Color color;
  const LoadedFiles({
    Key key,
    @required this.user,
    @required this.number,
    @required this.title,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .pushNamed(Routes.clientFileScreen, arguments: user)
          .then(
            // this use for refresh page
            (value) => Navigator.of(context).popAndPushNamed(
              Routes.clientDetailsScreen,
              arguments: user.id,
            ),
          ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: color),
            bottom: BorderSide(color: color),
          ),
        ),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // borderRadius: BorderRadius.circular(25),
                border: Border.all(color: color),
              ),
              child: Icon(
                Icons.add,
                color: color,
                size: 8 * AppSession.deviceBlockSize,
              ),
            ),
            Spacer(),
            Text(
              title,
              style: TextStyle(color: color),
              textDirection: TextDirection.rtl,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              number,
              style: TextStyle(
                color: color,
                fontSize: 10 * AppSession.deviceBlockSize,
                fontFamily: 'montserrat',
                fontWeight: FontWeight.w700,
              ),
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
      ),
    );
  }
}

class TaskDone extends StatelessWidget {
  final String number;
  final String title;
  final Color color;
  final ClientDetailsModel user;
  const TaskDone({
    Key key,
    @required this.number,
    @required this.title,
    @required this.color,
    @required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .pushNamed(Routes.clientTasksScreen, arguments: user),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: color),
            bottom: BorderSide(color: color),
          ),
        ),
        child: Row(
          children: <Widget>[
            InkWell(
              onTap: () => Navigator.of(context)
                  .pushNamed(Routes.addTaskScreen, arguments: user),
              child: Container(
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: color),
                ),
                child: Icon(
                  Icons.add,
                  color: color,
                  size: 8 * AppSession.deviceBlockSize,
                ),
              ),
            ),
            Spacer(),
            Text(
              title,
              style: TextStyle(color: color),
              textDirection: TextDirection.rtl,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              number,
              style: TextStyle(
                color: color,
                fontSize: 10 * AppSession.deviceBlockSize,
                fontFamily: 'montserrat',
                fontWeight: FontWeight.w700,
              ),
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionDone extends StatelessWidget {
  final ClientDetailsModel user;
  final String number;
  final String title;
  final Color color;
  const TransactionDone({
    Key key,
    @required this.user,
    @required this.number,
    @required this.title,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .pushNamed(Routes.transactionsListScreen, arguments: user),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: color),
            bottom: BorderSide(color: color),
          ),
          color: Color(0xFFEFEFEF),
        ),
        child: Row(
          children: <Widget>[
            // Container(
            //   padding: EdgeInsets.all(1),
            //   decoration: BoxDecoration(
            //     shape: BoxShape.circle,
            //     // borderRadius: BorderRadius.circular(25),
            //     border: Border.all(color: color),
            //   ),
            //   child: Icon(
            //     Icons.add,
            //     color: color,
            //     size: 8 * AppSession.deviceBlockSize,
            //   ),
            // ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  number,
                  style: TextStyle(
                    color: color,
                    fontSize: 8 * AppSession.deviceBlockSize,
                    fontFamily: 'montserrat',
                    fontWeight: FontWeight.w700,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  title,
                  style: TextStyle(color: Colors.grey),
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HBDRow extends StatelessWidget {
  final String birthDay;
  final String labelName;

  const HBDRow({
    Key key,
    @required this.birthDay,
    @required this.labelName,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: (birthDay == '' && labelName == '') ? 0 : 15,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 25,
        vertical: (birthDay == '' && labelName == '') ? 0 : 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          labelName == ''
              ? Container()
              : Container(
                  width: (AppSession.deviceWidth - 50) * .5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'عنوان مشتری',
                            style: TextStyle(color: Colors.grey),
                            textAlign: TextAlign.end,
                            textDirection: TextDirection.rtl,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Icon(
                            FontAwesomeIcons.tags,
                            color: Colors.grey,
                            size: 4 * AppSession.deviceBlockSize,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        labelName,
                        style: TextStyle(
                          fontSize: 4.5 * AppSession.deviceBlockSize,
                          fontFamily: 'iranyekan',
                        ),
                        textAlign: TextAlign.end,
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                ),
          birthDay == '' ? Container() : Spacer(),
          birthDay == ''
              ? Container()
              : Container(
                  width: (AppSession.deviceWidth - 50) * .45,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'سالروز تولد',
                            style: TextStyle(color: Colors.grey),
                            textAlign: TextAlign.end,
                            textDirection: TextDirection.rtl,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Icon(
                            FontAwesomeIcons.birthdayCake,
                            color: Colors.grey,
                            size: 4 * AppSession.deviceBlockSize,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        birthDay,
                        style: TextStyle(
                          fontSize: 4.5 * AppSession.deviceBlockSize,
                          fontFamily: 'iranyekan',
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}

class DataRow extends StatelessWidget {
  final String title;
  final String value;
  final Color mainColor;
  final Color borderColor;
  final String fontFamily;

  const DataRow({
    Key key,
    @required this.title,
    @required this.value,
    this.mainColor = Colors.white,
    this.borderColor = Colors.white,
    this.fontFamily = 'iranyekan',
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return value == ''
        ? Container()
        : Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: borderColor),
                bottom: BorderSide(color: borderColor),
              ),
              color: mainColor.withOpacity(.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: (AppSession.deviceWidth - 50) * .5,
                  child: Text(
                    value,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 4.5 * AppSession.deviceBlockSize,
                      fontFamily: fontFamily,
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  title,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 4.5 * AppSession.deviceBlockSize,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          );
  }
}

class VerticalDataRow extends StatelessWidget {
  final String title;
  final String value;
  final Color mainColor;
  final Color borderColor;

  const VerticalDataRow({
    Key key,
    @required this.title,
    @required this.value,
    this.mainColor = Colors.white,
    this.borderColor = Colors.white,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return value == ''
        ? Container()
        : Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: borderColor),
                bottom: BorderSide(color: borderColor),
              ),
              color: mainColor.withOpacity(.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  title,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 4.5 * AppSession.deviceBlockSize,
                    color: Colors.grey,
                  ),
                ),
                Container(
                  width: (AppSession.deviceWidth - 50) * .5,
                  child: Text(
                    value,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 4 * AppSession.deviceBlockSize,
                      // fontFamily: 'iranyekanlight',
                    ),
                  ),
                ),
                // Spacer(),
              ],
            ),
          );
  }
}

class UserSubDetailsRow extends StatelessWidget {
  final String name;
  final String id;
  final Color mainColor;
  final Color borderColor;
  final String fontFamily;

  const UserSubDetailsRow({
    Key key,
    @required this.name,
    @required this.id,
    this.mainColor = Colors.white,
    this.borderColor = Colors.white,
    this.fontFamily = 'iranyekanlight',
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return id == ''
        ? Container()
        : Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: borderColor),
                bottom: BorderSide(color: borderColor),
              ),
              color: mainColor.withOpacity(.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: (AppSession.deviceWidth - 50) * .5,
                  child: Text(
                    id,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 4.5 * AppSession.deviceBlockSize,
                      fontFamily: fontFamily,
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  name,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 4.5 * AppSession.deviceBlockSize,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          );
  }
}

class TagsRow extends StatelessWidget {
  final String title;
  final List<String> tags;
  final Color mainColor;
  final Color borderColor;

  const TagsRow({
    Key key,
    @required this.title,
    @required this.tags,
    this.mainColor = Colors.white,
    this.borderColor = Colors.white,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return tags.isEmpty
        ? Container()
        : Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: borderColor),
                bottom: BorderSide(color: borderColor),
              ),
              color: mainColor.withOpacity(.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  title,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 4.5 * AppSession.deviceBlockSize,
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Wrap(
                    alignment: WrapAlignment.end,
                    children: <Widget>[
                      for (var tag in tags)
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          padding: EdgeInsets.symmetric(
                            vertical: 3,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.black,
                            // border: Border.all(
                            //   color: Color(0xFFEB5E00),
                            // ),
                          ),
                          child: Text(
                            tag,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 4 * AppSession.deviceBlockSize,
                              fontFamily: 'iranyekanlight',
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                // Container(
                //   width: (AppSession.deviceWidth - 50) * .5,
                //   child: Text(
                //     value,
                //     textAlign: TextAlign.right,
                //     style: TextStyle(
                //       fontSize: 4.5 * AppSession.deviceBlockSize,
                //       fontFamily: 'iranyekanlight',
                //     ),
                //   ),
                // ),
                // Spacer(),
              ],
            ),
          );
  }
}

class AllInfo extends StatelessWidget {
  final ClientDetailsModel user;
  final String bigTitle;
  final String title;
  final Color color;
  const AllInfo({
    Key key,
    @required this.bigTitle,
    @required this.title,
    @required this.color,
    @required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(
        Routes.clientMoreDetailsScreen,
        arguments: user,
      ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: color),
            bottom: BorderSide(color: color),
          ),
          color: Color(0xFFEFEFEF),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(25),
                border: Border.all(color: color),
                shape: BoxShape.circle,
              ),
              child: Icon(
                FontAwesomeIcons.arrowLeft,
                color: color.withOpacity(.9),
              ),
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  bigTitle,
                  style: TextStyle(
                    color: color,
                    fontSize: 6 * AppSession.deviceBlockSize,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  title,
                  style: TextStyle(color: Colors.grey),
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AddressRow extends StatelessWidget {
  final ClientAddressModel address;
  final String index;

  const AddressRow({
    Key key,
    @required this.address,
    @required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      width: AppSession.deviceWidth - 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Color(0xFFA5A5A5)),
        color: Color(0xFFF5F5F5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Text(
                  '${address.city} ، ${address.title}',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 4 * AppSession.deviceBlockSize,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  address.address,
                  style: TextStyle(
                    color: Color(0xFF707070),
                    fontSize: 3.5 * AppSession.deviceBlockSize,
                    // height: 1.1,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(height: 5),
                address.postalCode != ''
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            address.postalCode,
                            style: TextStyle(
                              fontSize: 6 * AppSession.deviceBlockSize,
                              // fontWeight: FontWeight.w700,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                          Text(
                            'کدپستی : ',
                            style: TextStyle(
                              fontSize: 6 * AppSession.deviceBlockSize,
                              fontFamily: 'montserrat',
                              height: 1,
                              fontWeight: FontWeight.w700,
                            ),
                            textDirection: TextDirection.rtl,
                            // textAlign: TextAlign.right,
                          )
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
          SizedBox(width: 10),
          Text(
            index,
            style: TextStyle(
              fontSize: 12 * AppSession.deviceBlockSize,
              // height: .5,
              color: Color(0xFFC5C5C5),
              fontFamily: 'montserrat',
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class PhoneRow extends StatelessWidget {
  final ClientPhoneModel phone;
  final String index;

  const PhoneRow({
    Key key,
    @required this.phone,
    @required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      width: AppSession.deviceWidth - 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Color(0xFFA5A5A5)),
        color: Color(0xFFF5F5F5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            phone.phone,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.black,
              fontSize: 4 * AppSession.deviceBlockSize,
              fontFamily: 'montserrat',
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              phone.label,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Color(0XFF707070),
                fontSize: 4.25 * AppSession.deviceBlockSize,
              ),
            ),
          ),
          SizedBox(width: 10),
          Text(
            index,
            style: TextStyle(
              fontSize: 12 * AppSession.deviceBlockSize,
              // height: .5,
              color: Color(0xFFC5C5C5),
              fontFamily: 'montserrat',
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
