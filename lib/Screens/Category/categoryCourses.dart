import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lumin_admin/API_Functions/Category/getCoursesByCatId.dart';
import 'package:lumin_admin/API_Functions/courseListModel.dart';
import 'package:lumin_admin/Components/appBar.dart';
import 'package:lumin_admin/Components/courseCard.dart';
import 'package:lumin_admin/Essentials/colors.dart';
import 'package:lumin_admin/Screens/CourseDetails/CourseDetails.dart';

// ignore: must_be_immutable
class CourseCatList extends StatefulWidget {
  String id;
  String catName;
  CourseCatList({@required this.id, @required this.catName});
  @override
  _CourseCatListState createState() => _CourseCatListState();
}

class _CourseCatListState extends State<CourseCatList> {
  LearneeAppBar appBar = LearneeAppBar();
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: bgColor,
        systemNavigationBarIconBrightness: Brightness.dark));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: appBar.categoriesAppBar(title: widget.catName, context: context),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          backgroundColor: appBarColor,
          tooltip: "Go to home page",
          child: Icon(
            Icons.home,
            color: Colors.white,
          )),
      body: FutureBuilder(
        future: getCoursesByIdAPI(context, widget.id),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != "fail") {
              var parsedData = jsonDecode(snapshot.data);
              return ListView(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  children: List.generate(parsedData["data"].length, (index) {
                    return index == (parsedData["data"].length - 1)
                        ? Column(
                            children: [
                              CourseCard2(
                                action: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    settings: RouteSettings(
                                      name: "/courseDetails",
                                    ),
                                    builder: (context) => CourseDetails(),
                                  ));
                                },
                                title: CourseListModel.fromJson(parsedData)
                                    .data[index]
                                    .title,
                                price:
                                    "₹${CourseListModel.fromJson(parsedData).data[index].price}",
                                time: CourseListModel.fromJson(parsedData)
                                    .data[index]
                                    .duration
                                    .toString(),
                                imgUrl: CourseListModel.fromJson(parsedData)
                                    .data[index]
                                    .thumbnail,
                              ),
                              Container(
                                height: 70,
                              )
                            ],
                          )
                        : CourseCard2(
                            action: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                settings: RouteSettings(
                                  name: "/courseDetails",
                                ),
                                builder: (context) => CourseDetails(),
                              ));
                            },
                            title: CourseListModel.fromJson(parsedData)
                                .data[index]
                                .title,
                            price:
                                "₹${CourseListModel.fromJson(parsedData).data[index].price}",
                            time: CourseListModel.fromJson(parsedData)
                                .data[index]
                                .duration
                                .toString(),
                            imgUrl: CourseListModel.fromJson(parsedData)
                                .data[index]
                                .thumbnail,
                          );
                  }));
            } else {
              return RefreshIndicator(
                onRefresh: () async {
                  setState(() {});
                },
                child: Stack(
                  children: [
                    ListView(),
                    Center(
                      child: Text(
                        "Failed\nSwipe down to refresh",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.red,
                            fontFamily: "Roboto",
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
              );
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
