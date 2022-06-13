
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:livestock/screens/tab_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/rounded_button.dart';

class MainDrawer extends StatefulWidget {
  @override
  _mainDrawer createState() => _mainDrawer();
}

class _mainDrawer extends State<MainDrawer> {
  var textStyle = TextStyle(
    fontSize: 17,
    color: Colors.black,
    fontFamily: "Almarai",
  );
  String _userName = "";
  String _email = "";

  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();

    loadedLocalSaveData();
  }

  loadedLocalSaveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString("username");
      _email = prefs.getString("email");
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
                      "assets/images/cow.png",
                      height: 75,
                      width: 75,
                    ),
                    SizedBox(height: 16, width: 16),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'الاصدار 1.0',
                          style: TextStyle(fontSize: 16, fontFamily: "Almarai"),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        // Text("Visit Profile" ,),
                      ],
                    )
                  ],
                ),
              ),
            ),

            SizedBox(
              height: 16,
            ),

            //Drawer Body

            ListTileDrawer(
              title: 'اتصل بنا',
              IconData: Icons.call,
              widget: TapScreen(),
            ),
            ListTileDrawer(
              title: 'عن التطبيق',
              IconData: Icons.person_sharp,
              widget: TapScreen(),
            ),
            ListTile(
              title: Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "خروج من التطبيق",
                    style: textStyle,
                  )),
              trailing: Container(
                  margin: EdgeInsets.only(right: 15),
                  child: Icon(
                    Icons.power_settings_new,
                    color: Colors.grey,
                  )),
              onTap: () async {
                //
                showSuccess("خروج من التطبيق");
              },
            ),
          ],
        ),
      ),
    );
  }

  void showSuccess(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
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
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: RoundedButton(
                    color: Colors.red,
                    buttonName: "لا",
                    onPressed: () async {
                      Navigator.of(context).pop();
                      // Only works on Android.
                    },
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: RoundedButton(
                    color: Colors.green,
                    buttonName: "نعم",
                    onPressed: () {
                      SystemNavigator.pop();

                      // Only works on Android.
                    },
                  ),
                ),
              ],
            )
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
