import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../Cores/Config/app_session.dart';
import '../../../Cores/Config/urls.dart';

class TasksEntity {
  // Future<dynamic> getUserTasks(String id, String type, String page) async {
  //   var response = await http.get(
  //     Urls.getUserTasks(id, type, page),
  //     headers: {
  //       'X-Requested-With': 'XMLHttpRequest',
  //       'origin': Urls.domain,
  //       'Module': 'crm',
  //       'Authorization': AppSession.token,
  //     },
  //   );
  //   final responseData = json.decode(response.body);
  //   List<ClientTaskOverviewModel> tasks = [];
  //   GlobalEntity gl = new GlobalEntity();
  //   for (var task in responseData['data']) {
  //     print(task);
  //     tasks.add(
  //       ClientTaskOverviewModel(
  //         id: gl.dataFilter(task['id'].toString()),
  //         category: gl.dataFilter(task['task_category'].toString()) == ''
  //             ? ''
  //             : task['task_category']['name'].toString(),
  //         date: gl.dateConvert(gl.dataFilter(task['begin_date'].toString())),
  //         status: gl.dataFilter(task['task_status'].toString()),
  //         user: gl.dataFilter(task['receiver_user']['name'].toString()),
  //       ),
  //     );
  //   }
  //   return tasks;
  // }

  // Future<ClientTaskModel> getSingleTaskDetails(String id) async {
  //   var response = await http.get(
  //     Urls.tasks + '/$id',
  //     headers: {
  //       'X-Requested-With': 'XMLHttpRequest',
  //       'origin': Urls.domain,
  //       'Module': 'crm',
  //       'Authorization': AppSession.token,
  //     },
  //   );
  //   final responseData = json.decode(response.body);
  //   ClientTaskModel task;
  //   GlobalEntity gl = new GlobalEntity();
  //   List<MediaModel> medias = [];
  //   for (var media in responseData['data']['media']) {
  //     medias.add(
  //       MediaModel(
  //         id: media['id'].toString(),
  //         url: media['thumbnail'].toString(),
  //       ),
  //     );
  //     // medias.add(media['thumbnail'].toString());
  //   }
  //   // print(medias[0].url);
  //   task = ClientTaskModel(
  //     id: gl.dataFilter(responseData['data']['id'].toString()),
  //     category:
  //         gl.dataFilter(responseData['data']['task_category'].toString()) == ''
  //             ? ''
  //             : responseData['data']['task_category']['name'].toString(),
  //     user: gl.dataFilter(responseData['data']['user']['name'].toString()),
  //     sDate: gl.dateConvert(
  //         gl.dataFilter(responseData['data']['begin_date'].toString())),
  //     eDate: gl.dateConvert(
  //         gl.dataFilter(responseData['data']['end_date'].toString())),
  //     details: gl.dataFilter(responseData['data']['description'].toString()),
  //     status: gl.dataFilter(responseData['data']['task_status'].toString()),
  //     commentCount: 0.toString(),
  //     // commentsCount: gl.dataFilter(task['comments_count'].toString()),
  //     medias: medias,
  //   );
  //   // print(responseData['data']['comments_count'].toString());
  //   return task;
  // }

  Future<bool> deleteTask(String id) async {
    var response = await http.delete(Uri.parse(Urls.deleteTask(id)), headers: {
      'X-Requested-With': 'XMLHttpRequest',
      
      'Module': 'crm',
      'Authorization': AppSession.token,
    });
    var responseData = json.decode(response.body);
    try {
      if (responseData['message']['title'] == 'موفق') {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
