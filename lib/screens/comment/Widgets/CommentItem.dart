import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/SizeConfig.dart';
import '../../Utils/Utils.dart';
import '../Model/Comment.dart';

class CommentItem extends StatefulWidget {
  final Comment comment;

  final isInternal;

  @override
  _CommentItemState createState() => _CommentItemState();

  CommentItem({this.comment, this.isInternal});
}

class _CommentItemState extends State<CommentItem> {
  String type = "";
  loadedLocalSaveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      print(prefs.getString('name').toString());
      type = prefs.getString('type').toString();
      print(type);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadedLocalSaveData();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      margin: widget.isInternal
          ? EdgeInsets.only(right: 40, top: 10, bottom: 10)
          : EdgeInsets.only(left: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: RichText(
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: widget.comment.name,
                      style: TextStyle(
                          fontSize: SizeConfig.safeBlockHorizontal * 4.5,
                          fontWeight: FontWeight.bold,
                          color: Utils.black),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5, left: 10, bottom: 5),
                  child: RichText(
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      text: widget.comment.comment,
                      style: TextStyle(
                          fontSize: SizeConfig.safeBlockHorizontal * 5.0,
                          color: Utils.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Image.asset(
          widget.comment.userProfileImage,
            width: SizeConfig.safeBlockHorizontal * 16,
            height: SizeConfig.safeBlockHorizontal * 16,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
