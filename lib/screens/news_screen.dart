import 'package:flutter/material.dart';
import 'package:livestock/models/post_model.dart';
import 'package:livestock/network/ApiServer.dart';

import 'responsive.dart';

class NewsScreen extends StatefulWidget {
  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الاخــبــار'),
        centerTitle: true,
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
          Center(
            child: Container(
              padding: EdgeInsets.all(5),
              height: SizeConfig.screenHeight,
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: Center(
                child: FutureBuilder<List<PostModel>>(
                  future: ApiServer.getPosts(),
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
                                  Image.network(
                                      'http://qassimuni.com/myapp/public/images/news/${snapshot.data[i].photo}'),
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      snapshot.data[i].postBody.toString(),
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
                    return CircularProgressIndicator();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
