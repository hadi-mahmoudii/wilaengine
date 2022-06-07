import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../Cores/Config/app_session.dart';
import '../../../Cores/Config/urls.dart';
import '../../../Cores/Entities/global.dart';
import '../Models/comment_object.dart';

class CommentsEntitey {
  Future<dynamic> getComments(String id, String type, String page) async {
    var result = await http.get(Uri.parse(Urls.getComments(id, type, page)), headers: {
      'X-Requested-With': 'XMLHttpRequest',
      
      'Module': 'crm',
      'Authorization': AppSession.token,
    });
    var datas = json.decode(result.body);
    List<CommentModel> comments = [];
    GlobalEntity gl = new GlobalEntity();

    for (var data in datas['data']) {
      comments.add(
        CommentModel(
          id: gl.dataFilter(data['id'].toString()),
          date: gl.dateConvert(gl.dataFilter(data['created_at'].toString())),
          message: gl.dataFilter(data['message'].toString()),
          scheme: gl.dataFilter(data['scheme'].toString()),
          owner: data['owner'],
          user: gl.dataFilter(data['user']['name'].toString()),
          userId: gl.dataFilter(data['user']['id'].toString()),
          reply: '',
        ),
      );
    }
    // print(data);
    return comments;
  }

  Future<String> sendComment(String id, String message, String type) async {
    var response = await http.post(
     Uri.parse(Urls.sendComment),
      body: {
        'rel_id': id,
        'message': message,
        'rel_type': type,
      },
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        
        'Module': 'crm',
        'Authorization': AppSession.token,
      },
    );
    print(response.body);
    return 'true';
  }
}
