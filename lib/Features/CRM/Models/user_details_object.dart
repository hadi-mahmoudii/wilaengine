import 'package:flutter/cupertino.dart';

import '../../../Cores/Entities/global.dart';
import '../../../Cores/Models/media.dart';

class ClientDetailsModel {
  final String id;
  final String name;
  final String fName;
  final String lName;
  final String description;
  final String phone;
  final String birthday;
  final String labelName;
  final String father;
  final String nationId;
  final String customerId;
  final String customerCategory;
  final String commentCount;
  final String tasksCount;
  final String transactions;
  final String scheme;
  final String userType;
  final String instagram;
  final List<String> tags;
  final List<ClientAddressModel> addresses;
  final List<ClientPhoneModel> phones;


  final List<MediaModel> medias;

  ClientDetailsModel({
    @required this.id,
    @required this.name,
    @required this.fName,
    @required this.lName,
    @required this.description,
    @required this.phone,
    @required this.birthday,
    @required this.labelName,
    @required this.father,
    @required this.nationId,
    @required this.customerId,
    @required this.customerCategory,
    @required this.commentCount,
    @required this.tasksCount,
    @required this.transactions,
    @required this.scheme,
    @required this.userType,
    @required this.instagram,
    @required this.medias,
    @required this.tags,
    @required this.addresses,
    @required this.phones,

  });

  factory ClientDetailsModel.fromJson(Map datas) {
    for (var ky in datas.keys) {
      print(ky);
      print(datas[ky]);
      print('----------------------');
    }
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
    List<String> tags = [];
    for (var tag in datas['tags']) {
      tags.add(tag);
    }
    List<ClientAddressModel> addresses = [];
    for (var address in datas['addresses']) {
      addresses.add(ClientAddressModel.fromJson(address));
    }
    List<ClientPhoneModel> phones = [];
    for (var phone in datas['phones']) {
      phones.add(ClientPhoneModel.fromJson(phone));
    }
    GlobalEntity gl = new GlobalEntity();
    return ClientDetailsModel(
      id: gl.dataFilter(datas['id'].toString()),
      name: gl.dataFilter(datas['name'].toString()),
      fName: gl.dataFilter(datas['first_name'].toString()),
      lName: gl.dataFilter(datas['last_name'].toString()),
      description: gl.dataFilter(datas['description'].toString()),
      phone: gl.dataFilter(datas['cell_number'].toString()),
      birthday: gl.dataFilter(datas['birthday'].toString()) == ''
          ? ''
          : gl.dateConvert(gl.dataFilter(datas['birthday'].toString())),
      labelName: gl.dataFilter(datas['client_title'].toString()) == ''
          ? ''
          : datas['client_title']['name'].toString(),
      father: gl.dataFilter(datas['father_name'].toString()),
      nationId: gl.dataFilter(datas['national_code'].toString()),
      customerId: gl.dataFilter(datas['file_code'].toString()),
      customerCategory: gl.dataFilter(
                datas['client_categories'].toString(),
              ) ==
              ''
          ? ''
          : datas['client_categories'][0]['name'].toString(),
      commentCount: gl.dataFilter(datas['comments_count'].toString()),
      tasksCount: gl.dataFilter(datas['uncompleted_tasks_count'].toString()),
      transactions: gl.dataFilter(datas['transaction_amount'].toString()),
      scheme: gl.dataFilter(datas['scheme'].toString()),
      userType: gl.dataFilter(datas['user_type'].toString()),
      instagram: gl.dataFilter(datas['instagram'].toString()),
      medias: medias,
      tags: tags,
      addresses: addresses,
      phones: phones,
    );
  }
}

class ClientOverviewModel {
  final String id;
  final String name;
  final String nameEn;
  final String phone;

  ClientOverviewModel({
    @required this.id,
    @required this.name,
    @required this.nameEn,
    @required this.phone,
  });

  factory ClientOverviewModel.fromJson(Map datas) {
    GlobalEntity gl = new GlobalEntity();
    return ClientOverviewModel(
      id: gl.dataFilter(datas['id'].toString()),
      name: gl.dataFilter(datas['name'].toString()),
      nameEn: gl.dataFilter(datas['name_en'].toString()),
      phone: gl.dataFilter(
        datas['cell_number'].toString(),
        replacement: '-',
      ),
    );
  }
}

class ClientAddressModel {
  final String id, title, postalCode, city, address;
  final String phone;

  ClientAddressModel({
    @required this.id,
    @required this.title,
    @required this.postalCode,
    @required this.city,
    @required this.address,
    this.phone,
  });

  factory ClientAddressModel.fromJson(Map datas) {
    GlobalEntity gl = new GlobalEntity();
    return ClientAddressModel(
      id: gl.dataFilter(datas['id'].toString()),
      title: gl.dataFilter(datas['title'].toString()),
      postalCode: gl.dataFilter(datas['postal_code'].toString()),
      city: gl.dataFilter(datas['city']['name_fa'].toString()),
      address: gl.dataFilter(datas['district']['name_fa'].toString()),
    );
  }
}

class ClientPhoneModel {
  final String id, label, phone;

  ClientPhoneModel({
    @required this.id,
    @required this.label,
    @required this.phone,
  });

  factory ClientPhoneModel.fromJson(Map datas) {
    GlobalEntity gl = new GlobalEntity();
    return ClientPhoneModel(
      id: gl.dataFilter(datas['id'].toString()),
      label: gl.dataFilter(datas['label'].toString()),
      phone: gl.dataFilter(datas['number'].toString()),

    );
  }
}
