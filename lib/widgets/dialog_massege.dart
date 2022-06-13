import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:livestock/screens/tab_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ProgressDialog.dart';
import 'rounded_button.dart';

class DialogMassege {

  static void showSuccess(BuildContext context, String message) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => ProgressDialog(
              status: 'Logging...',
            ));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
            child: Icon(
              Icons.verified_user,
              color: Colors.green,
              size: 60,
            ),
          ),
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Almarai",
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: ButtonStyle(),
              child: const Text("OK"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TapScreen()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  static void showSnackBar(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15, fontFamily: "Almarai"),
        ),
      ),
    );
  }

  static void alertDialog(BuildContext cont, String message) {
    showDialog(
      context: cont,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          title: Container(
            child: Icon(
              Icons.error,
              color: Colors.redAccent,
              size: 60,
            ),
          ),
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Almarai",
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: RoundedButton(
                    buttonName: 'لا',
                    color: Colors.red,
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: RoundedButton(

                    buttonName: 'نعم',
                    color: Colors.green,
                    onPressed: () async {
                      
                        final _auth = FirebaseAuth.instance;
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.remove("status");
                      prefs.remove("type");
                      prefs.remove("name");
                        _auth.signOut();
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
