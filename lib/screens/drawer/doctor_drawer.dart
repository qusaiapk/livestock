import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:livestock/screens/tab_screen.dart';
import 'package:livestock/widgets/dialog_massege.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorDrawer extends StatefulWidget {
  @override
  _DoctorDrawer createState() => _DoctorDrawer();
}

class _DoctorDrawer extends State<DoctorDrawer> {
  final _auth = FirebaseAuth.instance;

  var textStyle = TextStyle(
    fontSize: 17,
    color: Colors.black,
    fontFamily: "Almarai",
  );
  String _userName = "";

  @override
  initState() {
    loadedLocalSaveData();
    super.initState();
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
                      "assets/icons/doctor.png",
                      height: 75,
                      width: 75,
                    ),
                    SizedBox(height: 16, width: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('$_userName',
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.green,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          '.مرحبا د',
                          style: TextStyle(fontSize: 17, color: Colors.black),
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
              title: 'الملف الشخصي',
              IconData: Icons.person_sharp,
              widget: TapScreen(),
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
                  DialogMassege.alertDialog(context, "تسجيل خروج؟");
                });
                //
              },
            ),
          ],
        ),
      ),
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
