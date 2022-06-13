import 'package:flutter/material.dart';

import 'animal_content.dart';

class AnimalTabBar extends StatelessWidget {
  final String title;
  final String jsonTitle;
  AnimalTabBar({@required this.title, @required this.jsonTitle});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[300],
          //leading: Image.asset('assets/images/logo2.png'),
          centerTitle: true,
          title: Text(
            title,
            style: TextStyle(fontSize: 25),
          ),
          bottom: TabBar(
            labelStyle: TextStyle(fontSize: 20),
            // indicatorPadding: EdgeInsets.only(bottom: 50),
            // padding: EdgeInsets.only(bottom: 50),
            indicator: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
            tabs: [
              Tab(
                text: 'التناسل ',
              ),
              Tab(
                text: 'الامراض',
              ),
              Tab(
                text: 'الولادات',
              ),
              Tab(
                text: 'السلالات',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AnimalContent(
              title: jsonTitle,
              behv: 'tnasl',
            ),
            AnimalContent(
              title: jsonTitle,
              behv: 'marad',
            ),
            AnimalContent(
              title: jsonTitle,
              behv: 'wlad',
            ),
            AnimalContent(
              title: jsonTitle,
              behv: 'slalat',
            ),
          ],
        ),
      ),
    );
  }
}
