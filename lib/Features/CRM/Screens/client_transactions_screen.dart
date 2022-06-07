import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Cores/Config/app_session.dart';
import '../../../Cores/Models/request_status.dart';
import '../../../Cores/Widgets/empty.dart';
import '../../../Cores/Widgets/loading_widget.dart';
import '../../../Cores/Widgets/screens_header.dart';
import '../controller/Transactions.dart';
import '../Widgets/transaction_list_widgets.dart';

// class ClientTransactionsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<TransactionsProvider>(
//       create: (_) =>
//           TransactionsProvider(user: ModalRoute.of(context).settings.arguments),
//       child: TransactionsTile(),
//     );
//   }
// }

// class ClientTransactionsScreen extends StatefulWidget {
//   @override
//   _ClientTransactionsScreenState createState() =>
//       _ClientTransactionsScreenState();
// }

class ClientTransactionsScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    TransactionsController transactionsController =
      Get.put(TransactionsController(user: Get.arguments , context: context));

    return GetX<TransactionsController>(
      builder: (controller) => NotificationListener(
        onNotification: (ScrollNotification notification) {
          if (notification is ScrollUpdateNotification) {
            if (controller.scrollController.position.pixels >
                    controller.scrollController.position.maxScrollExtent - 50 &&
                controller.loadMoreStatus != RequestStatus.loading) {
              controller.fetchDatas(context);
            }
          }
          return true;
        },
        child: SafeArea(
          child: Scaffold(
            appBar: PreferredSize(
              child: GlobalScreensHeader(
                backLabel: controller.user.name,
                eName: 'Services',
                pName: 'خدمات تعریف شده',
                icon: Icons.format_align_left,
              ),
              preferredSize: Size(
                double.infinity,
                AppSession.deviceHeigth * 0.155,
              ),
            ),
            body: RefreshIndicator(
              onRefresh: () => controller.fetchDatas(
                context,
                resetPage: true,
              ),
              child: ListView(
                controller: controller.scrollController,
                physics: controller.loadMoreStatus == RequestStatus.loading
                    ? NeverScrollableScrollPhysics()
                    : AlwaysScrollableScrollPhysics(),
                children: [
                  controller.requestStatus == RequestStatus.loading
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 100),
                            child: LoadingWidget(
                              mainFontColor: AppSession.mainFontColor,
                            ),
                          ),
                        )
                      : controller.datas.length != 0
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (ctx, index) => TransactionRow(
                                transaction: controller.datas[index],
                                user: controller.user,
                              ),
                              itemCount: controller.datas.length,
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 100),
                              child: EmptyWidget(),
                            ),
                  SizedBox(
                    height: 25,
                  ),
                  controller.loadMoreStatus == RequestStatus.loading
                      ? LoadingWidget(mainFontColor: AppSession.mainFontColor)
                      : SizedBox(height: 50),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
