import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:willaEngine/Features/CRM/controller/Client.dart';

import '../../../Cores/Config/app_session.dart';
import '../../../Cores/Config/routes.dart';
import '../../../Cores/Models/request_status.dart';
import '../../../Cores/Widgets/header3.dart';
import '../../../Cores/Widgets/image_widgets.dart';
import '../../../Cores/Widgets/loading_widget.dart';
import '../../../Cores/Widgets/screens_header.dart';
import '../controller/Task.dart';
import '../Widgets/task_details_widgets.dart';



// class ClientTaskDetailsScreen extends StatefulWidget {
//   const ClientTaskDetailsScreen({
//     Key key,
//   }) : super(key: key);

//   @override
//   _ClientTaskDetailsScreenState createState() => _ClientTaskDetailsScreenState();
// }

class ClientTaskDetailsScreen extends StatelessWidget {
  
 

  @override
  Widget build(BuildContext context) {
    TaskController taskController = Get.put(
      TaskController(taskOverview: Get.arguments[0], user: Get.arguments[1] , context: context));
    return GetX<TaskController>(
      builder: (controller) => SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            child: GlobalScreensHeader(
              backLabel: 'لیست خدمات',
              eName: 'DETAILS',
              pName: 'جزئیات خدمت',
              icon: Icons.format_align_left,
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
                      TaskRow(
                        task: controller.task.value,
                        user: controller.user,
                        statuses: controller.statuses,
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(),
                      ),
                      FourTopButtons(
                        task: controller.task.value,
                        user: controller.user,
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(),
                      ),
                      RowReport(
                        label: 'مسئول انجام',
                        details: controller.task.value.user,
                        // details: 'دکتر علی موسوی',
                        icon: Icons.person,
                        fontSize: 4,
                      ),
                      RowReport(
                        label: 'زمان انجام',
                        details: controller.task.value.eDate,
                        icon: Icons.watch_later,
                        fontSize: 4,
                      ),
                      RowReport(
                        label: 'توضیحات خدمت',
                        details: controller.task.value.details,
                        // 'این تراکنش برای انجام کار لیزر به صورت نصف نقد و نصف کارت به کارت انجام شد',
                        icon: Icons.format_quote,
                        fontSize: 4,
                      ),
                      SizedBox(height: 30),
                      SimpleHeader3(
                        persian: 'فایل ها',
                        english: 'FILES',
                        icon: Icons.cloud,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Divider(),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        padding: EdgeInsets.only(top: 20),
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (ctx, ind) =>
                              controller.images[ind].type == 'add'
                                  ? FileAddButton(
                                      controller: controller,
                                      galeryFunction: () async => await controller
                                          .addImages(context, [], true),
                                      cameraFunction: () =>
                                      Get.toNamed(Routes.captureImageScreen , arguments:controller.addImages )
                                        
                                    )
                                  : Container(
                                      height: 100,
                                      child: ImageShowBox(
                                        media: controller.images[ind],
                                        deleteFunction: () {
                                          controller.removeImage(
                                              context, controller.images[ind]);
                                        },
                                      ),
                                    ),
                          itemCount: controller.images.length,
                        ),
                      ),
                      SizedBox(height: 75),
                    ],
                  ),
          ),
          floatingActionButton: Padding(
            padding: EdgeInsets.only(right: AppSession.deviceWidth - 150),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(width: 25),
                controller.newImages == 0
                    ? Container()
                    : FloatingActionButton(
                        onPressed: () async {},
                        child: SaveBTN(
                          controller: controller,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
