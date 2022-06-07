import 'dart:io';

import 'package:flutter/material.dart';

class MediaModel {
  final String id;
  final String url;
  bool isNew;
  String type;
  File file;

  MediaModel({
    @required this.id,
    @required this.url,
    this.isNew = false,
    this.type = 'image',
    this.file,
  });
}
