import 'package:flutter/material.dart';
import 'package:lumin_admin/Components/appBar.dart';
import 'package:lumin_admin/Components/courseCard.dart';
import 'package:lumin_admin/Essentials/colors.dart';
import 'package:lumin_admin/Screens/PurchasedCourseDetail.dart';

class MyCoursesAndPurchases extends StatefulWidget {
  @override
  _MyCoursesAndPurchasesState createState() => _MyCoursesAndPurchasesState();
}

class _MyCoursesAndPurchasesState extends State<MyCoursesAndPurchases> {
  LearneeAppBar appbar = LearneeAppBar();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: bgColor,
          appBar: appbar.myCoursesAndPurchasesAppBar(
              title: "Courses",
              tabTitle1: "My Courses",
              tabTitle2: "My Purchases"),
          body: TabBarView(
            children: [
              Center(
                  child: ListView(
                children: [
                  CourseCard2(
                      action: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PurchasedCourseDetails(
                            parentKey: null,
                            data: null,
                          ),
                        ));
                      },
                      title: "CourseName",
                      price: "₹100",
                      time: "10:30",
                      imgUrl:
                          "https://idesignschool.org/images/web-development.jpg")
                ],
              ) /*Container(
                  height: 200,
                  child: Image.asset(
                    "assets/img/state/Videos.png",
                    fit: BoxFit.contain,
                  ),
                ),*/
                  ),
              Center(
                child: Container(
                  height: 200,
                  child: Image.asset(
                    "assets/img/state/bought.png",
                    fit: BoxFit.contain,
                  ),
                ),
              )
            ],
          )),
    );
  }
}

/** */
