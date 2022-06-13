import 'package:flutter/material.dart';

import '../screens/constants.dart';

class ReTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final bool obscureTxt;
  final TextInputType inputType;
  final TextEditingController controller;
  final Function valid;
  ReTextField(
      {@required this.hint,
      @required this.icon,
      this.obscureTxt,
      this.inputType,
      @required this.controller,
      @required this.valid});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
          Expanded(
            child: Icon(
              Icons.ac_unit,
              color: Colors.red,
              size: 15,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 30,
            child: Card(
              child: TextFormField(
                controller: controller,
                validator: valid,
                textInputAction: TextInputAction.next,
                obscureText: obscureTxt,
                keyboardType: inputType,
                textAlign: TextAlign.right,
                decoration: kTextFieldInputDecoration.copyWith(
                  hintText: hint,
                  // border: InputBorder.none,
                  prefixIcon: Material(
                    color: Colors.green[300],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                    ),
                    child: Icon(icon, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
