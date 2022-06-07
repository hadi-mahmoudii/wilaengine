import 'package:flutter/foundation.dart';
import 'package:willaEngine/Cores/Entities/global.dart';

class CommentModel {
  final String id;
  final String date;
  final String message;
  final String scheme;
  final bool owner;
  final String user;
  final String userId;
  final String reply;

  CommentModel({
    @required this.id,
    @required this.date,
    @required this.message,
    @required this.scheme,
    @required this.owner,
    @required this.user,
    @required this.userId,
    @required this.reply,
  });

  factory CommentModel.fromJson(Map data) {
    GlobalEntity gl = new GlobalEntity();
    return CommentModel(
      id: gl.dataFilter(data['id'].toString()),
      date: gl.dateConvert(gl.dataFilter(data['created_at'].toString())),
      message: gl.dataFilter(data['message'].toString()),
      scheme: gl.dataFilter(data['scheme'].toString()),
      owner: data['owner'],
      user: gl.dataFilter(data['user']['name'].toString()),
      userId: gl.dataFilter(data['user']['id'].toString()),
      reply: '',
    );
  }
}
