import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../Cores/Config/routes.dart';
import '../../../Cores/Widgets/alert_dialog.dart';
import '../Entities/transactions.dart';
import '../Models/user_details_object.dart';

import '../../../Cores/Config/app_session.dart';
import '../Models/transaction_object.dart';

class TransactionRow extends StatelessWidget {
  final TransactionOverviewModel transaction;

  const TransactionRow({Key key, @required this.transaction}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Text(
          //   'آیــــــــتم\nخریداری\nشــــــــده',
          //   textAlign: TextAlign.right,
          //   style: TextStyle(
          //     color: Color(0xFF32CAD5),
          //   ),
          // ),
          SizedBox(
            width: 10,
          ),
          // Text(
          //   transaction.itemcount,
          //   style: TextStyle(
          //     fontSize: 12 * AppSession.deviceBlockSize,
          //     color: Color(0xFF32CAD5),
          //     fontFamily: 'montserrat',
          //     // height: 1.25,
          //   ),
          // ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'تومان',
                    style: TextStyle(
                      // fontSize: 4 * AppSession.deviceBlockSize,
                      color: Color(0xFF808080),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    transaction.amount,
                    style: TextStyle(
                      fontSize: 6.5 * AppSession.deviceBlockSize,
                      fontFamily: 'montserrat',
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
              SizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    transaction.date,
                    style: TextStyle(
                      fontSize: 2.5 * AppSession.deviceBlockSize,
                      color: Color(0xFFA5A5A5),
                    ),
                    // textDirection: TextDirection.rtl,
                  ),
                  Icon(
                    FontAwesomeIcons.clock,
                    size: 2.5 * AppSession.deviceBlockSize,
                    color: Color(0xFFA5A5A5),
                  )
                ],
              ),
              SizedBox(height: 5),
              transaction.transactionTitle != ''
                  ? Row(
                      children: <Widget>[
                        Text(
                          transaction.transactionTitle,
                          style: TextStyle(
                            fontSize: 2.5 * AppSession.deviceBlockSize,
                            color: Color(0xFFA5A5A5),
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        SizedBox(width: 3),
                        Icon(
                          Icons.category,
                          size: 2.5 * AppSession.deviceBlockSize,
                          color: Color(0xFFA5A5A5),
                        )
                      ],
                    )
                  : Container(),
            ],
          )
        ],
      ),
    );
  }
}

class TwoTopButtons extends StatelessWidget {
  final TransactionOverviewModel transaction;
  final ClientDetailsModel user;

  const TwoTopButtons({
    Key key,
    @required this.transaction,
    @required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color(0xFFE3E3E3),
          ),
          bottom: BorderSide(
            color: Color(0xFFE3E3E3),
          ),
        ),
      ),
      margin: EdgeInsets.symmetric(horizontal: 25),
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
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
                    content: Text('آیا برای حذف این تراکنش مطمئن هستید؟'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () async {
                          var result = await TransactionsEntity()
                              .deleteTransaction(transaction.id);
                          if (result) {
                            Navigator.of(ctx).pop();
                            await showDialog(
                              context: context,
                              builder: (ct) => GlobalAlertDialog(
                                content: 'این تراکنش با موفقیت حذف شد.',
                                title: 'موفقیت',
                              ),
                            );
                            Navigator.of(context).pop();
                            Navigator.of(context).popAndPushNamed(
                              Routes.transactionsListScreen,
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
          Spacer(),
          GestureDetector(
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
        ],
      ),
    );
  }
}

class RowReport extends StatelessWidget {
  final String label;
  final String details;
  final IconData icon;
  final int fontSize;
  const RowReport({
    Key key,
    @required this.label,
    @required this.details,
    @required this.icon,
    @required this.fontSize,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 25, left: 25, top: 15),
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
                  // fontSize: 3 * AppSession.deviceBlockSize,
                ),
                textDirection: TextDirection.rtl,
              ),
              Icon(
                icon,
                color: Color(0xFFA5A5A5),
                size: 5 * AppSession.deviceBlockSize,
              ),
            ],
          ),
          Text(
            details,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontSize: fontSize * AppSession.deviceBlockSize,
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentItemRow extends StatelessWidget {
  final String itemCount;
  final String label;
  final String itemPrice;
  final String index;
  final String description;

  const PaymentItemRow({
    Key key,
    @required this.itemCount,
    @required this.label,
    @required this.itemPrice,
    @required this.index,
    @required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Color(0xFFA5A5A5)),
        color: Color(0xFFF5F5F5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
              Text(
                'عدد',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Color(0xFF32CAD5),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                itemCount,
                style: TextStyle(
                  fontSize: 12 * AppSession.deviceBlockSize,
                  color: Color(0xFF32CAD5),
                  fontFamily: 'montserrat',
                  fontWeight: FontWeight.w700,
                  height: .5,
                ),
              ),
              Spacer(),
              Text(
                'تومان',
                style: TextStyle(
                  // fontSize: 4 * AppSession.deviceBlockSize,
                  color: Color(0xFF808080),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 6 * AppSession.deviceBlockSize,
                      // fontWeight: FontWeight.w700,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  Text(
                    itemPrice,
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
              ),
              SizedBox(width: 5),
              Text(
                index,
                style: TextStyle(
                  fontSize: 12 * AppSession.deviceBlockSize,
                  height: .5,
                  color: Color(0xFFC5C5C5),
                  fontFamily: 'montserrat',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Divider(),
          Text(
            description,
            style: TextStyle(
                color: Color(0xFF707070),
                fontSize: 3.5 * AppSession.deviceBlockSize,
                height: 1.1),
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }
}
