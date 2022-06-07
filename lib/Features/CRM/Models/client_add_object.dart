import 'package:flutter/cupertino.dart';

class ClientAddObject {
  final TextEditingController category;
  final TextEditingController label;
  final TextEditingController
      firstName; // if use String page most refresh to get datas from text feild
  final TextEditingController lastName;
  final TextEditingController birthday;
  final TextEditingController phone;
  final TextEditingController description;

  ClientAddObject({
    @required this.category,
    @required this.label,
    @required this.firstName,
    @required this.lastName,
    @required this.birthday,
    @required this.phone,
    @required this.description,
  });
}
