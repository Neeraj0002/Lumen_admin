import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lumin_admin/API_Functions/Authentication/loginAPI.dart';
import 'package:lumin_admin/API_Functions/Authentication/signUpAPI.dart';
import 'package:lumin_admin/Components/appBar.dart';
import 'package:lumin_admin/Components/buttons.dart';
import 'package:lumin_admin/Components/textBox.dart';
import 'package:lumin_admin/Essentials/colors.dart';
import 'package:lumin_admin/Screens/Dashboard.dart';
import 'package:lumin_admin/services/auth.dart';
import 'package:lumin_admin/services/database.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController usernameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController cPasswordController = TextEditingController();

  TextEditingController phoneController = TextEditingController();
  bool goToRegister = false;

  LearneeAppBar appbar = LearneeAppBar();

  AuthService authService = new AuthService();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  Future singUpFirebase(String name) async {
    String status = "fail";
    await authService
        .signUpWithEmailAndPassword(
            usernameController.text, passwordController.text)
        .then((result) async {
      if (result != null) {
        status = "success";
        Map<String, String> userDataMap = {
          'nickname': "$name",
          'email': usernameController.text,
          'id': result.uid,
          'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
          'chattingWith': null
        };

        await databaseMethods
            .addUserInfo(userDataMap, result.uid)
            .then((value) => status = "success");
      }
    });
    return status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: appbar.loginScreenAppBar(context: context),
      body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: SafeArea(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 2,
                            blurRadius: 4)
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
                          child: Text(
                            "Register",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                          child: Text(
                            "Start learning and teaching",
                            style: TextStyle(
                              color: Colors.grey,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        LearneeTextField(
                            hint: "Your name",
                            label: "Name",
                            icon: MdiIcons.key,
                            hideText: false,
                            textController: nameController),
                        LearneeTextField(
                            hint: "Your email address",
                            label: "Email Address",
                            icon: Icons.email,
                            hideText: false,
                            textController: usernameController),
                        LearneeTextField(
                            hint: "Your mobile number",
                            label: "Phone",
                            maxStringLength: 10,
                            icon: Icons.phone,
                            hideText: false,
                            textController: phoneController),
                        LearneeTextField(
                            hint: "Your password",
                            label: "Password",
                            icon: MdiIcons.key,
                            hideText: true,
                            textController: passwordController),
                        LearneeTextField(
                            hint: "Retype your password",
                            label: "Retype Password",
                            icon: MdiIcons.key,
                            hideText: true,
                            textController: cPasswordController),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                          child: LearneeRegLogButton(
                              action: () {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    child: AlertDialog(
                                      content: Container(
                                        height: 80,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: Container(
                                                height: 30,
                                                width: 30,
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ));

                                if (passwordController.text.length >= 8) {
                                  if (nameController.text.isNotEmpty &&
                                      usernameController.text.isNotEmpty &&
                                      phoneController.text.isNotEmpty &&
                                      phoneController.text.isNotEmpty &&
                                      passwordController.text.isNotEmpty &&
                                      cPasswordController.text.isNotEmpty) {
                                    if (cPasswordController.text ==
                                        passwordController.text) {
                                      Map<String, dynamic> _body = {
                                        "Name": nameController.text,
                                        "Email": usernameController.text,
                                        "Phone": phoneController.text,
                                        "Group": "admin",
                                        "Pass": passwordController.text
                                      };
                                      signUpAPI(_body).then((value) {
                                        if (value != "fail") {
                                          singUpFirebase(nameController.text)
                                              .then((value) {
                                            Navigator.pop(context);
                                            if (value != "fail") {
                                              Navigator.pop(context);
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                      "Registratered successfully",
                                                      style: TextStyle(
                                                          color: Colors.green,
                                                          fontFamily: "Roboto",
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    content: Text(
                                                      "Please login to continue",
                                                      style: TextStyle(
                                                          color: Colors.green,
                                                          fontFamily: "Roboto",
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    actions: [
                                                      FlatButton(
                                                        onPressed: () =>
                                                            Navigator.of(
                                                                    context)
                                                                .pop(),
                                                        child: Text(
                                                          "OK",
                                                          style: TextStyle(
                                                            color: Colors.blue,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  );
                                                },
                                              );
                                            } else {
                                              showDialog(
                                                  context: context,
                                                  child: AlertDialog(
                                                    title: Text(
                                                      "Registration failed",
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontFamily: "Roboto",
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    content: Text(
                                                      "Please try again",
                                                      style: TextStyle(
                                                          color: Colors.green,
                                                          fontFamily: "Roboto",
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    actions: [
                                                      FlatButton(
                                                        onPressed: () =>
                                                            Navigator.of(
                                                                    context)
                                                                .pop(),
                                                        child: Text(
                                                          "OK",
                                                          style: TextStyle(
                                                            color: Colors.blue,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ));
                                            }
                                          });
                                        } else {
                                          Navigator.pop(context);
                                          showDialog(
                                              context: context,
                                              child: AlertDialog(
                                                title: Text(
                                                  "Registration failed",
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontFamily: "Roboto",
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                content: Text(
                                                  "Please try again",
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontFamily: "Roboto",
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                actions: [
                                                  FlatButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(),
                                                    child: Text(
                                                      "OK",
                                                      style: TextStyle(
                                                        color: Colors.blue,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ));
                                        }
                                      });
                                    } else {
                                      Navigator.pop(context);
                                      showDialog(
                                          context: context,
                                          child: AlertDialog(
                                            title: Text(
                                              "Confirm Password",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontFamily: "Roboto",
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            content: Text(
                                              "Please recheck your passwords, they do not match",
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontFamily: "Roboto",
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            actions: [
                                              FlatButton(
                                                onPressed: () =>
                                                    Navigator.of(context).pop(),
                                                child: Text(
                                                  "OK",
                                                  style: TextStyle(
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ));
                                    }
                                  } else {
                                    Navigator.pop(context);
                                    showDialog(
                                        context: context,
                                        child: AlertDialog(
                                          title: Text(
                                            "Field Empty",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontFamily: "Roboto",
                                                fontWeight: FontWeight.bold),
                                          ),
                                          content: Text(
                                            "All fields are required",
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontFamily: "Roboto",
                                                fontWeight: FontWeight.bold),
                                          ),
                                          actions: [
                                            FlatButton(
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                              child: Text(
                                                "OK",
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            )
                                          ],
                                        ));
                                  }
                                } else {
                                  Navigator.pop(context);
                                  showDialog(
                                      context: context,
                                      child: AlertDialog(
                                        title: Text(
                                          "Password length",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontFamily: "Roboto",
                                              fontWeight: FontWeight.bold),
                                        ),
                                        content: Text(
                                          "Password should contain atleast 8 characters including some special characters",
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontFamily: "Roboto",
                                              fontWeight: FontWeight.bold),
                                        ),
                                        actions: [
                                          FlatButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            child: Text(
                                              "OK",
                                              style: TextStyle(
                                                color: Colors.blue,
                                              ),
                                            ),
                                          )
                                        ],
                                      ));
                                }
                              },
                              color: buttonBgColor,
                              text: "Register"),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: LearneeLightTextButton(
                      action: () {
                        Navigator.of(context).pop();
                      },
                      text: "Alredy have an account?\nLogin",
                      textColor: Colors.black),
                ),
              ],
            ),
          )),
    );
  }
}
