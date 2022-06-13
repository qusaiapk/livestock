import 'package:flutter/material.dart';
import 'package:livestock/screens/responsive.dart';

class MainWidgets extends StatefulWidget {
  final String title;
  final String imagePath;
  final Widget widget;

  const MainWidgets({
    @required this.title,
    @required this.imagePath,
    @required this.widget,
  });

  @override
  State<MainWidgets> createState() => _MainWidgetsState();
}

class _MainWidgetsState extends State<MainWidgets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0077D3),
        //leading: Image.asset('assets/images/logo2.png'),
        centerTitle: true,
        title: Text(
          this.widget.title,
          textDirection: TextDirection.rtl,
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
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
            padding: EdgeInsets.all(50),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 23,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.blue[200],
                        child: Center(
                          child: IconButton(
                            icon: Icon(
                              Icons.home_outlined,
                              color: Colors.black54,
                              size: 25,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    ),
                    Image.asset(
                      widget.imagePath,
                      height: SizeConfig.screenHeight / 5,
                      fit: BoxFit.cover,
                    ),
                    CircleAvatar(
                      radius: 23,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.blue[200],
                        child: Center(
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black54,
                              size: 25,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                widget.widget,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
