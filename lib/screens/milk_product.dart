import 'package:flutter/material.dart';
import 'package:livestock/widgets/main_widget.dart';
import 'package:livestock/widgets/milk_content.dart';
import 'package:livestock/widgets/select_card.dart';

class MilkProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainWidgets(
      title: 'المنتجات الصناعية ',
      imagePath: "assets/images/milk.png",
      widget: Column(
        children: [
          SelectCard(
            from: 0,
            colour: Colors.white,
            cardChild: 'الجبنة',
            onPress: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MilkContent(
                      title: 'الجبنة',
                      catogre: 'chess',
                    ),
                  ));
            },
          ),
          SelectCard(
            from: 0,
            colour: Colors.white,
            cardChild: 'الزبدة',
            onPress: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MilkContent(
                      title: 'الزبدة',
                      catogre: 'butter',
                    ),
                  ));
            },
          ),
          SelectCard(
            from: 0,
            colour: Colors.white,
            cardChild: 'السمنة',
            onPress: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MilkContent(
                      title: 'السمنة',
                      catogre: 'fatness',
                    ),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
