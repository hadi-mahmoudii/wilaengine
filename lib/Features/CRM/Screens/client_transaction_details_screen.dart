import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:willaEngine/Cores/Widgets/header3.dart';
import 'package:willaEngine/Features/CRM/Widgets/transaction_details_widgets.dart';

import '../../../Cores/Config/app_session.dart';
import '../../../Cores/Models/request_status.dart';
import '../../../Cores/Widgets/loading_widget.dart';
import '../../../Cores/Widgets/screens_header.dart';
import '../controller/Transaction.dart';

// class ClientTransactionDetailsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final List<Object> datas = ModalRoute.of(context).settings.arguments;
//     return ChangeNotifierProvider<TransactionProvider>(
//       create: (_) => TransactionProvider(
//         transactionOverview: datas[0],
//         user: datas[1],
//       ),
//       child: ClientTransactionDetailsTile(),
//     );
//   }
// }

// class ClientTransactionDetailsScreen extends StatefulWidget {
//   const ClientTransactionDetailsScreen({
//     Key key,
//   }) : super(key: key);

//   @override
//   _ClientTransactionDetailsScreenState createState() =>
//       _ClientTransactionDetailsScreenState();
// }

class ClientTransactionDetailsScreen extends StatelessWidget{
  


  @override
  Widget build(BuildContext context) {
    TransactionController transactionController = Get.put(TransactionController(
      transactionOverview: Get.arguments[0], user: Get.arguments[1] , context:  context));

    return GetX<TransactionController>(
      builder: (controller) => SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            child: GlobalScreensHeader(
              backLabel: 'لیست تراکنش ها',
              eName: 'DETAILS',
              pName: 'جزئیات تراکنش',
              icon: FontAwesomeIcons.exchangeAlt,
            ),
            preferredSize: Size(
              double.infinity,
              AppSession.deviceHeigth * 0.155,
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () => controller.fetchDatas(context),
            child: controller.requestStatus == RequestStatus.loading
                ? Center(
                    child:
                        LoadingWidget(mainFontColor: AppSession.mainFontColor),
                  )
                : ListView(
                    children: <Widget>[
                      TransactionRow(transaction: controller.transactionOverview),
                      TwoTopButtons(
                        transaction: controller.transactionOverview,
                        user: controller.user,
                      ),
                      RowReport(
                        label: 'نحوه ی پرداخت',
                        details: controller.transaction.value.paymentType.toString(),
                        icon: Icons.attach_money,
                        fontSize: 5,
                      ),
                      RowReport(
                        label: 'توضیحات تراکنش',
                        details: controller.transaction.value.details,
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
                          itemCount: controller
                              .transaction.value.paymentItems[index]['quantity']
                              .toString(),
                          label: controller
                              .transaction.value.paymentItems[index]['name']
                              .toString(),
                          itemPrice: controller
                              .transaction.value.paymentItems[index]['price']
                              .toString(),
                          index: (index + 1).toString(),
                          description: controller
                              .transaction.value.paymentItems[index]['description']
                              .toString(),
                        ),
                        itemCount: controller.transaction.value.paymentItems.length,
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
