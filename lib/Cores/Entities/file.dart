import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as di;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Config/app_session.dart';
import '../Config/urls.dart';
import '../Models/media.dart';

// import 'package:http/http.dart' as http;
class FileEntity {
  final String batchId;

  FileEntity({
    @required this.batchId,
  });
  Future<List<FilePickerResult>> readFilesFromDevice() async {
    List<FilePickerResult> files = [];
    try {
      List<FilePickerResult> fls = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'bmp', 'jpeg'],
      )) as List<FilePickerResult>;
       
      fls.forEach((file) async {
        // files.add(await addImage(file, type));
        files.add(file);
      });
    } catch (_) {}

    return files;
  }

  Future<List<MediaModel>> addFiles(
      BuildContext context, List<File> files) async {
    List<MediaModel> results = [];
    for (var file in files) {
      String fileType = '';
      if (file.path.endsWith('jpeg'))
        fileType = 'jpeg';
      else if (file.path.endsWith('jpg'))
        fileType = 'jpg';
      else if (file.path.endsWith('bmp'))
        fileType = 'bmp';
      else if (file.path.endsWith('png')) fileType = 'png';
      MediaModel temp = await addImage(file, fileType);
      // MediaModel temp = MediaModel(file: file);
      results.add(temp);
    }
    return results;
  }

  Future<MediaModel> addImage(File file, String fileType) async {
    print(batchId);
    var imageListInt = file.readAsBytesSync().cast<int>();
    var dio = new di.Dio();
    dio.options.headers = {
      'Authorization': AppSession.token,
      'Module': 'crm',
      
      'X-Requested-With': 'XMLHttpRequest'
    };
    String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    di.FormData formData = new di.FormData.fromMap({
      "batch_id": batchId,
      "file": di.MultipartFile.fromBytes(
        imageListInt,
        filename: '$timeStamp.$fileType',
      ),
    });

    var response = await dio.post(
      Urls.addImage,
      data: formData,
    );
    print(response.data);
    try {
      return MediaModel(
        id: response.data['data']['id'].toString(),
        url: response.data['data']['url'],
        file: file,
        isNew: true,
      );
    } catch (e) {
      return null;
    }
  }

  Future<String> removeImage(String id) async {
    var response = await http.delete(
    Uri.parse(Urls.removeImage(id)),
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

  // Future<List<Map<String, Object>>> downloadMedias(
  //     List<MediaModel> medias) async {
  //   List<Map<String, Object>> files = [];
  //   for (var media in medias) {
  //     // print(media.url);
  //     await http.get(media.url).then(
  //           (value) => files.add(
  //             {
  //               'id': media.id,
  //               'file': value.bodyBytes,
  //               'isNewFile': media.isNew,
  //             },
  //           ),
  //         );
  //   }
  //   return files;
  // }
}
