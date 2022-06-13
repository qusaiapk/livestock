import 'package:flutter/cupertino.dart';

class AnimalModel {
  String name;
  int id;
  String behavior;
  String description;
  String video;

  AnimalModel({
    @required this.name,
    @required this.id,
    @required this.behavior,
    @required this.description,
    @required this.video,
  });
  factory AnimalModel.fromJson(Map<String, dynamic> json) => AnimalModel(
      name: json['name'],
      id: json['id'],
      behavior: json['behavior'],
      description: json['description'],
      video: json['video']);
}
