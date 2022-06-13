import 'package:flutter/material.dart';

class ReusableCard extends StatefulWidget {
  ReusableCard(
      {@required this.colour, this.cardChild, this.onPress, this.text});
  // void selectCategory(BuildContext ctx) {
  //   Navigator.of(ctx).pushNamed();
  // }

  final Color colour;
  final String text;
  final Widget cardChild;
  final Function onPress;

  @override
  State<ReusableCard> createState() => _ReusableCardState();
}

class _ReusableCardState extends State<ReusableCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      //borderRadius: BorderRadius.circular(360),
      onTap: widget.onPress,
      child: Container(
        width: 95,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Column(
          children: [
            Expanded(flex: 2, child: widget.cardChild),
            SizedBox(height: 10),
            Expanded(
              child: Center(
                  child: Text(
                widget.text,
                style: TextStyle(color: Colors.black, fontSize: 17),
              )),
            ),
          ],
        ),
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: widget.colour,
          borderRadius: BorderRadius.circular(50.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
      ),
    );
  }
}
