import 'dart:convert';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lumin_admin/API_Functions/Authentication/loginAPI.dart';
import 'package:lumin_admin/API_Functions/Authentication/signUpAPI.dart';
import 'package:lumin_admin/Components/appBar.dart';
import 'package:lumin_admin/Components/buttons.dart';
import 'package:lumin_admin/Components/textBox.dart';
import 'package:lumin_admin/Essentials/colors.dart';
import 'package:lumin_admin/services/auth.dart';
import 'package:lumin_admin/services/database.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AddTeacher extends StatefulWidget {
  State parent;
  AddTeacher({@required this.parent});
  @override
  _AddTeacherState createState() => _AddTeacherState();
}

class _AddTeacherState extends State<AddTeacher> {
  LearneeAppBar appBar = LearneeAppBar();
  TextEditingController usernameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController cPasswordController = TextEditingController();

  TextEditingController phoneController = TextEditingController();
  AuthService authService = new AuthService();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  bool emailValid = false;

  validateEmail(String email) {
    bool _emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(usernameController.text);
    emailValid = email.isEmpty ? false : _emailValid;
    setState(() {});
  }

  Future singUpFirebase(String name, String uid) async {
    String status = "fail";
    await authService
        .signUpWithEmailAndPassword(
            usernameController.text, passwordController.text)
        .then((result) async {
      print(result);
      if (result != null) {
        status = "success";
        Map<String, String> userDataMap = {
          'nickname': "$name",
          'email': usernameController.text,
          'id': uid != null ? uid : result.uid,
          'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
          'chattingWith': null
        };

        await databaseMethods
            .addUserInfo(userDataMap, uid)
            .then((value) => status = "success");
      }
    });
    return status;
  }

  @override
  void initState() {
    validateEmail(usernameController.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar.simpleAppBar(title: "Add Teacher"),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: ListView(
          children: [
            LearneeTextField(
                hint: "Your name",
                label: "Name",
                icon: MdiIcons.key,
                hideText: false,
                textController: nameController),
            LearneeEmailTextField(
                onEdit: (value) {
                  validateEmail(usernameController.text);
                },
                error: usernameController.text.isEmpty ? false : !emailValid,
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    child: CircularProgressIndicator(),
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
                          cPasswordController.text.isNotEmpty &&
                          emailValid) {
                        if (cPasswordController.text ==
                            passwordController.text) {
                          Map<String, dynamic> _body = {
                            "Name": nameController.text,
                            "Email": usernameController.text,
                            "Phone": phoneController.text,
                            "Group": "teacher",
                            "Pass": passwordController.text
                          };
                          signUpAPI(_body).then((value) {
                            if (value != "fail") {
                              loginAPI(context, usernameController.text,
                                      passwordController.text)
                                  .then((value) {
                                var parsed, userId;
                                if (value != 'fail' && value != null) {
                                  parsed = jsonDecode(value);
                                  userId = parsed['Uid'];
                                }
                                singUpFirebase(nameController.text, userId)
                                    .then((value) {
                                  Navigator.pop(context);
                                  if (value != "fail") {
                                    showDialog(
                                        context: context,
                                        child: AlertDialog(
                                          title: Text(
                                            "Registered successfully",
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontFamily: "Roboto",
                                                fontWeight: FontWeight.bold),
                                          ),
                                          content: Text(
                                            "Share login details",
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontFamily: "Roboto",
                                                fontWeight: FontWeight.bold),
                                          ),
                                          actions: [
                                            FlatButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                Navigator.of(context).pop();
                                                widget.parent.setState(() {});
                                              },
                                              child: Text(
                                                "Close",
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            ),
                                            FlatButton(
                                              color: Colors.blue,
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                final RenderBox box =
                                                    context.findRenderObject();
                                                Share.text(
                                                    "Your Login Details",
                                                    "Email:${usernameController.text}\nPassword:${passwordController.text}\n\nLumen Academy",
                                                    "text/plain");
                                                usernameController.clear();
                                                passwordController.clear();
                                                phoneController.clear();
                                                passwordController.clear();
                                                cPasswordController.clear();
                                                nameController.clear();
                                              },
                                              child: Text(
                                                "Share",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ));
                                  } else {
                                    showDialog(
                                        context: context,
                                        child: AlertDialog(
                                          title: Text(
                                            "Registration failed",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontFamily: "Roboto",
                                                fontWeight: FontWeight.bold),
                                          ),
                                          content: Text(
                                            "Please try again",
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
                                });
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
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: Text(
                                      "Please try again",
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
                                  onPressed: () => Navigator.of(context).pop(),
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
                                onPressed: () => Navigator.of(context).pop(),
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
    );
  }
}
