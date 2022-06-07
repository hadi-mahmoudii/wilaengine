// import 'package:flutter/material.dart';
// import 'package:jalali_calendar/jalali_calendar.dart';

// import '../Config/app_session.dart';
// import '../Models/date-convertor.dart';

// class DatePicker extends StatefulWidget {
//   final Color color;
//   final IconData icon;
//   final String label;
//   final Function function;
//   final TextEditingController controller;
//   final TextEditingController dependency;
//   final bool enable;
//   final Function validator;

//   const DatePicker({
//     Key key,
//     @required this.color,
//     @required this.icon,
//     @required this.label,
//     @required this.controller,
//     this.dependency,
//     this.function,
//     this.enable = true,
//     this.validator,
//   }) : super(key: key);

//   @override
//   _DatePickerState createState() => _DatePickerState();
// }

// class _DatePickerState extends State<DatePicker> {
//   final TextEditingController controller = TextEditingController();
//   bool isTapped = false;
//   Function validator;
//   @override
//   void initState() {
//     //this use for set default validator
//     if (widget.validator != null)
//       validator = widget.validator;
//     else
//       validator = (value) {
        
//         return null;
//       };
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // String minDate = '';
//     // try {
//     //   minDate = widget.dependency.text.split(' ')[0];
//     // } catch (e) {}
//     // print(minDate);
//     return Container(
//       // margin: EdgeInsets.symmetric(vertical: 10),
//       color: Colors.transparent,
//       child: Directionality(
//         textDirection: TextDirection.rtl,
//         child: FocusScope(
//           onFocusChange: (val) {
//             setState(() {
//               isTapped = val;
//             });
//           },
//           child: TextFormField(
//             controller: controller,
//             enabled: widget.enable,
//             readOnly: true,
//             onTap: () async {
//               // showDialog(
//               //     context: context,
//               //     builder: (BuildContext _) {
//               //       return PersianDateTimePicker(
//               //         // initial: '1399/1/1',
//               //         type: 'datetime',
//               //         onSelect: (date) {
//               //           // print(date);
//               //           widget.controller.text = date.split(' ')[0].replaceAll('/', '-');
//               //           // DateConvertor.str2Datetime(date).toString();
//               //           controller.text =
//               //               DateConvertor(widget.controller.text).convert();
//               //         },
//               //         // min: minDate,
//               //       );
//               //     });
//               var res = await jalaliCalendarPicker(
//                   context: context,
//                   convertToGregorian: true,
//                   showTimePicker: false,
//                   hore24Format: true,
//                   toArray: true);

//               if (res != null) {
//                 print(res);
//                 widget.controller.text = res.toString();
//                 controller.text = DateConvertor(res.toString()).dateConvert2();
//                 // setState(
//                 //   () {},
//                 // );
//               }
//             },
//             validator: validator,
//             decoration: InputDecoration(
//               // contentPadding: EdgeInsets.symmetric(horizontal: 5),
//               isDense: false,
//               labelText: widget.label,
//               labelStyle: TextStyle(
//                 fontSize: 3 * AppSession.deviceBlockSize,
//                 color: isTapped ? widget.color : widget.color.withOpacity(.5),
//               ),
//               prefixIcon: InkWell(
//                 onTap: widget.function ?? widget.function,
//                 child: Icon(
//                   widget.icon,
//                   color: isTapped ? widget.color : widget.color.withOpacity(.5),
//                 ),
//               ),
//             ),
//             cursorColor: widget.color,
//             style: TextStyle(
//               fontSize: 4 * AppSession.deviceBlockSize,
//               color: isTapped ? widget.color : widget.color.withOpacity(.5),
//             ),
//             textDirection: TextDirection.ltr,
//             textAlign: TextAlign.end,
//             minLines: 1,
//             maxLines: 3,
//           ),
//         ),
//       ),
//     );
//   }
// }
