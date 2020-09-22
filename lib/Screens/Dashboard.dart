import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lumin_admin/API_Functions/Category/getCategories.dart';
import 'package:lumin_admin/API_Functions/Courses/AllCoursesAPI.dart';
import 'package:lumin_admin/API_Functions/getUserData.dart';
import 'package:lumin_admin/Components/appBar.dart';
import 'package:lumin_admin/Components/buttons.dart';
import 'package:lumin_admin/Components/userDisplayCard.dart';
import 'package:lumin_admin/Essentials/colors.dart';
import 'package:lumin_admin/Essentials/getterFunctions.dart';
import 'package:lumin_admin/Essentials/storedData.dart';
import 'package:lumin_admin/Screens/AllCourses.dart';
import 'package:lumin_admin/Screens/Attendance.dart';
import 'package:lumin_admin/Screens/Home/chatrooms.dart';
import 'package:lumin_admin/Screens/AddCourse.dart';
import 'package:lumin_admin/Screens/Live/live.dart';
import 'package:lumin_admin/Screens/ManageCategory.dart';
import 'package:lumin_admin/Screens/ManageSlider.dart';
import 'package:lumin_admin/Screens/Purchases.dart';
import 'package:lumin_admin/Screens/Teachers.dart';
import 'package:lumin_admin/Screens/financial.dart';
import 'package:lumin_admin/Screens/User/myCoursesAndPurchases.dart';
import 'package:lumin_admin/Screens/User/newTicketScreen.dart';
import 'package:lumin_admin/Screens/login.dart';
import 'package:lumin_admin/Screens/Users.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  LearneeAppBar appbar = LearneeAppBar();
  getUserDetails(String title, String group) async {
    Navigator.pop(context);
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
    getUserDataAPI().then((value) {
      Navigator.of(context).pop();
      if (value != 'fail') {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                Users(data: value, group: group, title: title)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => SystemNavigator.pop(),
      child: Scaffold(
        appBar: appbar.dashboardScreenAppBar(
            title: "Dashboard",
            context: context,
            logoutAction: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();

              showDialog(
                  context: context,
                  child: AlertDialog(
                    content: Text(
                      "Are you sure that you want to log out?",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: "OpenSans"),
                    ),
                    actions: [
                      FlatButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Center(
                          child: Text(
                            "No",
                            style: TextStyle(
                              color: Colors.green,
                              fontFamily: "OpenSans",
                            ),
                          ),
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          prefs.setBool("loggedIn", false);
                          prefs.remove("userEmail");
                          prefs.remove("userName");
                          Navigator.pop(context);
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) {
                              return Login();
                            },
                          ));
                        },
                        child: Text(
                          "Yes",
                          style: TextStyle(
                            color: appBarColor,
                            fontFamily: "OpenSans",
                          ),
                        ),
                      )
                    ],
                  ));
            }),
        backgroundColor: bgColor,
        body: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder(
                    future: getAllCoursesAPI(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData) {
                        var parsed = snapshot.data;
                        return DisplayCard(
                          color: Color.fromRGBO(227, 89, 219, 1.0),
                          line1: "Courses",
                          line2: parsed["AllCourses"] == null
                              ? "0"
                              : parsed["AllCourses"].length.toString(),
                        );
                      } else {
                        return DisplayCard(
                          color: Color.fromRGBO(227, 89, 219, 1.0),
                          line1: "Courses",
                          line2: "0",
                        );
                      }
                    }),
                /*DisplayCard(
                  color: Color.fromRGBO(51, 191, 254, 1.0),
                  line1: "Account charge",
                  line2: "₹0",
                ),*/
              ],
            ),
            FutureBuilder(
                future: getUserGroup(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GridView.count(
                        shrinkWrap: true,
                        childAspectRatio: 80 / 30,
                        crossAxisCount: 2,
                        children: [
                          LearneeRoundedBtn(
                            action: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                settings: RouteSettings(name: "/allCourses"),
                                builder: (context) => AllCourses(),
                              ));
                            },
                            text: "Courses",
                            icon: MdiIcons.video,
                          ),
                          /*LearneeRoundedBtn(
                            action: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                settings: RouteSettings(name: "/financial"),
                                builder: (context) => Financial(),
                              ));
                            },
                            text: "Financial",
                            icon: MdiIcons.finance,
                          ),*/

                          LearneeRoundedBtn(
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
                              getCategoriesAPI().then((value) {
                                Navigator.pop(context);
                                if (value != 'fail') {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    settings: RouteSettings(name: "/addCourse"),
                                    builder: (context) => AddCourse(
                                      categories: value,
                                    ),
                                  ));
                                }
                              });
                            },
                            text: "Add Course",
                            icon: Icons.add,
                          ),
                          LearneeRoundedBtn(
                            action: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                settings: RouteSettings(name: "/categories"),
                                builder: (context) => ManageCategory(),
                              ));
                            },
                            text: "Categories",
                            icon: Icons.list,
                          ),
                          LearneeRoundedBtn(
                            action: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                settings: RouteSettings(name: "/manageSlider"),
                                builder: (context) => ManageSlider(),
                              ));
                            },
                            text: "Slider Image",
                            icon: MdiIcons.image,
                          ),
                          LearneeRoundedBtn(
                              action: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  settings: RouteSettings(name: "/liveClass"),
                                  builder: (context) => LiveScreen(),
                                ));
                              },
                              text: "Live Class",
                              icon: MdiIcons.videoAccount),
                          LearneeRoundedBtn(
                              action: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  settings: RouteSettings(name: "/teachers"),
                                  builder: (context) => Teachers(),
                                ));
                              },
                              text: "Requests",
                              icon: MdiIcons.callReceived),
                          LearneeRoundedBtn(
                            action: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      height: 200,
                                      child: Column(
                                        children: [
                                          ListTile(
                                            title: Text("Users"),
                                            onTap: () =>
                                                getUserDetails('Users', 'user'),
                                          ),
                                          ListTile(
                                            title: Text("Teachers"),
                                            onTap: () => getUserDetails(
                                                'Teachers', 'teacher'),
                                          ),
                                          ListTile(
                                            title: Text("Admins"),
                                            onTap: () => getUserDetails(
                                                'Admins', 'admin'),
                                          )
                                        ],
                                      ),
                                    );
                                  });
                            },
                            text: "Users",
                            icon: Icons.people,
                          ),
                          LearneeRoundedBtn(
                            action: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                settings: RouteSettings(name: "/chatRoom"),
                                builder: (context) => ChatRoom(),
                              ));
                            },
                            text: "Chat",
                            icon: MdiIcons.chat,
                          ),
                          LearneeRoundedBtn(
                            action: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                settings: RouteSettings(name: "/attendance"),
                                builder: (context) => Attendance(),
                              ));
                            },
                            text: "Attendance",
                            icon: Icons.assignment_turned_in,
                          ),
                          LearneeRoundedBtn(
                            action: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                settings: RouteSettings(name: "/financial"),
                                builder: (context) => Financial(),
                              ));
                            },
                            text: "Financial",
                            icon: MdiIcons.finance,
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                }),
          ],
        ),
      ),
    );
  }
}
