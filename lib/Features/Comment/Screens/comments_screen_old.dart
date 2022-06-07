// import 'package:flutter/material.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

// import '../../../Cores/Config/app_session.dart';
// import '../../../Cores/Config/routes.dart';
// import '../Entities/comments.dart';
// import '../Models/comment_object.dart';
// import '../Widgets/comments_widgets.dart';

// class CommentsScreen extends StatefulWidget {
//   @override
//   _CommentsScreenState createState() => _CommentsScreenState();
// }

// class _CommentsScreenState extends State<CommentsScreen> {
//   bool isInit = true;
//   int _currentPage = 1;
//   RefreshController _refreshController =
//       RefreshController(initialRefresh: true);
//   List<CommentModel> comments = [];
//   void _onRefresh() async {
//     dynamic object =
//         (ModalRoute.of(context).settings.arguments as List<dynamic>)[0];
//     dynamic type =
//         (ModalRoute.of(context).settings.arguments as List<dynamic>)[1];
//     setState(() {
//       isInit = true;
//     });
//     _currentPage = 1;
//     List<CommentModel> tempList = await CommentsEntitey()
//         .getComments(object.id, type, _currentPage.toString());
//     if (tempList.length > 0) {
//       print(tempList.length.toString());
//       setState(() {
//         comments = tempList;
//       });
//       _currentPage += 1;
//     } else {}
//     setState(() {
//       isInit = false;
//     });
//     _refreshController.refreshCompleted();
//   }

//   void _onLoadMore() async {
//     dynamic object =
//         (ModalRoute.of(context).settings.arguments as List<dynamic>)[0];
//     dynamic type =
//         (ModalRoute.of(context).settings.arguments as List<dynamic>)[1];
//     List<CommentModel> tempList = await CommentsEntitey()
//         .getComments(object.id, type, _currentPage.toString());
//     if (tempList.length > 0) {
//       print(tempList.length.toString());
//       setState(() {
//         comments += tempList;
//       });
//       _currentPage += 1;
//     } else {}
//     _refreshController.loadComplete();
//   }

//   @override
//   Widget build(BuildContext context) {
//     dynamic object =
//         (ModalRoute.of(context).settings.arguments as List<dynamic>)[0];
//     dynamic type =
//         (ModalRoute.of(context).settings.arguments as List<dynamic>)[1];
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.of(context).pop();
//         if (type == 'user') {
//           Navigator.of(context).popAndPushNamed(
//             Routes.clientDetailsScreen,
//             arguments: object.id,
//           );
//         }
//         return true;
//       },
//       child: Scaffold(
//         floatingActionButton: Container(
//           margin: EdgeInsets.only(left: AppSession.deviceWidth * .1),
//           child: Align(
//             alignment: Alignment.bottomLeft,
//             child: InkWell(
//               onTap: () => showDialog(
//                 context: context,
//                 builder: (ctx) => AlertDialog(
//                   content: CommentAddBox(
//                     ctx: ctx,
//                     object: object,
//                     type: type,
//                   ),
//                 ),
//               ),
//               child: CircleAvatar(
//                 radius: 8 * AppSession.deviceBlockSize,
//                 backgroundColor: Colors.black,
//                 child: Icon(
//                   Icons.add,
//                   color: Colors.white,
//                   size: 15 * AppSession.deviceBlockSize,
//                 ),
//               ),
//             ),
//           ),
//         ),
//         body: SmartRefresher(
//           controller: _refreshController,
//           onRefresh: _onRefresh,
//           onLoading: _onLoadMore,
//           enablePullDown: true,
//           enablePullUp: true,
//           child: ListView(
//             children: <Widget>[
//               SizedBox(
//                 height: 20,
//               ),
//               CommentHeader(
//                 backLabel: 'بازگشت',
//                 eName: 'COMMENTS',
//                 pName: 'کامنت ها',
//                 commentCount: object.commentCount,
//               ),
//               isInit
//                   ? Container()
//                   : ListView.builder(
//                       shrinkWrap: true,
//                       physics: NeverScrollableScrollPhysics(),
//                       itemBuilder: (ctx, index) => CommentBox(
//                         writer: comments[index].user,
//                         date: comments[index].date,
//                         comment: comments[index].message,
//                         isMyComment: comments[index].owner,
//                         isReply: false,
//                         parrentWriter: 'null',
//                         parrentDate: 'null',
//                         parrentComment: 'null',
//                       ),
//                       itemCount: comments.length,
//                     ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
