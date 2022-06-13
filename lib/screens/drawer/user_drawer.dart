import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';



import 'package:livestock/screens/tab_screen.dart';
import 'package:livestock/widgets/rounded_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../comment/View/your_asks.dart';
import '../edit_profile_screen.dart';

class UserDrawer extends StatefulWidget {
  @override
  _UserDrawer createState() => _UserDrawer();
}

class _UserDrawer extends State<UserDrawer> {
  var textStyle = TextStyle(
    fontSize: 17,
    color: Colors.black,
    fontFamily: "Almarai",
  );
  String _userName = "";

  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();

    loadedLocalSaveData();
  }

  loadedLocalSaveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      print(prefs.getString('name').toString());
      _userName = prefs.getString('name').toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      width: 255.0,
      child: Drawer(
        child: ListView(
          children: [
            //Drawer Header
            Container(
              height: 165,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.green, width: 1.5),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/icons/user.png",
                      height: 75,
                      width: 75,
                    ),
                    SizedBox(height: 16, width: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$_userName',
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.green,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          ' مرحبا',
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 6,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(
              height: 16,
            ),

            //Drawer Body
            ListTileDrawer(
              title: 'تعديل الملف الشخصي',
              IconData: Icons.person_sharp,
              widget: EditProfileScreen(),
            ),
            ListTileDrawer(
              title: 'استشاراتي',
              IconData: Icons.post_add,
              widget: YourAsks(),
            ),

            ListTileDrawer(
              title: 'اتصل بنا',
              IconData: Icons.call,
              widget: TapScreen(),
            ),
            ListTileDrawer(
              title: 'عن التطبيق',
              IconData: Icons.touch_app_sharp,
              widget: TapScreen(),
            ),
            ListTile(
              title: Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'تسجيل خروج',
                    style: textStyle,
                  )),
              trailing: Container(
                  margin: EdgeInsets.only(right: 15),
                  child: Icon(
                    Icons.power_settings_new,
                    color: Colors.grey,
                  )),
              onTap: () async {
                setState(() {
                  alertDialog("تسجيل خروج؟");
                });
                //
              },
            ),
          ],
        ),
      ),
    );
  }

  void alertDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          title: Container(
            child: Icon(
              Icons.error,
              color: Colors.redAccent,
              size: 60,
            ),
          ),
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Almarai",
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: RoundedButton(
                    buttonName: 'لا',
                    color: Colors.red,
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: RoundedButton(
                    buttonName: 'نعم',
                    color: Colors.green,
                    onPressed: () async {
                      final _auth = FirebaseAuth.instance;
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      setState(() {
                        prefs.remove("status");
                        prefs.remove("type");
                        prefs.remove("name");
                        prefs.remove('id');
                        _auth.signOut();

                        Navigator.pop(context);
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class ListTileDrawer extends StatelessWidget {
  static const textStyle = TextStyle(
    fontSize: 17,
    color: Colors.black,
    fontFamily: "Almarai",
  );

  final String title;
  final IconData;
  final Widget widget;
  ListTileDrawer({this.title, this.IconData, this.widget});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        textAlign: TextAlign.right,
        style: textStyle,
      ),
      trailing: Container(
          margin: EdgeInsets.only(right: 15),
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(20),
          //   border: Border.all(color: Colors.green, width: 1.5),
          // ),
          child: Icon(
            IconData,
            color: Colors.blue,
          )),
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => widget),
        );
      },
    );
  }
}
