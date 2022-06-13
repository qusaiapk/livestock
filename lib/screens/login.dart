
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import 'package:livestock/network/ApiServer.dart';

import 'package:livestock/screens/responsive.dart';
import 'package:livestock/screens/routes.dart';

import 'package:livestock/widgets/dialog_massege.dart';
import 'package:livestock/widgets/re_text_field.dart';
import 'package:livestock/widgets/rounded_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
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
              padding: EdgeInsets.symmetric(
                  horizontal: 20, vertical: SizeConfig.screenHeight / 10),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
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
                          'تسجيل الدخول',
                          style: TextStyle(fontSize: 20, color: Colors.green),
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
                      child: SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        child: Container(
                          width: SizeConfig.screenWidth,
                          height: (SizeConfig.screenHeight / 2) + 100,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.6),
                            border: Border.all(
                              color: Colors.green[200],
                            ),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    ReTextField(
                                      controller: _phoneController,
                                      hint: 'رقم الهاتف',
                                      icon: Icons.phone,
                                      obscureTxt: false,
                                      inputType: TextInputType.phone,
                                      valid: (phone) {
                                        if (phone.isEmpty) {
                                          return 'ادخل رقم الهاتف';
                                        }
                                        return null;
                                      },
                                    ),
                                    ReTextField(
                                      controller: _passwordController,
                                      hint: 'كلمة السر',
                                      icon: Icons.lock_clock_outlined,
                                      obscureTxt: true,
                                      valid: (pass) {
                                        if (pass.isEmpty) {
                                          return 'ادخل كلمة السر';
                                        }
                                        return null;
                                      },
                                    ),
                                    RoundedButton(
                                      buttonName: 'دخـــول',
                                      color: Colors.green[300],
                                      onPressed: () async {
                                        _auth.signOut();
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        if (_formKey.currentState.validate()) {
                                          Map shared = await ApiServer.login(
                                            phone: _phoneController.text
                                                .toString(),
                                            password: _passwordController.text
                                                .toString(),
                                          );
                                          if (shared.isEmpty) {
                                            DialogMassege.showSnackBar(context,
                                                'رقم الهاتف او كلمة المرور خطا');
                                          } else {
                                            print(shared['status']);
                                            print(shared['type']);
                                            print(shared['name']);
                                            print(shared['password']);

                                            setState(() {
                                              showSpinner = true;
                                            });
                                            if (prefs.getString('type') !=
                                                'Benificary') {
                                              try {
                                                final newUser = await _auth
                                                    .createUserWithEmailAndPassword(
                                                  email:
                                                      '/د${prefs.getString('name').toString()}@gmail.com',
                                                  password: _passwordController
                                                      .text
                                                      .toString(),
                                                );
                                                if (newUser != null) {
                                                  Navigator
                                                      .pushReplacementNamed(
                                                          context,
                                                          RouteGenerator.chat);
                                                }
                                              } catch (e) {
                                                print(e);
                                              }
                                              try {
                                                final user = await _auth
                                                    .signInWithEmailAndPassword(
                                                        email:
                                                            '${prefs.getString('name').toString()}@gmail.com',
                                                        password:
                                                            _passwordController
                                                                .text
                                                                .toString());

                                                if (user != null) {
                                                  Navigator.pushNamed(
                                                    context,
                                                    RouteGenerator.ask,
                                                  );
                                                }

                                                setState(() {
                                                  showSpinner = false;
                                                });
                                              } catch (e) {
                                                print(e);
                                              }
                                            } else {
                                              try {
                                                final user = await _auth
                                                    .signInWithEmailAndPassword(
                                                        email:
                                                            '${prefs.getString('name').toString()}@gmail.com',
                                                        password:
                                                            _passwordController
                                                                .text
                                                                .toString());

                                                if (user != null) {
                                                  Navigator
                                                      .pushReplacementNamed(
                                                    context,
                                                    RouteGenerator.chat,
                                                  );
                                                }

                                                setState(() {
                                                  showSpinner = false;
                                                });
                                              } catch (e) {
                                                print(e);
                                              }
                                            }

                                            if (fromWhere == 'chat') {
                                              Navigator.pushReplacementNamed(
                                                  context, RouteGenerator.chat);
                                            } else if (fromWhere.toString() ==
                                                'ask') {
                                              if (prefs.getString('type') !=
                                                  null) {
                                                prefs.getString('type') ==
                                                        'Doctor'
                                                    ? Navigator
                                                        .pushReplacementNamed(
                                                            context,
                                                            RouteGenerator
                                                                .all_askes)
                                                    : Navigator
                                                        .pushReplacementNamed(
                                                            context,
                                                            RouteGenerator
                                                                .add_comment);
                                              } else
                                                Navigator.pushReplacementNamed(
                                                    context,
                                                    RouteGenerator.login);
                                            }
                                          }
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    Divider(
                                      color: Colors.white,
                                      thickness: 1,
                                      height: 0,
                                    ),
                                    MaterialButton(
                                      onPressed: () {
                                        Navigator.pushReplacementNamed(context,
                                            RouteGenerator.registration,
                                            arguments: fromWhere);
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            right: 30, left: 30),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'ليس لديك حساب',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              '   تسجيل',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.green),
                                            ),
                                          ],
                                        ),
                                      ),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
