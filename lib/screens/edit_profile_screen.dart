import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:livestock/network/ApiServer.dart';
import 'package:livestock/screens/routes.dart';
import 'package:livestock/widgets/dialog_massege.dart';
import 'package:livestock/widgets/main_widget.dart';
import 'package:livestock/widgets/re_text_field.dart';
import 'package:livestock/widgets/select_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/rounded_button.dart';
import 'Utils/SizeConfig.dart';


class EditProfileScreen extends StatefulWidget {
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String _userName = "";
  String _id="";
  loadedLocalSaveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      print(prefs.getString('id').toString());
      _id=prefs.getString('id');
      _userName = prefs.getString('name').toString();

    });
  }

  String email;
  String password;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    loadedLocalSaveData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                        'تعديل الملف الشخصي',
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
                    child: Scrollbar(
                      interactive: true,
                      child: SingleChildScrollView(
                        //physics: NeverScrollableScrollPhysics(),
                        child: Container(
                          width: SizeConfig.screenWidth,
                          height: (SizeConfig.screenHeight / 2) + 250,
                          decoration: BoxDecoration(
                            color: Colors.white30,
                            border: Border.all(
                              color: Colors.green[200],
                            ),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 6,
                              ),
                              Form(
                                key: _formKey,
                                //autovalidateMode: AutovalidateMode.always,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 6,
                                    ),
                                    CircleAvatar(
                                        radius: 35,
                                        backgroundColor: Colors.white,
                                        child: Image.asset(
                                          "assets/icons/user.png",
                                        )),
                                    Text(
                                      '$_userName',
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 6,
                                    ),
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
                                    RoundedButton(
                                      buttonName: 'حفظ',
                                      color: Colors.green[300],
                                      onPressed: () async {
                                      
                                           if (_formKey.currentState.validate()) {
                                          Map shared =
                                              await ApiServer.updateUser(
                                          id: _id,
                                            phone: _phoneController.text
                                                .toString(),
                                           
                                            name:
                                                _nameController.text.toString(),
                                          );

                                          if (shared.isEmpty) {
                                            DialogMassege.showSnackBar(
                                                context, shared.toString());
                                          } else {
                                            
                                            Navigator.pushReplacementNamed(
                                                context, RouteGenerator.tap_screen);
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
