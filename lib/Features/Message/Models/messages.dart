import 'package:flutter/cupertino.dart';

class MessageTemplateObject {
  final String id;
  final String name;
  final String template;
  final bool owner;

  MessageTemplateObject({
    @required this.id,
    @required this.name,
    @required this.template,
    @required this.owner,
  });
}
