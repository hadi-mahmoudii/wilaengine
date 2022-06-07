import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../Cores/Config/app_session.dart';
import '../../../Cores/Config/routes.dart';
import '../../../Cores/Widgets/closable_header.dart';
import '../../../Cores/Widgets/global-appbar.dart';
import '../../../Cores/Widgets/header2.dart';
import '../Entities/Comments.dart';

class CommentHeader extends StatelessWidget {
  final String backLabel;
  final String eName;
  final String pName;
  final String commentCount;

  const CommentHeader({
    Key key,
    @required this.backLabel,
    @required this.eName,
    @required this.pName,
    @required this.commentCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      // margin: EdgeInsets.only(bottom: 10),
      // width: 100,
      // height: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFc5c5c5), Color(0xFFe3e3e3)],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.0, 1.0),
          stops: [0.0, 1.0],
          // tileMode: TileMode.repeated,
        ),
        border: Border(
          bottom: BorderSide(color: Colors.black, width: 2),
        ),
      ),
      child: Column(
        children: <Widget>[
          backLabel != '' ? SimpleAppbar(backLabel) : SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: eName == ''
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  commentCount,
                  style: TextStyle(
                    fontFamily: 'montserrat',
                    fontSize: 5 * AppSession.deviceBlockSize,
                  ),
                ),
                Spacer(),
                SimpleHeader2(pName, eName),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CommentBox extends StatelessWidget {
  final String writer;
  final String date;
  final String comment;
  final bool isMyComment;
  final bool isReply;
  final String parrentWriter;
  final String parrentDate;
  final String parrentComment;

  const CommentBox({
    Key key,
    @required this.writer,
    @required this.date,
    @required this.comment,
    @required this.isMyComment,
    @required this.isReply,
    @required this.parrentWriter,
    @required this.parrentDate,
    @required this.parrentComment,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMyComment ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            topLeft: Radius.circular(isMyComment ? 25 : 0),
            bottomLeft: Radius.circular(25),
            topRight: Radius.circular(isMyComment ? 0 : 25),
          ),
          border:
              Border.all(color: isMyComment ? Color(0xFF32CAD5) : Colors.black),
        ),
        width: 75 * AppSession.deviceBlockSize,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            isReply
                ? Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(25),
                        topLeft: Radius.circular(isMyComment ? 0 : 25),
                        bottomLeft: Radius.circular(25),
                        topRight: Radius.circular(isMyComment ? 25 : 0),
                      ),
                      border: Border.all(
                          color:
                              isMyComment ? Color(0xFF32CAD5) : Colors.black),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              width: 50 * AppSession.deviceBlockSize,
                              child: Text(
                                parrentWriter,
                                overflow: TextOverflow.clip,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    fontSize: 7 * AppSession.deviceBlockSize),
                              ),
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: <Widget>[
                                Text(
                                  parrentDate,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                    color: Color(0xFF707070),
                                    fontSize: 3 * AppSession.deviceBlockSize,
                                  ),
                                  textDirection: TextDirection.rtl,
                                ),
                                Icon(
                                  Icons.watch_later,
                                  color: Color(0xFF707070),
                                  size: 4 * AppSession.deviceBlockSize,
                                ),
                              ],
                            ),
                            Container(
                              width: 50 * AppSession.deviceBlockSize,
                              child: Text(
                                parrentComment,
                                textDirection: TextDirection.rtl,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 5),
                        Icon(
                          FontAwesomeIcons.reply,
                          color: Color(0xFF707070),
                          size: 8 * AppSession.deviceBlockSize,
                        ),
                      ],
                    ),
                  )
                : Container(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.solidHeart,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(FontAwesomeIcons.reply),
                Spacer(),
                // SizedBox(width: 10 * AppSession.deviceBlockSize),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    isMyComment
                        ? Container()
                        : Text(
                            writer,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontSize: 7 * AppSession.deviceBlockSize,
                            ),
                          ),
                    SizedBox(height: 5),
                    Row(
                      children: <Widget>[
                        Text(
                          date,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            color: Color(0xFF707070),
                            fontSize: 3 * AppSession.deviceBlockSize,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        Icon(
                          Icons.watch_later,
                          color: Color(0xFF707070),
                          size: 4 * AppSession.deviceBlockSize,
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: 10),
            Container(
              width: 70 * AppSession.deviceBlockSize,
              child: Text(
                comment,
                textDirection: TextDirection.rtl,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommentAddBox extends StatefulWidget {
  final BuildContext ctx;
  final dynamic object;
  final String type;
  const CommentAddBox({
    Key key,
    @required this.ctx,
    @required this.object,
    @required this.type,
  }) : super(key: key);

  @override
  _CommentAddBoxState createState() => _CommentAddBoxState();
}

class _CommentAddBoxState extends State<CommentAddBox> {
  final TextEditingController comment = new TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ClosableHeader(
            persian: 'ثبت کامنت جدید',
            english: 'NEW COMMENT',
            ctx: widget.ctx,
          ),
          Divider(),
          Directionality(
            textDirection: TextDirection.rtl,
            child: TextFormField(
              controller: comment,
              decoration: InputDecoration(
                suffix: Icon(Icons.format_quote),
                labelText: 'متن کامنت',
                labelStyle: TextStyle(
                  fontSize: 3.5 * AppSession.deviceBlockSize,
                ),
                isDense: true,
              ),
              minLines: 1,
              maxLines: 5,
              style: TextStyle(
                fontSize: AppSession.deviceBlockSize * 5,
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              if (!isLoading) {
                setState(() {
                  isLoading = true;
                });
                await CommentsEntitey()
                    .sendComment(widget.object.id, comment.text, widget.type);
                Navigator.of(widget.ctx).pop();
                Navigator.of(context).popAndPushNamed(
                  Routes.commentsScreen,
                  arguments: [widget.object, widget.type],
                );
              } else {}
            },
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(5),
              ),
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Text(
                      'ثبت کامنت',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
            ),
          )
        ],
      ),
    );
  }
}
