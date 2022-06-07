import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:willaEngine/Cores/Config/routes.dart';

import '../../../Cores/Config/app_session.dart';
import '../../../Cores/Models/request_status.dart';
import '../../../Cores/Widgets/empty.dart';
import '../../../Cores/Widgets/loading_widget.dart';
import '../../../Cores/Widgets/screens_header.dart';
import '../controller/Clients.dart';

import '../Widgets/task_list_widgets.dart';

// class ClientListScreen extends StatefulWidget {
//   @override
//   _ClientListScreenState createState() => _ClientListScreenState();
// }

class ClientListScreen extends StatelessWidget {
  


  @override
  Widget build(BuildContext context) {
    ClientsController clientsController = Get.put(ClientsController(context));
    // var sizes = MediaQuery.of(context).size;
    // Provider.of<AppSession>(context, listen: false).setSizes(sizes);
    return GetX<ClientsController>(
      builder: (controller) => NotificationListener(
        onNotification: (ScrollNotification notification) {
          if (notification is ScrollUpdateNotification) {
            if (controller.scrollController.position.pixels >
                    controller.scrollController.position.maxScrollExtent -
                        50 &&
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
                backLabel: 'صفحه ی اصلی',
                eName: 'MY CLIENT',
                pName: 'مشتریان من',
                icon: FontAwesomeIcons.filter,
              ),
              preferredSize: Size(
                double.infinity,
                AppSession.deviceHeigth * 0.155,
              ),
            ),
            body: RefreshIndicator(
              onRefresh: () => controller.fetchDatas(context,
                  resetPage: true, resetFilter: true),
              child: ListView(
                controller: controller.scrollController,
                children: [
                  SizedBox(height: 10),
                  SearchBox(
                    ctrl: controller.searchCtrl.value,
                    function: () {
                      controller.fetchDatas(context, resetPage: true);
                    },
                  ),
                  controller.requestStatus.value == RequestStatus.loading
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 100),
                            child: LoadingWidget(
                              mainFontColor: AppSession.mainFontColor,
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 0,
                            vertical: 20,
                          ),
                          child: controller.datas.length != 0
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (ctx, index) => UserRowNavigator(
                                    mainColor: index % 2 == 1
                                        ? Color(0xFFF1F1F1)
                                        : null,
                                    borderColor: index % 2 == 1
                                        ? Color(0xFFC1C1C1)
                                        : null,
                                    user: controller.datas[index],
                                  ),
                                  itemCount: controller.datas.length,
                                )
                              : EmptyWidget(),
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
                onPressed: () => Get.toNamed(Routes.addClientScreen),
                // decoration: BoxDecoration(),
                // margin: EdgeInsets.only(left: AppSession.deviceWidth * .1),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF32CAD5).withOpacity(.5),
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  alignment: Alignment.bottomLeft,
                  child: CircleAvatar(
                    radius: 8 * AppSession.deviceBlockSize,
                    backgroundColor: Color(0xFF32CAD5),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 12 * AppSession.deviceBlockSize,
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

class SearchBox extends StatelessWidget {
  final TextEditingController ctrl;
  final Function function;

  const SearchBox({
    Key key,
    @required this.ctrl,
    @required this.function,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          controller: ctrl,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            labelText: 'نام مشتری',
            labelStyle: TextStyle(
              fontSize: 3 * AppSession.deviceBlockSize,
              // fontFamily: AppSession.lanqIsPersian ? 'iranyekan' : 'montserrat',
            ),
            suffixIcon: InkWell(
              onTap: function,
              child: Icon(
                Icons.search,
                size: 6 * AppSession.deviceBlockSize,
              ),
            ),
            isDense: true,
          ),
          style: TextStyle(
            fontSize: 5 * AppSession.deviceBlockSize,
            color: AppSession.mainFontColor,
          ),
          keyboardType: TextInputType.text,
        ),
      ),
    );
  }
}
