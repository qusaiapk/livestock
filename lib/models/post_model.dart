import 'package:flutter/cupertino.dart';

class PostModel {
  int id;
  String postBody;
  String photo;
  PostModel({@required this.id, @required this.postBody, @required this.photo});
  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
      id: json['id'], postBody: json['bodypost'], photo: json['photo']);
}
