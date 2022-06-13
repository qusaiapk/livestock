import 'package:flutter/material.dart';
import 'package:livestock/models/milk_model.dart';
import 'package:livestock/network/ApiServer.dart';
import 'package:livestock/screens/responsive.dart';
import 'package:video_player/video_player.dart';

import 'chewie_item.dart';

class MilkContent extends StatelessWidget {
  final String title;
  final String catogre;

  const MilkContent({@required this.title, @required this.catogre});

  @override
  Widget build(BuildContext context) {
    //SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
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
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.green[300],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.home_outlined,
                              color: Colors.black,
                              size: 30,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Text(
                            title,
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                              size: 30,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 5, left: 5, right: 5),
                        width: SizeConfig.screenWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          color: Colors.white24.withOpacity(0.7),
                          border: Border.all(
                            color: Colors.green[200],
                          ),
                        ),
                        child: FutureBuilder<List<MilkModel>>(
                          future: ApiServer.getMilkProduct(catogre: catogre),
                          builder: (contex, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (contex, i) {
                                    return Card(
                                      margin: EdgeInsets.all(5),
                                      color: Colors.white,
                                      child: Column(
                                        
                                        children: [
                                      
                                          Container(
                                            height: 300,
                                            child: ChewieItem(
                                              videoPlayerController:
                                                  VideoPlayerController.network(
                                                'http://qassimuni.com/myapp/public/images/videoss/${snapshot.data[i].video}',
                                              ),
                                              looping: true,
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(5),
                                            child: Text(
                                              snapshot.data[i].description,
                                              style: TextStyle(fontSize: 20),
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            } else if (snapshot.hasError) {
                              print(snapshot.error);
                              return Text('${snapshot.error}');
                            }
                            return Center(child: CircularProgressIndicator());
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
