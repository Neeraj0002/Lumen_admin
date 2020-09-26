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
import 'package:lumin_admin/Screens/signup.dart';
import 'package:lumin_admin/services/auth.dart';
import 'package:lumin_admin/services/database.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController cPasswordController = TextEditingController();

  TextEditingController phoneController = TextEditingController();
  bool goToRegister = false;

  LearneeAppBar appbar = LearneeAppBar();
  switchRegisterLogin() {
    setState(() {
      goToRegister = !goToRegister;
    });
  }

  AuthService authService = new AuthService();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  Future singUpFirebase(String name) async {
    String status = "fail";
    await authService
        .signUpWithEmailAndPassword(
            usernameController.text, passwordController.text)
        .then((result) {
      if (result != null) {
        Map<String, String> userDataMap = {
          'nickname': "$name",
          'email': usernameController.text,
          'id': result.uid,
          'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
          'chattingWith': null
        };

        databaseMethods
            .addUserInfo(userDataMap, result.uid)
            .then((value) => status = "success");
      }
    });
    return status;
  }

  Future signIn(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String status = "fail";
    await authService
        .signInWithEmailAndPassword(
            usernameController.text, passwordController.text)
        .then((result) async {
      if (result != null) {
        status = "success";
        prefs.setString("firebaseId", result.uid).then((value) => print("Set"));
      }
      /*else {
        print("signing up");
        await singUpFirebase(fname, lname).then((value) {
          status = value;
          print(value);
        });
        print(status);
      }*/
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
                          color: Colors.black26, spreadRadius: 2, blurRadius: 4)
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
                          "Login",
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
                          hint: "Your email address",
                          label: "Email Address",
                          icon: Icons.email,
                          hideText: false,
                          textController: usernameController),
                      LearneeTextField(
                          hint: "Your password",
                          label: "Password",
                          icon: MdiIcons.key,
                          hideText: true,
                          textController: passwordController),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                        child: LearneeRegLogButton(
                            action: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
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
                              loginAPI(context, usernameController.text,
                                      passwordController.text)
                                  .then((mainValue) {
                                print("Main login done");
                                print(mainValue);
                                if (mainValue != "fail") {
                                  var parsed = jsonDecode(mainValue);
                                  signIn(parsed["Name"]).then((firebaseValue) {
                                    if (firebaseValue != 'fail') {
                                      prefs.setString("name", parsed["Name"]);
                                      prefs.setString("phone", parsed["Phone"]);
                                      prefs.setString("email", parsed["Email"]);
                                      prefs.setString("userId", parsed["Uid"]);
                                      prefs.setString(
                                          "userGroup", parsed["Group"]);
                                      prefs
                                          .setBool("loggedIn", true)
                                          .then((value) {
                                        Navigator.of(context)
                                            .pushReplacement(MaterialPageRoute(
                                          settings:
                                              RouteSettings(name: "/dashboard"),
                                          builder: (context) =>
                                              DashboardScreen(),
                                        ));
                                      });
                                    } else {
                                      Navigator.of(context).pop();
                                      showDialog(
                                          context: context,
                                          child: AlertDialog(
                                            content: Text(
                                              "Please check your email and password",
                                              style: TextStyle(
                                                  color: Colors.red,
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
                                  });
                                } else {
                                  Navigator.of(context).pop();
                                  showDialog(
                                      context: context,
                                      child: AlertDialog(
                                        content: Text(
                                          "Please check your email and password",
                                          style: TextStyle(
                                              color: Colors.red,
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
                              });
                            },
                            color: buttonBgColor,
                            text: "Login"),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: LearneeLightTextButton(
                    action: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    text: "Don't have an account?\nRegister",
                    textColor: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
