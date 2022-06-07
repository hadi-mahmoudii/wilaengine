import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';



import 'package:dio/dio.dart' as di;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;
import 'package:persian_date/persian_date.dart';

import '../../Features/CRM/Models/client_task_object.dart';
import '../../Features/CRM/Models/user_details_object.dart';
import '../Config/app_session.dart';
import '../Config/urls.dart';
import '../Models/media.dart';
import '../Models/media_old.dart';

class GlobalEntity {
  Future<bool> addFiles(ClientDetailsModel user, String batchId) async {
    // final batchId = randomString(50);
    // for (var file in files) {
    //   await addImage(
    //     batchId,
    //     await file.length() > 3000000
    //         ? await compressImage(file)
    //         : file.readAsBytesSync(),
    //   );
    // }
    var dio = new di.Dio();
    dio.options.headers = {
      'Authorization': AppSession.token,
      // 'X-Requested-With': 'XMLHttpRequest'
    };
    var response = await http.put(
    Uri.parse(  Urls.updateClient(user.id)),
      headers: {
        'Authorization': AppSession.token,
        'Module': 'crm',
        
        'X-Requested-With': 'XMLHttpRequest'
      },
      body: {'file_batch_id': batchId, 'cell_number': '3226'},
    );
    // print(response.body);
    return true;
  }

  Future<bool> taskAddFiles(
      ClientTaskOverviewModel task, String batchId) async {
    // final batchId = randomString(50);
    // for (var file in files) {
    //   await addImage(
    //     batchId,
    //     await file.length() > 3000000
    //         ? await compressImage(file)
    //         : file.readAsBytesSync(),
    //   );
    // }
    var dio = new di.Dio();
    dio.options.headers = {
      'Authorization': AppSession.token,
      // 'X-Requested-With': 'XMLHttpRequest'
    };
    var response = await http.put(
      Uri.parse(Urls.tasks + '/${task.id}'),
      headers: {
        'Authorization': AppSession.token,
        'Module': 'crm',
        
        'X-Requested-With': 'XMLHttpRequest'
      },
      body: {'file_batch_id': batchId, 'cell_number': '3226'},
    );
    // print(response.body);
    return true;
  }

  Future<Uint8List> compressImage(File file) async {
    var result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minWidth: 2300,
      minHeight: 1500,
      quality: 75,
      // rotate: 90,
    );
    print(file.lengthSync());
    print(result.length);
    return result;
  }

  Future<MediaObject> addImage(String batchId, dynamic file) async {
    var imageListInt = file.cast<int>();
    var dio = new di.Dio();
    dio.options.headers = {
      'Authorization': AppSession.token,
      'Module': 'crm',
      
      'X-Requested-With': 'XMLHttpRequest'
    };
    di.FormData formData = new di.FormData.fromMap({
      "batch_id": batchId,
      "file": di.MultipartFile.fromBytes(imageListInt, filename: 'test.jpg')
    });

    var response = await dio.post(
      Urls.addImage,
      data: formData,
    );
    print(response.data);
    try {
      return MediaObject(
        id: response.data['data']['id'].toString(),
        url: response.data['data']['url'],
      );
    } catch (e) {
      return null;
    }
  }

  Future<String> removeImage(String id) async {
    var response = await http.delete(
     Uri.parse( Urls.removeImage(id)),
      headers: {
        'Authorization': AppSession.token,
        'Module': 'crm',
        
        'X-Requested-With': 'XMLHttpRequest'
      },
    );
    final responseData = json.decode(response.body);
    print(responseData);
    return 'true';
  }

  Future<List<Map<String, Object>>> downloadMedias(
      List<MediaModel> medias) async {
    List<Map<String, Object>> files = [];
    for (var media in medias) {
      // print(media.url);
      await http.get(Uri.parse(media.url)).then(
            (value) => files.add(
              {
                'id': media.id,
                'file': value.bodyBytes,
                'isNewFile': media.isNew,
              },
            ),
          );
    }
    return files;
  }

  String dataFilter(String data, {String replacement = ''}) {
    if (data == 'null' ||
        data == 'NULL' ||
        data == '[]' ||
        data == '{}' ||
        data == null) {
      return replacement;
    } else {
      return data;
    }
  }

  String dateConvert(String date) {
    try {
      PersianDate pdate = PersianDate(gregorian: date);
      String dateValue =
          '${pdate.weekdayname} ${pdate.day} ${pdate.monthname} ${pdate.year} ';
      // '${pdate.year} ${pdate.weekdayname} ${pdate.day}،${pdate.monthname}';
      return dateValue;
    } catch (e) {
      return 'زمانی وارد نشده است';
    }
  }

  String paymentTranslate(String payment) {
    if (payment == 'cash') {
      return 'نقد';
    } else if (payment == 'pos') {
      return 'کارت خوان';
    } else if (payment == 'bank-transaction') {
      return 'انتقال بانکی';
    } else {
      return 'چک';
    }
  }
}
