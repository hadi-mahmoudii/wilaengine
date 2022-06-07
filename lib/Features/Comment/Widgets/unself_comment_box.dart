import 'package:flutter/material.dart';

import '../../../Cores/Config/app_session.dart';
import '../Models/comment_object.dart';

class UnSelfCommentBox extends StatefulWidget {
  final CommentModel comment;
  final Widget replyTapWidget;
  const UnSelfCommentBox({
    Key key,
    @required this.comment,
    this.replyTapWidget,
  }) : super(key: key);

  @override
  _UnSelfCommentBoxState createState() => _UnSelfCommentBoxState();
}

class _UnSelfCommentBoxState extends State<UnSelfCommentBox> {
  // bool isLiked;
  // bool isLiking = false;
  @override
  void initState() {
    // isLiked = widget.comment.isLiked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CircleAvatar(
          //   backgroundImage: NetworkImage(widget.comment.userImage),
          //   backgroundColor: AppSession.backgroundColor,
          //   radius: 5 * AppSession.deviceBlockSize,
          // ),
          Flexible(
            flex: 5,
            child: Column(
              children: [
                Card(
                  color: Color(0xFFF5F5F5),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // widget.comment.reply != null
                        //     ? Container(
                        //         padding: EdgeInsets.symmetric(
                        //           horizontal: 15,
                        //           vertical: 5,
                        //         ),
                        //         margin: EdgeInsets.only(bottom: 10),
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.only(
                        //             bottomLeft: Radius.circular(20),
                        //             bottomRight: Radius.circular(20),
                        //             topRight: Radius.circular(20),
                        //           ),
                        //           border: Border.all(
                        //             color: Colors.grey,
                        //           ),
                        //         ),
                        //         child: Column(
                        //           crossAxisAlignment: CrossAxisAlignment.end,
                        //           children: [
                        //             Text(
                        //               widget.comment.reply.userName,
                        //               textDirection: TextDirection.rtl,
                        //               style: TextStyle(
                        //                 fontSize:
                        //                     4 * AppSession.deviceBlockSize,
                        //                 color: AppSession.mainFontColor,
                        //                 fontWeight: FontWeight.w700,
                        //               ),
                        //               overflow: TextOverflow.ellipsis,
                        //             ),
                        //             SizedBox(height: 5),
                        //             Text(
                        //               widget.comment.reply.comment,
                        //               textDirection: TextDirection.rtl,
                        //               style: TextStyle(
                        //                 fontSize:
                        //                     3 * AppSession.deviceBlockSize,
                        //                 color: Color(0xFF707070),
                        //               ),
                        //               overflow: TextOverflow.ellipsis,
                        //             ),
                        //             SizedBox(height: 5),
                        //             Row(
                        //               mainAxisAlignment: MainAxisAlignment.end,
                        //               children: [
                        //                 // Text(
                        //                 //   time,
                        //                 //   textDirection: TextDirection.rtl,
                        //                 //   style: TextStyle(
                        //                 //     fontSize: 2.5 *
                        //                 //         AppSession.deviceBlockSize,
                        //                 //     color: Colors.grey,
                        //                 //   ),
                        //                 // ),
                        //                 // SizedBox(width: 10),
                        //                 Text(
                        //                   widget.comment.reply.date,
                        //                   textDirection: TextDirection.rtl,
                        //                   style: TextStyle(
                        //                     fontSize: 2.5 *
                        //                         AppSession.deviceBlockSize,
                        //                     color: Colors.grey,
                        //                   ),
                        //                 ),
                        //                 SizedBox(width: 5),
                        //                 Icon(
                        //                   Icons.watch_later,
                        //                   size: 3 * AppSession.deviceBlockSize,
                        //                 ),
                        //               ],
                        //             )
                        //           ],
                        //         ),
                        //       )
                        //     : Container(),
                        // SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // isLiking
                            //     ? LoadingWidget(
                            //         mainFontColor: AppSession.mainFontColor,
                            //       )
                            //     : GestureDetector(
                            //         onTap: () async {
                            //           setState(() {
                            //             isLiking = true;
                            //           });
                            //           await CommentEntity().likeComment(
                            //             widget.comment.id,
                            //             // widget.type,
                            //             !isLiked,
                            //           );
                            //           setState(() {
                            //             isLiking = false;
                            //             isLiked = !isLiked;
                            //           });
                            //         },
                            //         child: Icon(
                            //           isLiked
                            //               ? FontAwesome.heart
                            //               : FontAwesome.heart_o,
                            //           // color: Colors.red.withOpacity(.6),
                            //           size: 6 * AppSession.deviceBlockSize,
                            //         ),
                            //       ),
                            // SizedBox(width: 5),
                            widget.replyTapWidget != null
                                ? widget.replyTapWidget
                                : Container(),
                            // InkWell(
                            //   onTap: widget.replyTapFunction,
                            //   child: Icon(
                            //     FontAwesome.reply,
                            //     color: AppSession.mainFontColor,
                            //     size: 6 * AppSession.deviceBlockSize,
                            //   ),
                            // ),
                            Spacer(),
                            Text(
                              widget.comment.user,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontSize: 4 * AppSession.deviceBlockSize,
                                fontFamily: 'iranyekanlight',
                                color: AppSession.mainFontColor,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.comment.date,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontSize: 2 * AppSession.deviceBlockSize,
                                color: Color(0XFF707070),
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(
                              Icons.watch_later,
                              size: 2 * AppSession.deviceBlockSize,
                              color: Color(0XFF707070),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Text(
                          widget.comment.message,
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xFF707070),
                            fontSize: 3.5 * AppSession.deviceBlockSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
