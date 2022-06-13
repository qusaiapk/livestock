
import 'package:flutter/material.dart';
import 'package:livestock/models/commentF.dart';
import 'package:livestock/network/ApiServer.dart';
import 'package:livestock/screens/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Utils/SizeConfig.dart';
import '../../Utils/Utils.dart';
import '../Model/Comment.dart';
import '../Widgets/CommentItem.dart';

class AddComment extends StatefulWidget {
  @override
  State<AddComment> createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {
  List<Comment> datalistForAddComment = List<Comment>();
  final TextEditingController commentController = new TextEditingController();

  List commentsList = [];
  List<Comment> data = List<Comment>();

  @override
  void initState() {
    super.initState();

    importData(commentsList);
  }

  Future<void> importData(List commentsList) async {
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
        datalistForAddComment.add(comment);
        data.add(comment);
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
            // Padding(
            //     padding: const EdgeInsets.only(left: 10.0, top: 10),
            //     child: Text(
            //       "Comments",
            //       style: TextStyle(
            //           color: Utils.black,
            //           fontSize: SizeConfig.safeBlockHorizontal * 7,
            //           fontWeight: FontWeight.bold),
            //     )),
            Divider(
              height: 30,
            ),
            Container(
                margin: EdgeInsets.only(top: 10, left: 10),
                child: renderComment(data)),
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
                        if (commentController.text.length > 0) {
                          await ApiServer.AddComment(
                              name: prefs.getString('name'),
                              mesage: commentController.text.toString());
                          Comment comment = new Comment();
                          ;
                          comment.setUserProfileImage = "assets/icons/user.png";

                          setState(() {
                            Navigator.pushReplacementNamed(
                                context, RouteGenerator.add_comment);

                            commentController.clear();
                          });
                        } else {
                          Utils().showToast("ارجوك ادخل تعليق");
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
                                "اضافة استشارة",
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      List<Comment> datal = [];
                      datal.add(datalistForAddComment[index]);
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
//            commentItem(context, comments[index], false),
          ],
        );
      },
    );
  }
}
