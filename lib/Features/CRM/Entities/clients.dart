import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../Cores/Config/app_session.dart';
import '../../../Cores/Config/urls.dart';
import '../../../Cores/Entities/global.dart';
import '../../../Cores/Models/media.dart';
import '../Models/client_add_object.dart';
import '../Models/client_task_object.dart';
import '../Models/transaction_object.dart';
import '../Models/user_details_object.dart';

class ClientsEntity {
  Future<dynamic> getClientsListDatas(String page, {String name = ''}) async {
    var response = await http.get(Uri.parse(Urls.getClients(page, name: name)), headers: {
      'X-Requested-With': 'XMLHttpRequest',
     
      'Module': 'crm',
      'Authorization': AppSession.token,
    });
    final responseData = json.decode(response.body);
    List<ClientOverviewModel> users = [];
    GlobalEntity gl = new GlobalEntity();
    for (var user in responseData['data']) {
      users.add(
        ClientOverviewModel(
          id: gl.dataFilter(user['id'].toString()),
          name: gl.dataFilter(user['name'].toString()),
          nameEn: gl.dataFilter(user['name_en'].toString()),
          phone: gl.dataFilter(
            user['cell_number'].toString(),
            replacement: '-',
          ),
        ),
      );
    }
    return users;
  }

  Future<dynamic> getSingleClientData(String id) async {
    // print(AppSession.token);
    var response = await http.get(Uri.parse(Urls.clients + '/$id'), headers: {
      'X-Requested-With': 'XMLHttpRequest',
      
      'Module': 'crm',
      'Authorization': AppSession.token,
    });
    final responseData = json.decode(response.body);
    // print(response.statusCode);
    List<MediaModel> medias = [];
    for (var media in responseData['data']['media']) {
      medias.add(
        MediaModel(
          id: media['id'].toString(),
          url: media['thumbnail'].toString(),
        ),
      );
      // medias.add(media['thumbnail'].toString());
    }
    GlobalEntity gl = new GlobalEntity();
    ClientDetailsModel user = ClientDetailsModel(
      id: gl.dataFilter(responseData['data']['id'].toString()),
      name: gl.dataFilter(responseData['data']['name'].toString()),
      phone:
          gl.dataFilter(responseData['data']['registration_number'].toString()),
      birthday: gl.dataFilter(responseData['data']['birthday'].toString()) == ''
          ? ''
          : gl.dateConvert(
              gl.dataFilter(responseData['data']['birthday'].toString())),
      labelName:
          gl.dataFilter(responseData['data']['client_title'].toString()) == ''
              ? ''
              : responseData['data']['client_title']['name'].toString(),
      father: gl.dataFilter(responseData['data']['father_name'].toString()),
      nationId: gl.dataFilter(responseData['data']['national_code'].toString()),
      customerId: gl.dataFilter(responseData['data']['file_code'].toString()),
      customerCategory: gl.dataFilter(
                responseData['data']['client_categories'].toString(),
              ) ==
              ''
          ? ''
          : responseData['data']['client_categories'][0]['name'].toString(),
      commentCount: gl.dataFilter(
        responseData['data']['comments_count'].toString(),
      ),
      tasksCount: gl.dataFilter(
        responseData['data']['uncompleted_tasks_count'].toString(),
      ),
      transactions: gl.dataFilter(
        responseData['data']['transaction_amount'].toString(),
      ),
      scheme: gl.dataFilter(
        responseData['data']['scheme'].toString(),
      ),
      medias: medias,
      description: '',
      lName: '',
      userType: '',
      fName: '',
      instagram: '',
      tags: [],
      addresses: [],
      phones: [],
    );
    // print(responseData['data']['client_title']);
    return user;
  }

