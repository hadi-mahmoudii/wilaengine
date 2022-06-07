import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:willaEngine/Features/Comment/Widgets/add_comment_button.dart';
import 'package:willaEngine/Features/Comment/Widgets/self_comment_box.dart';
import 'package:willaEngine/Features/Comment/Widgets/unself_comment_box.dart';
import 'package:willaEngine/Features/Comment/controllers/comment.dart';

import '../../../Cores/Config/app_session.dart';
import '../../../Cores/Models/request_status.dart';
import '../../../Cores/Widgets/empty.dart';
import '../../../Cores/Widgets/loading_widget.dart';

import '../Widgets/comments_widgets.dart';

// class CommentsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final List<Object> datas = ModalRoute.of(context).settings.arguments;
//     return ChangeNotifierProvider<CommentProvider>(
//       create: (_) => CommentProvider(object: datas[0], objectType: datas[1]),
//       child: ClientTasksTile(),
//     );
//   }
// }

// class ClientTasksTile extends StatefulWidget {
//   @override
//   _ClientTasksTileState createState() => _ClientTasksTileState();
// }

class CommentsScreen extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    CommentController commentController = Get.put(CommentController(
        object: Get.arguments[0],
        objectType: Get.arguments[1],
        context: context));

    return GetX<CommentController>(
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
              child: CommentHeader(
                backLabel: 'بازگشت',
                eName: 'COMMENTS',
                pName: 'کامنت ها',
                commentCount: controller.object.commentCount,
              ),
              preferredSize: Size(double.infinity, 100),
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
                          ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (ctx, index) =>
                                    AppSession.userId ==
                                            controller.datas[index].userId
                                        ? SelfCommentBox(
                                            comment: controller.datas[index],
                                            // replyWidget: BlogReplyAddCommentButton(
                                            //   replyId: provider.comments[ind].id,
                                            // ),
                                          )
                                        : UnSelfCommentBox(
                                            comment: controller.datas[index],
                                            // replyTapWidget: BlogReplyAddCommentButton(
                                            //   replyId: provider.comments[ind].id,
                                            // ),
                                          ),
                                itemCount: controller.datas.length,
                              ),
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
              child: AddCommentBotton(controller),
            ),
          ),
        ),
      ),
    );
  }
}
