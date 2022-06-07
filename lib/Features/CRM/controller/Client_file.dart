import 'dart:io';

import 'package:either_option/either_option.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:random_string/random_string.dart';

import '../../../Cores/Config/app_session.dart';
import '../../../Cores/Config/urls.dart';
import '../../../Cores/Entities/file.dart';
import '../../../Cores/Entities/server_request.dart';
import '../../../Cores/Models/error_result.dart';
import '../../../Cores/Models/media.dart';
import '../../../Cores/Models/option_model.dart';
import '../../../Cores/Models/request_status.dart';
import '../Models/user_details_object.dart';

class ClientFileController extends GetxController  {
  var images = <MediaModel>[].obs;
  RequestStatus requestStatus = RequestStatus.loading;
  var newFilesLoadingStatus = RequestStatus.stable.obs;
  var isUpdating = RequestStatus.stable.obs;
  final String batchId = randomString(50);
  FileEntity fileClass ;
  var newImages = 0.obs;

  final ClientDetailsModel user;

  ClientFileController({
    @required this.user,
  }) {
    fileClass = FileEntity(batchId: batchId);
    images.add(MediaModel(
        id: 'add', url: 'add', type: 'add')); //this use for add button
    for (var image in user.medias) {
      images.add(image);
    }
  }

  // fetchDatas(BuildContext context) async {
  //   fileClass = FileEntity(batchId: batchId);
  //   images.add(MediaModel(
  //       id: 'add', url: 'add', type: 'add')); //this use for add button
  //   requestStatus = RequestStatus.loading;
  //   notifyListeners();
  //   final Either<ErrorResult, ClientTaskModel> result =
  //       await ServerRequest<ClientTaskModel>()
  //           .fetchData(Urls.singleTask(taskOverview.id));
  //   result.fold(
  //     (error) async {
  //       await ErrorResult.showDlg(error.type, context);
  //       Navigator.of(context).pop();
  //       // requestStatus = RequestStatus.error;
  //       // notifyListeners();
  //     },
  //     (result) {
  //       task = result;
  //       requestStatus = RequestStatus.stable;
  //       for (var image in task.medias) {
  //         images.add(image);
  //       }
  //       notifyListeners();
  //     },
  //   );
  // }

  addImages(BuildContext context, List<File> files, bool isGaleryFiles) async {
    //get files becuase if mode is camera function most passed to camera screen and captured image pass here
    newFilesLoadingStatus.value = RequestStatus.loading;
    
    var tempFiles = <File>[].obs;
    if (isGaleryFiles)
      tempFiles.value = (await fileClass.readFilesFromDevice()).cast<File>();
    else
      tempFiles.value = files;
    List<MediaModel> temps = await fileClass.addFiles(context, tempFiles);
    images.value += temps;
    // await Future.delayed(Duration(seconds: 10));
    newFilesLoadingStatus.value = RequestStatus.stable;
    newImages.value += 1;
    
  }

  removeImage(BuildContext context, MediaModel media) async {
    // print(media.id);
    newFilesLoadingStatus.value = RequestStatus.loading;
    
    final Either<ErrorResult, String> result =
        await ServerRequest<OptionModel>()
            .deleteData(Urls.removeImage(media.id));
    result.fold(
      (error) async {
        await ErrorResult.showDlg(error.type, context);
        // request = RequestStatus.error;
        
      },
      (result) {
        images.removeWhere((element) => element.id == media.id);
        if (media.isNew) newImages--;
        newFilesLoadingStatus.value = RequestStatus.stable;
       
      },
    );
  }

  updateTask(BuildContext context) async {
    isUpdating.value = RequestStatus.loading;
    
    await http.put(
      Uri.parse(Urls.updateClient(user.id)),
      headers: {
        'Authorization': AppSession.token,
        'Module': 'crm',
        
        'X-Requested-With': 'XMLHttpRequest'
      },
      body: {'file_batch_id': batchId},
    );
    Navigator.of(context).pop();
  }

  @override
  void reassemble() {}
}