  Future<dynamic> getTransactionDetails(String id) async {
    var response = await http.get(Uri.parse(Urls.getTransactionDetails(id)), headers: {
      'X-Requested-With': 'XMLHttpRequest',
      
      'Module': 'crm',
      'Authorization': AppSession.token,
    });
    final responseData = json.decode(response.body);
    GlobalEntity gl = new GlobalEntity();
    String payments = '';
    for (var payment in responseData['data']['payment_types'].keys) {
      print(payment.toString());
      payments += '${gl.paymentTranslate(payment.toString())}\n';
    }
    final ClientTransactionModel transaction = ClientTransactionModel(
      id: gl.dataFilter(responseData['data']['id'].toString()),
      price: gl.dataFilter(responseData['data']['amount'].toString()),
      date: gl.dataFilter(responseData['data']['date'].toString()),
      category:
          gl.dataFilter(responseData['data']['transaction_title'].toString()),
      itemcount: gl.dataFilter(
          responseData['data']['transaction_items'].length.toString()),
      paymentType: payments,
      details: gl.dataFilter(responseData['data']['description'].toString()),
      paymentItems: responseData['data']['transaction_items'],
    );
    return transaction;
  }

  Future<dynamic> getCategoriesAndTitles() async {
    List<Map<String, String>> titleDatas = [];
    var response = await http.get(Uri.parse(Urls.getCategories), headers: {
      'X-Requested-With': 'XMLHttpRequest',
      
      'Module': 'crm',
      'Authorization': AppSession.token,
    });
    final responseData = json.decode(response.body);
    for (var data in responseData['data']) {
      titleDatas
          .add({'id': data['id'].toString(), 'name': data['name'].toString()});
    }
    List<Map<String, String>> categoriyDatas = [];
    var response2 = await http.get(Uri.parse(Urls.getTitles), headers: {
      'X-Requested-With': 'XMLHttpRequest',
      
      'Module': 'crm',
      'Authorization': AppSession.token,
    });
    final responseData2 = json.decode(response2.body);
    for (var data in responseData2['data']) {
      categoriyDatas
          .add({'id': data['id'].toString(), 'name': data['name'].toString()});
    }
    // print([categoriyDatas, titleDatas]);
    return [
      titleDatas,
      categoriyDatas,
    ];
  }

  Future<dynamic> getCategoriesAndUsers() async {
    List<Map<String, String>> titleDatas = [];
    var response = await http.get(Uri.parse(Urls.getTaskCategories), headers: {
      'X-Requested-With': 'XMLHttpRequest',
      
      'Module': 'crm',
      'Authorization': AppSession.token,
    });
    final responseData = json.decode(response.body);
    for (var data in responseData['data']) {
      titleDatas
          .add({'id': data['id'].toString(), 'name': data['name'].toString()});
    }
    List<Map<String, String>> categoriyDatas = [];
    var response2 = await http.get(Uri.parse(Urls.getRecieverUsers), headers: {
      'X-Requested-With': 'XMLHttpRequest',
      
      'Module': 'crm',
      'Authorization': AppSession.token,
    });
    final responseData2 = json.decode(response2.body);
    for (var data in responseData2['data']) {
      categoriyDatas
          .add({'id': data['id'].toString(), 'name': data['name'].toString()});
    }
    // print([categoriyDatas, titleDatas]);
    return [categoriyDatas, titleDatas];
  }

  Future<dynamic> createNewClient(ClientAddObject newUser) async {
    try {
      var response = await http.post(
        Uri.parse(Urls.clients),
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
        
          'Module': 'crm',
          'Authorization': AppSession.token,
        },
        body: newUser.category.text != ''
            ? {
                'first_name': newUser.firstName.text,
                'last_name': newUser.lastName.text,
                'user_type': 'natural',
                "client_title[connect]": newUser.label.text,
                'birthday': newUser.birthday.text,
                'cell_number': newUser.phone.text,
                'description': newUser.description.text,
                'client_categories[sync][]': newUser.category.text,
              }
            : {
                'first_name': newUser.firstName.text,
                'last_name': newUser.lastName.text,
                'user_type': 'natural',
                "client_title[connect]": newUser.label.text,
                'birthday': newUser.birthday.text,
                'cell_number': newUser.phone.text,
                'description': newUser.description.text,
              },
      );
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }

