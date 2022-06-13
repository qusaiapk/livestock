import 'package:flutter/cupertino.dart';

class MilkModel {
  int id;
  
  String catogre;
  String description;
  String video;
  MilkModel(
      {@required this.id,
      @required this.catogre,
      @required this.description,
      @required this.video});
  factory MilkModel.fromJson(Map<String, dynamic> json) => MilkModel(
      id: json['id'],
      catogre: json['catogre'],
      description: json['description'],
      video: json['video']);
}
