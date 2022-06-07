import 'package:persian_date/persian_date.dart';
import 'package:shamsi_date/shamsi_date.dart';

class DateConvertor {
  final String date;

  DateConvertor(this.date);
  String convert() {
    PersianDate pdate = PersianDate(gregorian: date);
    String dateValue =
        '${pdate.hour}:${pdate.minute} - ${pdate.year} ${pdate.weekdayname} ${pdate.day}،${pdate.monthname}';
    // print(dateValue);

    return dateValue;
  }

  String dateConvert2() {
    // print(date);
    DateTime dat = DateTime.parse(date);
    // print(dat);
    DateTime curDat = dat.toLocal();
    PersianDate pdate = PersianDate(gregorian: curDat.toString());
    String dateValue =
        '${pdate.year} ${pdate.weekdayname} ، ${pdate.day} ${pdate.monthname}';
    return dateValue;
  }

  static DateTime str2Datetime(String date) {
    var datas = date.split('/');
    var jj = Jalali(
      int.parse(
        datas[0],
      ),
      int.parse(
        datas[1],
      ),
      int.parse(
        datas[2],
      ),
    );
    return jj.toDateTime();
  }
}
