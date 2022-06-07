import 'package:flutter/material.dart';

class NewComment extends StatelessWidget {
  final TextEditingController _messageController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context);
    final double _pixelRatio =
        (_media.size.height / _media.size.width * 7 / 5).roundToDouble();
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          NewCommentHeader(),
          SizedBox(height: 8.5 * _pixelRatio),
          // Column(
          //   children: <Widget>[
          //     Row(
          //       children: <Widget>[
          //         Container(
          //           width: MediaQuery.of(context).size.width * 5 / 8,
          //           child: Directionality(
          //             textDirection: TextDirection.rtl,
          //             child: TextField(
          //               decoration: InputDecoration(
          //                 contentPadding: EdgeInsets.all(1),
          //                 hintText: 'متن کامنت',
          //                 border: InputBorder.none,
          //                 hintStyle: TextStyle(
          //                   fontSize: 6.5 * _pixelRatio,
          //                 ),
          //               ),
          //               style: TextStyle(
          //                 fontSize: 6.5 * _pixelRatio,
          //               ),
          //               minLines: 5,
          //               maxLines: 5,
          //               controller: _messageController,
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: EdgeInsets.only(left: 2, bottom: 25 * _pixelRatio),
          //           child: SvgPicture.asset(
          //             'assets/Icons/comment.svg',
          //             width: 10 * _pixelRatio,
          //             height: 10 * _pixelRatio,
          //           ),
          //         ),
          //       ],
          //     ),
          //     Divider(
          //       color: Colors.black54,
          //       height: 2,
          //     ),
          //   ],
          // ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.comment),
                contentPadding: EdgeInsets.all(1),
                // hintText: 'متن کامنت',
                labelText:  'متن کامنت',
                // border: InputBorder.none,
                hintStyle: TextStyle(
                  fontSize: 6.5 * _pixelRatio,
                ),
                isDense: true,
                // alignLabelWithHint: false,
              ),
              style: TextStyle(
                fontSize: 6.5 * _pixelRatio,
              ),
              minLines: 1,
              maxLines: 5,
              controller: _messageController,
            ),
          ),
          SizedBox(
            height: 5 * _pixelRatio,
          ),
          Container(
            width: 50 * _pixelRatio,
            height: 12.5 * _pixelRatio,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.black,
              ),
            ),
            child: Row(
              children: <Widget>[
                Spacer(),
                Text(
                  'ثبت کامنت',
                  style: TextStyle(
                    fontSize: 5.5,
                  ),
                  textScaleFactor: _pixelRatio,
                ),
                Icon(
                  Icons.add,
                  size: 7 * _pixelRatio,
                ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NewCommentHeader extends StatelessWidget {
  const NewCommentHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.add,
              size: 30,
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  'ثبــــت کامـــــــــنت',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                Text(
                  'NEW COMMENT',
                  style: TextStyle(
                    fontFamily: 'montserrat',
                    letterSpacing: 3,
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
