import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lumin_admin/API_Functions/Courses/AllCoursesAPI.dart';
import 'package:lumin_admin/Components/appBar.dart';
import 'package:lumin_admin/Components/courseCard.dart';
import 'package:lumin_admin/Essentials/colors.dart';
import 'package:lumin_admin/Essentials/storedData.dart';
import 'package:lumin_admin/Screens/PurchasedCourseDetail.dart';

class AllCourses extends StatefulWidget {
  @override
  _AllCoursesState createState() => _AllCoursesState();
}

class _AllCoursesState extends State<AllCourses> {
  GlobalKey<ScaffoldState> allCoursesKey = GlobalKey<ScaffoldState>();
  LearneeAppBar appBar = LearneeAppBar();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: allCoursesKey,
      appBar: appBar.simpleAppBar(title: "All Courses"),
      backgroundColor: bgColor,
      body: FutureBuilder(
        future: getAllCoursesAPI(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              var parsed = snapshot.data;
              return parsed["AllCourses"] != null
                  ? ListView(
                      children: List.generate(
                          parsed["AllCourses"] == null
                              ? 0
                              : parsed["AllCourses"].length, (index) {
                        return CourseCard2(
                            featured: parsed["AllCourses"][index]['featured'],
                            popular: parsed["AllCourses"][index]['Popular'],
                            action: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                settings: RouteSettings(name: "/dashboard"),
                                builder: (context) => PurchasedCourseDetails(
                                  data: parsed["AllCourses"][index],
                                  parentKey: this,
                                ),
                              ));
                            },
                            title: parsed["AllCourses"][index]["title"],
                            price: "₹${parsed["AllCourses"][index]["price"]}",
                            time: null,
                            imgUrl: parsed["AllCourses"][index]["thumbnail"]);
                      }),
                    )
                  : Center(
                      child: Text("No course has been added"),
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
      ),
    );
  }
}
