import 'package:flutter/material.dart';
import 'package:livestock/screens/drawer/drawer_contral/drawer_provider.dart';
import 'package:livestock/screens/drawer/main_drawer.dart';
import 'package:livestock/screens/routes.dart';
import 'package:livestock/screens/drawer/user_drawer.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/reusble_card.dart';
import 'drawer/doctor_drawer.dart';
import 'responsive.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  String status;
  String type;

  @override
  initState() {
    loadedLocalSaveData();
    super.initState();
  }

  loadedLocalSaveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      status = prefs.getString('status').toString();
      type = prefs.getString('type').toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    //var mydrawer = DrawerProvider();
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff0079d4),
          // leading: Image.asset('assets/images/logo2.png'),
          title: Text('Livestock')),
      endDrawer: Consumer<DrawerProvider>(
        builder: (context, mydrawer, child) {
          mydrawer.typeChanger();
          Widget dra = MainDrawer();
          if (mydrawer.type == 'Doctor') {
            dra = DoctorDrawer();
          } else if (mydrawer.type == 'Benificary') {
            dra = UserDrawer();
          }
          return dra;
        },
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/back1.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 15),
            height: SizeConfig.screenHeight,
            child: Column(
              children: [
                Container(
                  child: Text(
                    'دليل الارشاد الحيواني   ',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
                Center(
                  child: Container(
                    width: SizeConfig.screenWidth,
                    height: (SizeConfig.screenHeight - 265),
                    margin: EdgeInsets.all((SizeConfig.screenWidth / 200) * 10),
                    // decoration: BoxDecoration(
                    //   color: Colors.white.withOpacity(0.5),
                    //   borderRadius: BorderRadius.circular(15.0),
                    // ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: ReusableCard(
                                  colour: Colors.blue[100],
                                  text: 'المنتجات الصناعية',
                                  cardChild: Image.asset(
                                    'assets/images/milk.png',
                                  ),
                                  onPress: () {
                                    Navigator.pushNamed(
                                        context, RouteGenerator.milkProduct);
                                  },
                                ),
                              ),
                              Expanded(
                                child: ReusableCard(
                                  colour: Colors.blue[100],
                                  text: 'الثروة الحيوانية',
                                  cardChild:
                                      Image.asset('assets/images/cow.png'),
                                  onPress: () {
                                    Navigator.pushNamed(
                                        context, RouteGenerator.animalScreen);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: ReusableCard(
                                  colour: Colors.blue[100],
                                  text: 'المنتدي',
                                  cardChild:
                                      Image.asset('assets/images/gloves.png'),
                                  onPress: () async {
                                    await loadedLocalSaveData();
                                    status != 'null'
                                        ? Navigator.pushNamed(
                                            context,
                                            RouteGenerator.chat,
                                          )
                                        : Navigator.pushNamed(
                                            context, RouteGenerator.login,
                                            arguments: 'chat');
                                  },
                                ),
                              ),
                              Expanded(
                                child: ReusableCard(
                                  colour: Colors.blue[100],
                                  text: 'استشارة',
                                  cardChild:
                                      Image.asset('assets/images/farmer.png'),
                                  onPress: () async {
                                    await loadedLocalSaveData();
                                    print(status);

                                   if(type=='Doctor'){Navigator.pushNamed(
                                            context,
                                            RouteGenerator.all_askes,
                                          );}else if(type=='Benificary'){Navigator.pushNamed(
                                            context,
                                            RouteGenerator.add_comment,
                                          );}else
                                       Navigator.pushNamed(
                                            context, RouteGenerator.login,
                                            arguments: 'ask');
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
