import 'package:flutter/material.dart';
import 'package:livestock/screens/drawer/drawer_contral/drawer_provider.dart';
import 'package:provider/provider.dart';
import 'drawer/main_drawer.dart';
import 'home_screen.dart';
import 'news_screen.dart';

class TapScreen extends StatefulWidget {
  @override
  _TapScreenState createState() => _TapScreenState();
}

class _TapScreenState extends State<TapScreen> {
  final List<Map<String, Object>> _pages = [
    {
      'page': HomeScreen(),
    },
    {
      'page': NewsScreen(),
    },
  ];
  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider<DrawerProvider>(create: (context)=>DrawerProvider(), child: Scaffold(
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          //  backgroundColor: Colors.green[300],
          //unselectedItemColor: Colors.green,
          selectedItemColor: Colors.green,
          currentIndex: _selectedPageIndex,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Colors.amber,
              icon: Icon(Icons.home),
              label: 'الرئسية',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.black12,
              icon: Icon(Icons.create_new_folder),
              label: 'الاخبار',
            ),
          ]),
    ));
  }
}
