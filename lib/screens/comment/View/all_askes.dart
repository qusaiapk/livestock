import 'dart:math';

import 'package:flutter/material.dart';

import 'package:livestock/models/commentF.dart';
import 'package:livestock/network/ApiServer.dart';
import 'package:livestock/screens/routes.dart';

import '../../Utils/SizeConfig.dart';
import '../Model/Comment.dart';
import '../Widgets/CommentItem.dart';

class AllAskes extends StatefulWidget {
  @override
  State<AllAskes> createState() => _AllAskesState();
}

class _AllAskesState extends State<AllAskes> {
  List<Comment> dataList = List<Comment>();
  final TextEditingController commentController = new TextEditingController();

  List commentsList = [
    
  ];

  @override
  void initState() {
    super.initState();

    importData(commentsList);
  }

  void importData(List commentsList) async {
    List<CommentF> commlis = await ApiServer.getComment();
    for (int i = 0; i < commlis.length; i++) {
      Comment comment = new Comment();

      comment.id = commlis[i].id;
      comment.setName = commlis[i].askname;
      comment.setComment = commlis[i].mesage;
      comment.setUserProfileImage = "assets/icons/user.png";
      List<Comment> internalTemp = List<Comment>();

      for (int j = 0; j < commlis[i].funanswer.length; j++) {
        Comment comment = new Comment();
        comment.id = commlis[i].funanswer[j].id;
        comment.setName = commlis[i].funanswer[j].doctorname;
        comment.setComment = commlis[i].funanswer[j].answer;
        comment.setUserProfileImage = "assets/icons/doctor.png";
        internalTemp.add(comment);
      }

      comment.internalComment = internalTemp;
      setState(() {
        dataList.add(comment);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("استشارة"),
        centerTitle: true,
        backgroundColor: Colors.green[300],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 10, left: 10),
                child: renderComment(dataList)),
          ],
        ),
      ),
    );
  }

  Widget renderComment(List<Comment> comments) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) => Divider(
        color: Colors.amber,
        thickness: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: comments.length,
      itemBuilder: (context, index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      List<Comment> datal = [];
                      datal.add(dataList[index]);
                      Navigator.pushNamed(context, RouteGenerator.commentScreen,
                          arguments: {'data': datal, 'index': index});
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommentItem(comment: comments[index], isInternal: false),
                    ],
                  )),
            ),
          ],
        );
      },
    );
  }
}
