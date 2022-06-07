// import 'package:flutter/material.dart';
// import 'package:jalali_calendar/jalali_calendar.dart';

// import '../Entities/global.dart';
// import 'txt_field.dart';

// class DatePick extends StatefulWidget {
//   const DatePick({
//     Key key,
//     @required this.dateCTRL,
//     @required this.label,
//     @required this.icon,
//     @required this.showTime,
//     this.marginRight = 25,
//     this.marginLeft = 25,
//   }) : super(key: key);

//   final TextEditingController dateCTRL;
//   final String label;
//   final IconData icon;
//   final bool showTime;
//   final double marginLeft;
//   final double marginRight;
//   @override
//   _DatePickState createState() => _DatePickState();
// }

// class _DatePickState extends State<DatePick> {
//   final TextEditingController dateTextCTRL = new TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // margin: EdgeInsets.symmetric(horizontal: 25),
//       // height: 100,
//       child: Directionality(
//         textDirection: TextDirection.rtl,
//         child: Stack(
//           // crossAxisAlignment: CrossAxisAlignment.start,
//           // mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             TXTFeild(
//               label: widget.label,
//               textCtrl: dateTextCTRL,
//               icon: Icons.expand_more,
//               validate: (value) {},
//               readOnly: true,
//               marginRight: widget.marginRight,
//               marginLeft: widget.marginLeft,
//               // currentFocosNode: _nameFocusNode,
//               // nextFocosNode: _familyFocusNode,
//               // inputAction: TextInputAction.next,
//             ),
//             InkWell(
//               onTap: () async {
//                 var res = await jalaliCalendarPicker(
//                   context: context,
//                   convertToGregorian: true,
//                   showTimePicker: widget.showTime,
//                   hore24Format: true,
//                 );

//                 if (res != null) {
//                   print(res.toString());
//                   // dateTimeFrom = res;
//                   setState(
//                     () {
//                       // widget.dateCTRL.text = inn.DateFormat('y-M-d').format(res);
//                       widget.dateCTRL.text = res.toString();
//                       dateTextCTRL.text =
//                           GlobalEntity().dateConvert(res.toString());
//                       // dateValue = DateFormat('y-M-d').format(
//                       // dateTimeFrom,
//                       // ); // baraye tavize makane gharar giri baraye api
//                     },
//                   );
//                 }
//               },
//               child: Container(
//                 height: 60,
//                 width: double.infinity,
//                 // color: Colors.red,
//               ),
//               // Directionality(
//               //   textDirection: TextDirection.rtl,
//               //   child: TextFormField(
//               //     enabled: false,
//               //     // readOnly: true,
//               //     controller: dateTextCTRL,
//               //     style: TextStyle(
//               //       fontSize: 5 * AppSession.deviceBlockSize,
//               //     ),
//               //     decoration: InputDecoration(
//               //       suffixIcon: Icon(widget.icon),
//               //       labelStyle: TextStyle(
//               //         fontFamily: 'iranyekan',
//               //         fontSize: 4 * AppSession.deviceBlockSize,
//               //       ),
//               //       labelText: widget.label,
//               //       isDense: true,
//               //       contentPadding: EdgeInsets.only(bottom: 0),
//               //       // border: InputBorder.none,
//               //     ),
//               //     minLines: 1,
//               //     maxLines: 3,
//               //   ),
//               // ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // final bool showTitleActions = false;
// //         PersianDate persianDate =
// //             PersianDate(format: "yyyy/mm/dd  \n DD  , d  MM  ");
// //         String _datetime = '';
// //         String _format = 'yyyy-mm-dd';
// //         String _value = '';
// //         String _valuePiker = '';
// //         DatePicker.showDatePicker(
// //           context,
// //           minYear: 1399,
// //           maxYear: 1400,
// // /*      initialYear: 1368,
// //       initialMonth: 05,
// //       initialDay: 30,*/
// //           confirm: Text(
// //             'تایید',
// //             style: TextStyle(color: Colors.red),
// //           ),
// //           cancel: Text(
// //             'لغو',
// //             style: TextStyle(color: Colors.cyan),
// //           ),
// //           dateFormat: _format,
// //           // onChanged: (year, month, day) {
// //           // if (!showTitleActions) {
// //           //   _changeDatetime(year, month, day);
// //           // }
// //           // },
// //           onConfirm: (year, month, day) {
// //             print(year.toString());
// //             // dateTimeFrom = res;
// //             setState(
// //               () {
// //                 // widget.dateCTRL.text = inn.DateFormat('y-M-d').format(res);
// //                 widget.dateCTRL.text = year.toString();
// //                 // dateTextCTRL.text = GlobalEntity().dateConvert(year.toString());
// //                 // dateValue = DateFormat('y-M-d').format(
// //                 // dateTimeFrom,
// //                 // ); // baraye tavize makane gharar giri baraye api
// //               },
// //             );
// //           },
// //         );
