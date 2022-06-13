import 'package:flutter/material.dart';
import 'package:livestock/widgets/main_widget.dart';
import 'package:livestock/widgets/select_card.dart';
import 'package:livestock/widgets/animal_tab_bar.dart';

class AnimalScreen extends StatefulWidget {
  @override
  State<AnimalScreen> createState() => _AnimalScreenState();
}

class _AnimalScreenState extends State<AnimalScreen> {
  @override
  Widget build(BuildContext context) {
    return MainWidgets(
      title: 'الثروة الحيوانية',
      imagePath: "assets/images/cow.png",
      widget: Column(
        children: [
          SelectCard(
            from: 0,
            colour: Colors.white,
            cardChild: 'الابل',
            onPress: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnimalTabBar(
                      title: 'الابـــل',
                      jsonTitle: 'camel',
                    ),
                  ));
            },
          ),
          SelectCard(
            from: 0,
            colour: Colors.white,
            cardChild: 'البقر',
            onPress: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnimalTabBar(
                      title: 'البقر',
                      jsonTitle: 'cow',
                    ),
                  ));
            },
          ),
          SelectCard(
            from: 0,
            colour: Colors.white,
            cardChild: 'الماعز',
            onPress: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnimalTabBar(
                      title: 'الماعز',
                      jsonTitle: 'shep',
                    ),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
