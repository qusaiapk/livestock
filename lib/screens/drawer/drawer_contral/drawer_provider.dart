import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerProvider extends ChangeNotifier {
  String type = "";
  typeChanger() async {
    SharedPreferences prefe = await SharedPreferences.getInstance();
    this.type = prefe.getString('type');
    notifyListeners();
  }
}
