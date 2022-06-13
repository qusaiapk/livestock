import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:livestock/models/animal_model.dart';
import 'package:livestock/models/commentF.dart';
import 'package:livestock/models/milk_model.dart';
import 'package:livestock/models/post_model.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ApiServer {
  static String _serverUrl = 'http://qassimuni.com/myapp/public/api/';

  static Future<Map> login(
      {@required String phone, @required String password}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map shared = Map();
    final response = await http.post(Uri.parse('${_serverUrl}login'), body: {
      "phone": phone,
      "password": password,
    });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      if (data['status']) {
        List l = data[data['type']];
        prefs.setString('status', data['status'].toString());
        prefs.setString('type', data['type']).toString();
        prefs.setString('name', l[0]['name']).toString();
        prefs.setString('id', l[0]['id'].toString()).toString();

        shared['status'] = prefs.getString('status').toString();
        shared['type'] = prefs.getString('type').toString();
        shared['name'] = prefs.getString('name');
        shared['password'] = prefs.getString('password');
        shared['id'] = prefs.getString('id');
        print(shared['id']);
      }
    } else {
      print(response.statusCode);
    }
    return shared;
  }

  static Future<String> register(
      {@required String phone,
      @required String password,
      @required String name,
      @required String state}) async {
    print("name ----: " + name);
    print("password ----: " + password);
    print("phone ----: " + phone);
    print("state ----: " + state);
    String shared = '';
    var dataStore = {
      "name": name,
      "password": password,
      "phone": phone,
      "state": state,
      "image": ""
    };

    final response = await http.post(
        Uri.parse('http://qassimuni.com/myapp/public/api/register'),
        body: dataStore);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      print(data["status"]);
      shared = data['status'].toString();
    } else {
      print(response.statusCode);
    }
    return shared;
  }

  static Future<List<PostModel>> getPosts() async {
    var json;
    final response =
        await http.get(Uri.parse('http://qassimuni.com/myapp/public/api/post'));

    if (response.statusCode == 200) {
      final postes = jsonDecode(response.body).cast<Map<String, dynamic>>();

      json = postes.map<PostModel>((post) => PostModel.fromJson(post)).toList();
    } else {
      print(response.statusCode);
    }
    return json;
  }

  static Future<List<MilkModel>> getMilkProduct({catogre}) async {
    var json;
    final response = await http
        .post(Uri.parse('${_serverUrl}milk'), body: {"catogre": catogre});
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      final milks = jsonDecode(response.body).cast<Map<String, dynamic>>();
      print(milks);
      json = milks.map<MilkModel>((milk) => MilkModel.fromJson(milk)).toList();
    } else {
      print(response.statusCode);
    }
    return json;
  }

  static Future<List<AnimalModel>> getAnimalDet({name}) async {
    var json;
    final response =
        await http.post(Uri.parse('${_serverUrl}animal'), body: {'name': name});

    if (response.statusCode == 200) {
      final animal = jsonDecode(response.body).cast<Map<String, dynamic>>();

      json = animal
          .map<AnimalModel>((animal) => AnimalModel.fromJson(animal))
          .toList();
    } else {
      print(response.statusCode);
    }
    return json;
  }

  static Future<List<CommentF>> getComment() async {
    var json;
    final response = await http.post(Uri.parse('${_serverUrl}showanswer'));
    if (response.statusCode == 200) {
      final postes = jsonDecode(response.body).cast<Map<String, dynamic>>();

      json = postes.map<CommentF>((com) => CommentF.fromJson(com)).toList();
      print(json);
    } else {
      print('error____${response.statusCode}');
    }
    return json;
  }

  static Future<List<CommentF>> getAsker({String askname}) async {
    var json;
    final response = await http.post(
        Uri.parse(
          '${_serverUrl}getAsker',
        ),
        body: {'askname': askname});
    if (response.statusCode == 200) {
      final postes = jsonDecode(response.body).cast<Map<String, dynamic>>();

      json = postes.map<CommentF>((com) => CommentF.fromJson(com)).toList();
      print(json);
    } else {
      print('error____${response.statusCode}');
    }
    return json;
  }

  static Future<String> setComment({
    @required String answer,
    @required String doctorname,
    @required String ask_id,
  }) async {
    String shared = '';
    var dataStore = {
      "answer": answer,
      "doctorname": doctorname,
      "ask_id": ask_id,
    };

    final response =
        await http.post(Uri.parse('${_serverUrl}saveanswer'), body: dataStore);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      print(data["status"]);
      shared = data['status'].toString();
    } else {
      print(response.statusCode);
    }
    return shared;
  }

  static Future<String> AddComment({
    @required String name,
    @required String mesage,
  }) async {
    print(name);
    print(mesage);
    String shared = '';
    var dataStore = {
      "name": name,
      "mesage": mesage,
    };

    final response =
        await http.post(Uri.parse('${_serverUrl}saveask'), body: dataStore);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      print(data["status"]);
      shared = data['status'].toString();
    } else {
      print(response.statusCode);
    }
    return shared;
  }

  static Future<Map> updateUser(
      {@required id, @required String phone, @required String name}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map shared = Map();
    final response = await http
        .post(Uri.parse('http://192.168.42.180:8000/api/updateuser'), body: {
      "id": id,
      "name": name,
      "phone": phone,
    });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print("data$data");

      if (data['status']) {
        List l = data[data['type']];
        prefs.setString('status', data['status'].toString());

        prefs.setString('name', data['name']).toString();

        shared['status'] = prefs.getString('status').toString();

        shared['name'] = prefs.getString('name');
        print("shared$shared");
      }
    } else {
      print(response.statusCode);
    }
    return shared;
  }
}
