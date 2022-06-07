import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:willaEngine/Cores/Models/request_status.dart';
import 'package:willaEngine/Cores/Widgets/input_box.dart';
import 'package:willaEngine/Features/Comment/controllers/comment.dart';

import '../../../Cores/Config/app_session.dart';
import '../../../Cores/Widgets/loading_widget.dart';

class AddCommentBotton extends StatelessWidget {
  final controller;
  AddCommentBotton(this.controller);
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (ctx2) => CommentAddBox(
            ctx: ctx2,
            controller: controller,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              spreadRadius: 1,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        alignment: Alignment.bottomLeft,
        child: CircleAvatar(
          radius: 8 * AppSession.deviceBlockSize,
          backgroundColor: Colors.black,
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 15 * AppSession.deviceBlockSize,
          ),
        ),
      ),
    );
    //         FlatButton.icon(
    //   onPressed: () {
    //     showModalBottomSheet(
    //       context: context,
    //       isScrollControlled: true,
    //       builder: (ctx2) => CommentAddBox(
    //         ctx: ctx2,
    //         provider: provider,
    //       ),
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.vertical(
    //           top: Radius.circular(20),
    //         ),
    //       ),
    //       clipBehavior: Clip.antiAliasWithSaveLayer,
    //     );
    //   },
    //   icon: Container(
    //     padding: EdgeInsets.all(5),
    //     decoration: BoxDecoration(
    //       color: Color(0xFF102A45),
    //       borderRadius: BorderRadius.circular(5),
    //     ),
    //     child: Icon(
    //       Icons.add,
    //       color: Colors.white,
    //       size: AppSession.deviceBlockSize * 7,
    //     ),
    //   ),
    //   label: Text(''),
    // ),
  }
}

class BlogReplyAddCommentButton extends StatelessWidget {
  final String replyId;

  const BlogReplyAddCommentButton({Key key, @required this.replyId})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetX<CommentController>(
      builder: (controller) => InkWell(
        onTap: () {
          // provider.changeReplyId(replyId);
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (ctx2) => CommentAddBox(
              ctx: ctx2,
              controller: controller,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
          );
        },
        child: Icon(
          FontAwesomeIcons.reply,
          color: AppSession.mainFontColor,
          size: 6 * AppSession.deviceBlockSize,
        ),
      ),
    );
  }
}

class CommentAddBox extends StatefulWidget {
  final BuildContext ctx;
  final CommentController controller;
  const CommentAddBox({
    Key key,
    @required this.ctx,
    @required this.controller,
  }) : super(key: key);

  @override
  _CommentAddBoxState createState() => _CommentAddBoxState();
}

class _CommentAddBoxState extends State<CommentAddBox> {
  // final TextEditingController comment = new TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          InputBox(
            color: AppSession.mainFontColor,
            icon: FontAwesomeIcons.quoteLeft,
            label: 'نظر خود را وارد کنید',
            controller: widget.controller.commentCtrl,
          ),
          InkWell(
            onTap: () async => widget.controller.sendDatas(context),
            child: Container(
              width: AppSession.deviceWidth / 3,
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: widget.controller.addCommentStatus == RequestStatus.loading
                  ? Center(
                      child: LoadingWidget(mainFontColor: Colors.white),
                    )
                  : Text(
                      'ثبت نظر',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).viewInsets.bottom,
          ),
        ],
      ),
    );
  }
}
