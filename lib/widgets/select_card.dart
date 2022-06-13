import 'package:flutter/material.dart';
import 'package:livestock/screens/responsive.dart';

class SelectCard extends StatelessWidget {
  SelectCard({@required this.colour, this.cardChild, this.onPress, this.from});

  final Color colour;
  final String cardChild;
  final Function onPress;
  int from = 0;

  @override
  Widget build(BuildContext context) {
    return from == 0
        ? GestureDetector(
            onTap: onPress,
            child: Container(
              margin: EdgeInsets.only(top: 40),
              width: SizeConfig.screenWidth / 1.5,
              height: 60,
              child: Center(
                child: Text(
                  cardChild,
                  style: TextStyle(fontSize: 30, color: Colors.lightBlue[900]),
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.grey[350],
                  borderRadius: BorderRadius.circular(30.0),
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ]),
            ),
          )
        : GestureDetector(
            onTap: onPress,
            child: Container(
              margin: EdgeInsets.only(top: 40),
              width: 300,
              height: 50,
              child: Center(
                child: Text(
                  cardChild,
                  style: TextStyle(fontSize: 20, color: Colors.lightBlue[900]),
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.green[200],
                  borderRadius: BorderRadius.circular(30.0),
                  border: Border.all(color: Colors.white, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ]),
            ),
          );
  }
}
