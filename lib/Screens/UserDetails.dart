import 'package:flutter/material.dart';
import 'package:lumin_admin/API_Functions/Courses/teachersCourses.dart';
import 'package:lumin_admin/API_Functions/getPurchasedById.dart';
import 'package:lumin_admin/Components/appBar.dart';
import 'package:lumin_admin/Components/courseCard.dart';
import 'package:lumin_admin/Screens/PurchasedCourseDetail.dart';

// ignore: must_be_immutable
class UserDetails extends StatefulWidget {
  var data;
  UserDetails({this.data});
  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  LearneeAppBar appBar = LearneeAppBar();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar.simpleAppBar(title: "User Details"),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SelectableText(
                      widget.data["Name"],
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SelectableText(
                      widget.data["Email"],
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SelectableText(
                      widget.data["Phone"],
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ),
          FutureBuilder(
              future: getPurchasedCoureAPI(widget.data["Uid"]),
              builder: (context, teachersnapshot) {
                if (teachersnapshot.connectionState == ConnectionState.done) {
                  print("Data : ${teachersnapshot.data}");
                  return teachersnapshot.data != null
                      ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SelectableText(
                                "Purchased Courses",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                            ),
                            Column(
                              children: List.generate(
                                  teachersnapshot.data.length, (index) {
                                if (teachersnapshot.data != null) {
                                  return teachersnapshot
                                              .data[index]['coursedetails']
                                                  ['uid']
                                              .length !=
                                          0
                                      ? CourseCard2(
                                          popular: teachersnapshot.data[index]
                                              ['coursedetails']['Popular'],
                                          featured: teachersnapshot.data[index]
                                              ['coursedetails']['featured'],
                                          action: () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              settings: RouteSettings(
                                                name: "/courseDetails",
                                              ),
                                              builder: (context) =>
                                                  PurchasedCourseDetails(
                                                data:
                                                    teachersnapshot.data[index]
                                                        ['coursedetails'],
                                                parentKey: this,
                                              ),
                                            ));
                                          },
                                          title: teachersnapshot.data[index]
                                              ['coursedetails']['title'],
                                          price:
                                              "₹${teachersnapshot.data[index]['coursedetails']['price']}",
                                          time: "",
                                          imgUrl: teachersnapshot.data[index]
                                              ['coursedetails']['thumbnail'])
                                      : Container(
                                          height: 100,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Center(
                                            child: Text(
                                              "The course that you had purchased has been deleted",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        );
                                } else {
                                  return Container(
                                    height: 200,
                                    child: Center(
                                      child: Text("No courses purchased"),
                                    ),
                                  );
                                }
                              }),
                            ),
                          ],
                        )
                      : Center(
                          child: Container(
                            height: 200,
                            child: Center(
                              child: Text("No courses purchased"),
                            ),
                          ),
                        );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              }),
          (widget.data["Group"] == "teacher" || widget.data["Group"] == "admin")
              ? FutureBuilder(
                  future: getTeachersCoursesAPI(widget.data["Email"]),
                  builder: (context, teachersnapshot) {
                    if (teachersnapshot.connectionState ==
                            ConnectionState.done &&
                        teachersnapshot.hasData) {
                      return teachersnapshot.data['AllCourses'] != null
                          ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SelectableText(
                                    "Uploaded Courses",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                ),
                                Column(
                                  children: List.generate(
                                      teachersnapshot.data['AllCourses'].length,
                                      (index) {
                                    if (teachersnapshot.data["AllCourses"] !=
                                        null) {
                                      return CourseCard2(
                                          featured:
                                              teachersnapshot.data["AllCourses"]
                                                  [index]['featured'],
                                          popular:
                                              teachersnapshot.data["AllCourses"]
                                                  [index]['Popular'],
                                          action: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    settings: RouteSettings(
                                                      name: "/courseDetails",
                                                    ),
                                                    builder: (context) =>
                                                        PurchasedCourseDetails(
                                                            parentKey: this,
                                                            data: teachersnapshot
                                                                    .data[
                                                                "AllCourses"])));
                                          },
                                          title:
                                              teachersnapshot.data["AllCourses"]
                                                  [index]['title'],
                                          price:
                                              "₹${teachersnapshot.data["AllCourses"][index]['price']}",
                                          time: null,
                                          imgUrl:
                                              teachersnapshot.data["AllCourses"]
                                                  [index]['thumbnail']);
                                    } else {
                                      return Container(
                                        height: 200,
                                        child: Center(
                                          child: Text("No courses uploaded"),
                                        ),
                                      );
                                    }
                                  }),
                                ),
                              ],
                            )
                          : Container(
                              height: 200,
                              child: Center(
                                child: Text("No courses uploaded"),
                              ),
                            );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )
              : Container()
        ],
      ),
    );
  }
}
