import 'package:flutter/cupertino.dart';
import 'package:willaEngine/Cores/Models/option_model.dart';

import '../../../Cores/Entities/global.dart';
import '../../../Cores/Models/media.dart';

class ClientTaskModel {
  final String id;
  final String category;
  final String user;
  final String sDate;
  final String eDate;
  final String details;
  final OptionModel status;
  final String title;
  final String commentCount;
  final List<MediaModel> medias;

  ClientTaskModel({
    @required this.id,
    @required this.category,
    @required this.user,
    @required this.sDate,
    @required this.eDate,
    @required this.details,
    @required this.status,
    @required this.title,
    @required this.commentCount,
    @required this.medias,
  });

  factory ClientTaskModel.fromJson(Map datas) {
    // print(datas);
    GlobalEntity gl = new GlobalEntity();
    List<MediaModel> medias = [];
    for (var media in datas['media']) {
      medias.add(
        MediaModel(
          id: media['id'].toString(),
          url: media['thumbnail'].toString(),
        ),
      );
      // medias.add(media['thumbnail'].toString());
    }
    var taskStatus;
    if (gl.dataFilter(datas['task_status'].toString()).isNotEmpty)
      taskStatus = datas['task_status'];
    else
      taskStatus = '';
    return ClientTaskModel(
      id: gl.dataFilter(datas['id'].toString()),
      category: gl.dataFilter(datas['task_category'].toString()) == ''
          ? ''
          : datas['task_category']['name'].toString(),
      user: gl.dataFilter(datas['user']['name'].toString()),
      title: gl.dataFilter(datas['title'].toString()),
      sDate: gl.dateConvert(gl.dataFilter(datas['begin_date'].toString())),
      eDate: gl.dateConvert(gl.dataFilter(datas['end_date'].toString())),
      details: gl.dataFilter(datas['description'].toString()),
      status: taskStatus != ''
          ? OptionModel(
              id: taskStatus['id'].toString(), title: taskStatus['name'])
          : taskStatus,
      commentCount: 0.toString(),
      // commentsCount: gl.dataFilter(task['comments_count'].toString()),
      medias: medias,
    );
  }
}

class ClientTaskOverviewModel {
  final String id;
  final String category;
  final String date;
  final OptionModel status;
  final String user;

  ClientTaskOverviewModel({
    @required this.id,
    @required this.category,
    @required this.date,
    @required this.status,
    @required this.user,
  });
  factory ClientTaskOverviewModel.fromJson(Map datas) {
    GlobalEntity gl = new GlobalEntity();
    var taskStatus;
    if (gl.dataFilter(datas['task_status'].toString()).isNotEmpty)
      taskStatus = datas['task_status'];
    else
      taskStatus = '';
    return ClientTaskOverviewModel(
      id: gl.dataFilter(datas['id'].toString()),
      category: gl.dataFilter(datas['task_category'].toString()) == ''
          ? ''
          : datas['task_category']['name'].toString(),
      date: gl.dateConvert(gl.dataFilter(datas['begin_date'].toString())),
      status: taskStatus != ''
          ? OptionModel(
              id: taskStatus['id'].toString(), title: taskStatus['name'])
          : OptionModel(id: '', title: ''),
      user: gl.dataFilter(datas['receiver_user']['name'].toString()),
    );
  }
}

class TaskAddObject {
  final TextEditingController category;
  final TextEditingController label;
  final TextEditingController user;
  final TextEditingController sDate;
  final TextEditingController eDate;
  final TextEditingController details;
  final String relId;
  final String relType;

  TaskAddObject({
    @required this.category,
    @required this.label,
    @required this.user,
    @required this.sDate,
    @required this.eDate,
    @required this.details,
    @required this.relId,
    @required this.relType,
  });
}
