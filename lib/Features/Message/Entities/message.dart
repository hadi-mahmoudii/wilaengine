import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../Cores/Config/app_session.dart';
import '../../../Cores/Config/urls.dart';
import '../../../Cores/Entities/global.dart';
import '../Models/messages.dart';

class MessageEntity {
  Future<List<MessageTemplateObject>> getMessageTemplates() async {
    var response = await http.get(
     Uri.parse( Urls.getMessageTemplates),
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Module': 'crm',
        'Authorization': AppSession.token,
      },
    );
    final responseData = json.decode(response.body);
    print(responseData);
    List<MessageTemplateObject> templates = [];
    GlobalEntity gl = new GlobalEntity();
    for (var template in responseData['data']) {
      templates.add(
        MessageTemplateObject(
          id: gl.dataFilter(template['id'].toString()),
          name: gl.dataFilter(template['name'].toString()),
          template: gl.dataFilter(template['template'].toString()),
          owner: template['owner'],
        ),
      );
    }
    return templates;
  }

  Future<bool> sendMessage(String id, String content, String oprator) async {
    // print(oprator);
    var response = await http.post(Uri.parse(Urls.sendMessage),
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'Module': 'crm',
          'Authorization': AppSession.token,
          'content-type': 'application/json'
        },
        body: json.encode({
          'content': content,
          'operator': oprator,
          'ids[0]': id,
        }));
    final responseData = json.decode(response.body);
    print(responseData);
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
