import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../Cores/Widgets/header3.dart';
import '../../../Cores/Widgets/screens_header.dart';
import '../Entities/clients.dart';
import '../Models/transaction_object.dart';
import '../Models/user_details_object.dart';
import '../Widgets/transaction_details_widgets.dart';

class TransactionsDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TransactionOverviewModel transaction =
        (ModalRoute.of(context).settings.arguments as List<Object>)[0];
    ClientDetailsModel user =
        (ModalRoute.of(context).settings.arguments as List<Object>)[1];
    return Scaffold(
      body: ListView(
        children: <Widget>[
          GlobalScreensHeader(
            backLabel: 'لیست تراکنش ها',
            eName: 'DETAILS',
            pName: 'جزئیات تراکنش',
            icon: FontAwesomeIcons.exchangeAlt,
          ),
          FutureBuilder(
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
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    TransactionRow(transaction: transaction),
                    TwoTopButtons(
                      transaction: transaction,
                      user: user,
                    ),
                    RowReport(
                      label: 'نحوه ی پرداخت',
                      details: snapshot.data.paymentType.toString(),
                      icon: Icons.attach_money,
                      fontSize: 5,
                    ),
                    RowReport(
                      label: 'توضیحات تراکنش',
                      details: snapshot.data.details,
                      icon: Icons.format_quote,
                      fontSize: 4,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Divider(height: 5),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: SimpleHeader3(
                        persian: 'آیتم های پرداخت',
                        english: 'Payment Items',
                        icon: Icons.format_align_left,
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (ctx, index) => PaymentItemRow(
                        itemCount: snapshot.data.paymentItems[index]['quantity']
                            .toString(),
                        label: snapshot.data.paymentItems[index]['name']
                            .toString(),
                        itemPrice: snapshot.data.paymentItems[index]['price']
                            .toString(),
                        index: (index + 1).toString(),
                        description: snapshot
                            .data.paymentItems[index]['description']
                            .toString(),
                      ),
                      itemCount: snapshot.data.paymentItems.length,
                    ),

                    // PaymentItemRow(
                    //   itemCount: '1',
                    //   label: 'ویزیت دکتر',
                    //   itemPrice: '30000',
                    //   index: '2',
                    //   description: '',
                    // ),
                    SizedBox(height: 50),
                  ],
                );
              }
            },
            future: ClientsEntity().getTransactionDetails(transaction.id),
          )
        ],
      ),
    );
  }
}
