import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lumin_admin/API_Functions/Courses/AllCoursesAPI.dart';
import 'package:lumin_admin/API_Functions/Courses/teachersCourses.dart';
import 'package:lumin_admin/API_Functions/LiveClasses/deleteLiveClasses.dart';
import 'package:lumin_admin/API_Functions/LiveClasses/getLiveclasses.dart';
import 'package:lumin_admin/Components/appBar.dart';
import 'package:lumin_admin/Components/headingText.dart';
import 'package:lumin_admin/Essentials/colors.dart';
import 'package:lumin_admin/Essentials/getterFunctions.dart';
import 'package:lumin_admin/Screens/Live/LiveClassDetails.dart';
import 'package:lumin_admin/Screens/Live/addLiveClass.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LiveScreen extends StatefulWidget {
  @override
  _LiveScreenState createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  GlobalKey<ScaffoldState> _liveListKey = GlobalKey<ScaffoldState>();
  LearneeAppBar appBar = LearneeAppBar();
  Future<bool> checkLoginStaus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('loggedIn');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _liveListKey,
        appBar: appBar.liveAppBar(
            title: "Live",
            addAction: () {
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
              getAllCoursesAPI().then((value) {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    settings: RouteSettings(name: "/addLiveClass"),
                    builder: (context) => AddLiveClass(
                          data: value["AllCourses"],
                          parentKey: this,
                        )));
              });
            }),
        backgroundColor: bgColor,
        body: FutureBuilder(
          future: checkLoginStaus(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data) {
                return FutureBuilder(
                  future: getLiveClassesAPI(),
                  builder: (context, liveclass) {
                    if (liveclass.connectionState == ConnectionState.done) {
                      if (liveclass.hasData) {
                        print(liveclass.data);
                        return ListView(
                          children: [
                            HeadingText(text: "Upcoming Live Classes"),
                            Column(
                              children: List.generate(
                                  liveclass.data.length,
                                  (index) => LiveClassCard(
                                        deleteAction: () {
                                          showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              child: AlertDialog(
                                                content: Container(
                                                  height: 80,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
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
                                          deleteLiveClassAPI(context,
                                                  id: liveclass.data[index]
                                                      ['channel'])
                                              .then((value) {
                                            Navigator.of(context).pop();
                                            if (value != 'fail') {
                                              Fluttertoast.showToast(
                                                  msg: "Deleted",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.black,
                                                  textColor: Colors.white,
                                                  fontSize: 14.0);
                                              setState(() {});
                                            }
                                          });
                                        },
                                        courseName: liveclass.data[index]
                                            ['course'],
                                        time: liveclass.data[index]['time'],
                                        action: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  settings: RouteSettings(
                                                      name:
                                                          "/liveClassDetials"),
                                                  builder: (context) =>
                                                      LiveClassDetails(
                                                          parent: this,
                                                          channelName:
                                                              liveclass
                                                                      .data[index]
                                                                  ['channel'],
                                                          desc: liveclass.data[
                                                                  index]
                                                              ['Description'],
                                                          courseName: liveclass
                                                                  .data[index]
                                                              ['course'],
                                                          time:
                                                              "${DateTime.parse(liveclass.data[index]['time']).hour}:${DateTime.parse(liveclass.data[index]['time']).minute}, ${DateTime.parse(liveclass.data[index]['time']).day}/${DateTime.parse(liveclass.data[index]['time']).month}/${DateTime.parse(liveclass.data[index]['time']).year}")));
                                        },
                                      )),
                            )
                          ],
                        );
                      } else {
                        return Container();
                      }
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                );
              } else {
                return Center(
                  child: Text("Please login"),
                );
              }
            } else {
              return Container(
                height: 0,
                width: 0,
              );
            }
          },
        ));
  }
}

// ignore: must_be_immutable
class LiveClassCard extends StatelessWidget {
  Function action;
  String courseName;
  String time;
  Function deleteAction;
  LiveClassCard(
      {@required this.action,
      @required this.courseName,
      @required this.time,
      @required this.deleteAction});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: action,
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(1, 1)),
            ],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /*Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      color: Colors.black, shape: BoxShape.circle),
                ),*/

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        courseName,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                      Text(
                        "${DateTime.parse(time).hour}:${DateTime.parse(time).minute}, ${DateTime.parse(time).day}/${DateTime.parse(time).month}/${DateTime.parse(time).year}",
                        style: TextStyle(
                            color: Colors.black45,
                            fontFamily: "OpenSans",
                            fontSize: 12),
                      )
                    ],
                  ),
                ),
                FutureBuilder(
                  future: getUserGroup(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data == "teacher" ||
                          snapshot.data == "admin") {
                        return IconButton(
                          color: Colors.red,
                          icon: Icon(Icons.delete),
                          onPressed: deleteAction,
                        );
                      } else {
                        return Container();
                      }
                    } else {
                      return Container();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
