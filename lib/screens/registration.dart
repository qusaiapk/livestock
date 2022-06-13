import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:livestock/network/ApiServer.dart';
import 'package:livestock/screens/responsive.dart';
import 'package:livestock/screens/routes.dart';
import 'package:livestock/widgets/dialog_massege.dart';
import 'package:livestock/widgets/re_text_field.dart';
import 'package:livestock/widgets/rounded_button.dart';


class RegistratonScreen extends StatefulWidget {
  @override
  State<RegistratonScreen> createState() => _RegistratonScreen();
}

class _RegistratonScreen extends State<RegistratonScreen> {
  final List<String> states = [
    'نهر النيل',
    'الشمالية',
    'الجزيرة',
  ];

  final _auth = FirebaseAuth.instance;
  String selectedValue = '';
  String email;
  String password;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    final fromWhere = ModalRoute.of(context).settings.arguments.toString();
    if (fromWhere != null) print('fromWher=${fromWhere}');
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   title: Text('login'),
      // ),
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
            padding: EdgeInsets.symmetric(
                horizontal: 20, vertical: SizeConfig.screenHeight / 10),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
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
                        'تــسجيــــل',
                        style: TextStyle(fontSize: 30, color: Colors.green),
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
                Expanded(
                  child: Center(
                    child: Scrollbar(
                      interactive: true,
                      child: SingleChildScrollView(
                        //physics: NeverScrollableScrollPhysics(),
                        child: Container(
                          width: SizeConfig.screenWidth,
                          height: (SizeConfig.screenHeight / 2) + 250,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.6),
                            border: Border.all(
                              color: Colors.green[200],
                            ),
                          ),
                          child: Column(
                            children: [
                              Form(
                                key: _formKey,
                                //autovalidateMode: AutovalidateMode.always,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ReTextField(
                                      controller: _phoneController,
                                      hint: 'رقم الهاتف',
                                      icon: Icons.phone,
                                      obscureTxt: false,
                                      inputType: TextInputType.number,
                                      valid: (phone) {
                                        if (phone.isEmpty) {
                                          return 'رقم الهاتف غير صحيح';
                                        }
                                        return null;
                                      },
                                    ),
                                    ReTextField(
                                      controller: _passwordController,
                                      hint: 'كلمة السر',
                                      icon: Icons.lock_clock_outlined,
                                      obscureTxt: true,
                                      valid: (name) {
                                        if (name.isEmpty ||
                                            name.toString().length < 6) {
                                          return 'كلمة السر قصيرة';
                                        }
                                        return null;
                                      },
                                    ),
                                    ReTextField(
                                      controller: _nameController,
                                      hint: 'الاسم',
                                      icon: Icons.person_add_alt_1_rounded,
                                      obscureTxt: false,
                                      valid: (name) {
                                        if (name.isEmpty) {
                                          return 'الاسم غير صحيح';
                                        }
                                        return null;
                                      },
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 20),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.ac_unit,
                                            color: Colors.red,
                                            size: 15,
                                          ),
                                          SizedBox(width: 10),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            width: 250,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                DropdownButtonFormField2(
                                                  decoration: InputDecoration(
                                                    //Add isDense true and zero Padding.
                                                    //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                                    isDense: true,
                                                    contentPadding:
                                                        EdgeInsets.all(-5),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    //Add more decoration as you want here
                                                    //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                                  ),
                                                  isExpanded: true,
                                                  hint: const Text(
                                                    'الولاية',
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                  ),
                                                  icon: const Icon(
                                                    Icons.arrow_drop_down,
                                                    color: Colors.black45,
                                                  ),
                                                  iconSize: 30,
                                                  buttonHeight: 60,
                                                  buttonPadding:
                                                      const EdgeInsets.only(
                                                          left: 20, right: 10),
                                                  dropdownDecoration:
                                                      BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  items: states
                                                      .map((item) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                            value: item,
                                                            child: Text(
                                                              item,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ))
                                                      .toList(),
                                                  validator: (value) {
                                                    if (value == null) {
                                                      return 'اختر الولاية.';
                                                    }
                                                  },
                                                  onChanged: (value) {
                                                    setState(() {
                                                      selectedValue =
                                                          value.toString();
                                                    });
                                                    //Do something when changing the item if you want.
                                                  },
                                                  onSaved: (value) {},
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    // ReTextField(
                                    //   controller: _stateController,
                                    //   hint: 'الولاية',
                                    //   icon: Icons.phone,
                                    //   obscureTxt: false,
                                    //   valid: (stat) {
                                    //     if (stat.isEmpty) {
                                    //       return 'الولاية';
                                    //     }
                                    //     return null;
                                    //   },
                                    // ),
                                    RoundedButton(
                                      buttonName: 'تسجيل',
                                      color: Colors.green[300],
                                      onPressed: () async {
                                        if (_formKey.currentState.validate()) {
                                          String status =
                                              await ApiServer.register(
                                            phone: _phoneController.text
                                                .toString(),
                                            password: _passwordController.text
                                                .toString(),
                                            name:
                                                _nameController.text.toString(),
                                            state: selectedValue,
                                          );

                                          if (status.isEmpty ||
                                              status.length > 10) {
                                            DialogMassege.showSnackBar(
                                                context, status.toString());
                                          } else {
                                            try {
                                              final newUser = await _auth
                                                  .createUserWithEmailAndPassword(
                                                email:
                                                    '${_nameController.text.toString()}@gmail.com',
                                                password: _passwordController
                                                    .text
                                                    .toString(),
                                              );
                                            } catch (e) {
                                              print(e);
                                            }
                                            Navigator.pushReplacementNamed(
                                                context, RouteGenerator.login,
                                                arguments: fromWhere);
                                          }
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
