import 'package:flutter/cupertino.dart';

class MediaObject {
  final String id;
  final String url;
  final String isNew;
  final String type;

  MediaObject({
    @required this.id,
    @required this.url,
    this.isNew,
    this.type,
  });
}
