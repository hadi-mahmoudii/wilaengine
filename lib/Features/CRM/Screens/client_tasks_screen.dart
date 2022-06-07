import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:willaEngine/Cores/Config/routes.dart';

import '../../../Cores/Config/app_session.dart';
import '../../../Cores/Models/request_status.dart';
import '../../../Cores/Widgets/empty.dart';
import '../../../Cores/Widgets/loading_widget.dart';
import '../../../Cores/Widgets/screens_header.dart';
import '../controller/Tasks.dart';
import '../Widgets/client_tasks_widgets.dart';

// class ClientTasksScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<TasksProvider>(
//       create: (_) =>
//           TasksProvider(user: ModalRoute.of(context).settings.arguments),
//       child: ClientTasksTile(),
//     );
//   }
// }

// class ClientTasksScreen extends StatefulWidget {
//   @override
//   _ClientTasksScreenState createState() => _ClientTasksScreenState();
// }

class ClientTasksScreen extends StatelessWidget {


  
  @override
  Widget build(BuildContext context) {
      TasksController tasksController =
      Get.put(TasksController(user: Get.arguments , context: context));

    return GetX<TasksController>(
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
                              itemBuilder: (ctx, index) => TaskRow(
                                task: controller.datas[index],
                                user: controller.user,
                                statuses: controller.statuses,
                                index: (index + 1).toString(),
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
            floatingActionButton: Padding(
              padding: EdgeInsets.only(right: AppSession.deviceWidth - 90),
              child: FloatingActionButton(
                onPressed: () => Get.toNamed(Routes.addTaskScreen, arguments: controller.user)
                    .then(
                      (value) => Navigator.of(context).popAndPushNamed(
                        Routes.clientTasksScreen,
                        arguments: controller.user,
                      ),
                    ),
                // decoration: BoxDecoration(),
                // margin: EdgeInsets.only(left: AppSession.deviceWidth * .1),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFAC3773).withOpacity(.5),
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  alignment: Alignment.bottomLeft,
                  child: CircleAvatar(
                    radius: 8 * AppSession.deviceBlockSize,
                    backgroundColor: Color(0xFFAC3773),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 15 * AppSession.deviceBlockSize,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