    // try {
    //   print(newUser.phone.text);
    //   var dio = di.Dio();
    //   dio.options.headers = {
    //     'X-Requested-With': 'XMLHttpRequest',
    //     'origin': Urls.domain,
    //     'Module': 'crm',
    //     'Authorization': AppSession.token,
    //     'content-type':'application/json'
    //   };
    //   di.FormData formData = di.FormData();
    //   formData.fields.add(MapEntry('first_name', newUser.firstName.text));
    //   formData.fields.add(MapEntry('last_name', newUser.lastName.text));
    //   formData.fields.add(MapEntry('user_type', 'natural'));
    //   formData.fields
    //       .add(MapEntry("client_title[connect]", newUser.category.text));
    //   formData.fields.add(MapEntry('birthday', newUser.birthday.text));
    //   formData.fields.add(MapEntry('cell_number', newUser.phone.text));
    //   formData.fields.add(MapEntry('description', newUser.description.text));
    //   formData.fields
    //       .add(MapEntry('client_categories[sync][]', newUser.label.text));
    //   var response = await dio.post(
    //     Urls.clients,
    //     data: formData,
    //   );
    //   print(response.data);
    //   return true;
    // } catch (e) {
    //   print(e);
    //   return false;
    // }
  }

  Future<dynamic> createNewTask(TaskAddObject newTask) async {
    try {
      var response = await http.post(
        Uri.parse(Urls.tasks),
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          
          'Module': 'crm',
          'Authorization': AppSession.token,
        },
        body: newTask.category.text != ''
            ? {
                'begin_date': newTask.sDate.text,
                'end_date': newTask.eDate.text,
                'description': newTask.details.text,
                // "client_title[connect]": newTask.user.text,
                'receiver_user[connect]': newTask.user.text,
                'task_category[connect]': newTask.category.text,
                'title': newTask.label.text,
                'rel_id': newTask.relId,
                'rel_type': newTask.relType,
                // 'last_name':'test',
              }
            : {
                'begin_date': newTask.sDate.text,
                'end_date': newTask.eDate.text,
                'description': newTask.details.text,
                // "client_title[connect]": newTask.user.text,
                'receiver_user[connect]': newTask.user.text,
                'task_category[connect]': newTask.category.text,
                'title': newTask.label.text,
                'rel_id': newTask.relId,
                'rel_type': newTask.relType,
              },
      );
      // var dio = di.Dio();
      // dio.options.headers = {
      //   'X-Requested-With': 'XMLHttpRequest',
      //   'origin': Urls.domain,
      //   'Module': 'crm',
      //   'Authorization': AppSession.token,
      // };
      // di.FormData formData = di.FormData();
      // formData.fields.add(MapEntry('begin_date', newTask.sDate.text));
      // formData.fields.add(MapEntry('end_date', newTask.eDate.text));
      // formData.fields.add(MapEntry('description', newTask.details.text));
      // formData.fields
      //     .add(MapEntry("receiver_user[connect]", newTask.user.text));
      // formData.fields
      //     .add(MapEntry('task_category[connect]', newTask.category.text));
      // formData.fields.add(MapEntry('title', newTask.label.text));
      // formData.fields.add(MapEntry('rel_id', newTask.relId));
      // formData.fields.add(MapEntry('rel_type', newTask.relType));

      // var response = await dio.post(
      //   Urls.tasks,
      //   data: formData,
      // );
      // print(response.body);
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteClient(String id) async {
    var response = await http.delete(Uri.parse(Urls.deleteClient(id)), headers: {
      'X-Requested-With': 'XMLHttpRequest',
      'Module': 'crm',
      'Authorization': AppSession.token,
    });
    final responseData = json.decode(response.body);
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
