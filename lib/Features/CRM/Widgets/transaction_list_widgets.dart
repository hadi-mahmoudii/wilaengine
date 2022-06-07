import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../Cores/Config/app_session.dart';
import '../../../Cores/Config/routes.dart';
import '../Models/transaction_object.dart';
import '../Models/user_details_object.dart';

class TransactionRow extends StatelessWidget {
  final TransactionOverviewModel transaction;
  final ClientDetailsModel user;
  const TransactionRow({
    Key key,
    @required this.transaction,
    @required this.user,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(
          Routes.transactionDetailsScreen,
          arguments: [transaction, user]),
      child: Container(
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.more_vert),
            // SizedBox(
            //   width: 10,
            // ),
            // Text(
            //   'آیــــــــتم\nخریداری\nشــــــــده',
            //   textAlign: TextAlign.right,
            //   style: TextStyle(
            //     color: Color(0xFF32CAD5),
            //   ),
            // ),
            // SizedBox(
            //   width: 10,
            // ),
            // Text(
            //   transaction.itemcount,
            //   style: TextStyle(
            //     fontSize: 10 * AppSession.deviceBlockSize,
            //     color: Color(0xFF32CAD5),
            //     fontFamily: 'montserrat',
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
                    // SizedBox(width: 3),
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
                SizedBox(height: 5),
              ],
            )
          ],
        ),
      ),
    );
  }
}
