import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:livestock/screens/tab_screen.dart';

import 'Utils/SizeConfig.dart';

class Splashscren extends StatefulWidget {
  @override
  _SplashscrenState createState() => _SplashscrenState();
}

class _SplashscrenState extends State<Splashscren> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/cow.png',
            width: 90,
            height: 90,
          ),
          TextLiquidFill(
            text: 'Livestock',
            waveColor: Colors.green,
            boxBackgroundColor: Colors.white,
            textStyle: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
            boxHeight: 60.0,
          ),
        ],
      ),
    ));
  }

  @override
  void initState() {
    splashWait();
    super.initState();
  }

  void splashWait() {
    Future.delayed(Duration(seconds: 7)).then((onValue) {
      Navigator.of(context).pushAndRemoveUntil(
          new MaterialPageRoute(builder: (BuildContext context) {
        return TapScreen();
      }), (Route<dynamic> route) => false);
    });
  }
}
