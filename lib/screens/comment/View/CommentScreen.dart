import 'dart:math';
import 'package:flutter/material.dart';
import 'package:livestock/models/commentF.dart';
import 'package:livestock/network/ApiServer.dart';
import 'package:livestock/screens/Utils/SizeConfig.dart';
import 'package:livestock/screens/comment/Widgets/CommentItem.dart';
import 'package:livestock/screens/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/Utils.dart';
import '../Model/Comment.dart';

class CommentScreen extends StatefulWidget {
  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  List<Comment> dataList = List<Comment>();

  final TextEditingController commentController = new TextEditingController();
  int inde;
  List commentsList = [];

  @override
  void initState() {
    super.initState();
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
    final arg = ModalRoute.of(context).settings.arguments as Map;
    setState(() {
      dataList = arg['data'];
      inde = arg['index'];
    });

    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('استشارة'),
        centerTitle: true,
        backgroundColor: Colors.green[300],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Divider(
              height: 30,
            ),
            Container(
                margin: EdgeInsets.only(top: 10, left: 10),
                child: renderComment(dataList)),
            Visibility(
              visible: true,
              child: Container(
                margin:
                    EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
                child: TextFormField(
                  textAlign: TextAlign.right,
                  controller: commentController,
                  cursorColor: Colors.black,
                  maxLines: 10,
                  minLines: 8,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: SizeConfig.safeBlockHorizontal * 6),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                      borderSide: new BorderSide(
                        color: Colors.black26,
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                      borderSide: new BorderSide(
                        color: Colors.black26,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 160),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, bottom: 10),
                    child: FlatButton(
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        dataList = [];
                        if (commentController.text.length > 0) {
                          await ApiServer.setComment(
                              answer: commentController.text,
                              doctorname: prefs.getString('name'),
                              ask_id: '${inde + 1}');
                          Comment comment = new Comment();
                          comment.id = Random(123).nextInt(543);
                          comment.setName = prefs.getString('name');
                          comment.setComment = commentController.text;
                          prefs.getString('type') == 'Doctor'
                              ? comment.setUserProfileImage =
                                  "assets/icons/doctor.png"
                              : comment.setUserProfileImage =
                                  "assets/icons/user.png";

                          List<CommentF> commlis = await ApiServer.getComment();
                          for (int i = 0; i < commlis.length; i++) {
                            Comment comment = new Comment();

                            comment.id = commlis[i].id;
                            comment.setName = commlis[i].askname;
                            comment.setComment = commlis[i].mesage;
                            prefs.getString('type') == 'Doctor'
                              ? comment.setUserProfileImage =
                                  "assets/icons/doctor.png"
                              : comment.setUserProfileImage =
                                  "assets/icons/user.png";
                            List<Comment> internalTemp = List<Comment>();

                            for (int j = 0;
                                j < commlis[i].funanswer.length;
                                j++) {
                              Comment comment = new Comment();
                              comment.id = commlis[i].funanswer[j].id;
                              comment.setName =
                                  commlis[i].funanswer[j].doctorname;
                              comment.setComment =
                                  commlis[i].funanswer[j].answer;
                              comment.setUserProfileImage =
                                  "assets/icons/doctor.png";
                              internalTemp.add(comment);
                            }

                            comment.internalComment = internalTemp;
                            dataList.add(comment);
                          }
                          setState(() {
                            List<Comment> datal = [];
                            datal.add(dataList[inde]);
                            Navigator.pushReplacementNamed(
                                context, RouteGenerator.commentScreen,
                                arguments: {'data': datal, 'index': inde});
                            commentController.clear();
                          });
                        } else {
                          Utils().showToast(" ادخل تعليق");
                        }
                      },
                      color: Colors.green[300],
                      padding: EdgeInsets.all(10),
                      child: Container(
                        width: 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Icon(
                              Icons.mode_edit,
                              color: Colors.white,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Text(
                                "اضافة تعليق",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal * 4.5),
                              ),
                            )
                          ],
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

  Widget renderComment(List<Comment> comments) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) => Divider(),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: comments.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            CommentItem(comment: comments[index], isInternal: false),
            comments[index].internalComment != null &&
                    comments[index].internalComment.length > 0
                ? renderInternalComment(
                    context, comments[index].internalComment)
                : Container()
          ],
        );
      },
    );
  }

  renderInternalComment(BuildContext context, List comments) {
    return Column(
        children: comments
            .map((comment) => CommentItem(comment: comment, isInternal: true))
            .toList());
  }
}
