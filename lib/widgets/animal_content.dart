import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:livestock/models/animal_model.dart';
import 'package:livestock/network/ApiServer.dart';

import 'package:livestock/screens/responsive.dart';
import 'package:livestock/widgets/select_card.dart';
import 'package:video_player/video_player.dart';

import 'chewie_item.dart';

class AnimalContent extends StatelessWidget {
  final String title;
  final String behv;

  const AnimalContent({@required this.title, this.behv});

  @override
  Widget build(BuildContext context) {
    //SizeConfig().init(context);
    return SafeArea(
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
                  flex: 8,
                  child: Center(
                    // child: Container(
                    //   margin: EdgeInsets.only(bottom: 5, left: 5, right: 5),
                    //   width: SizeConfig.screenWidth,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.only(
                    //       bottomLeft: Radius.circular(30),
                    //       bottomRight: Radius.circular(30),
                    //     ),
                    //     color: Colors.white24.withOpacity(0.7),
                    //     border: Border.all(
                    //       color: Colors.green[200],
                    //     ),
                    //   ),
                    child: FutureBuilder<List<AnimalModel>>(
                      future: ApiServer.getAnimalDet(name: title),
                      builder: (contex, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (contex, i) {
                                print(behv);

                                return behv ==
                                        snapshot.data[i].behavior.toString()
                                    ? Card(
                                        margin: EdgeInsets.all(5),
                                        color: Colors.white,
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 300,
                                              child: ChewieItem(
                                                videoPlayerController:
                                                    VideoPlayerController
                                                        .network(
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
                                      )
                                    : SizedBox();
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
                //),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
