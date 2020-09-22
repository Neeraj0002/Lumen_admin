import 'package:flutter/material.dart';
import 'package:lumin_admin/API_Functions/getPurchases.dart';
import 'package:lumin_admin/Components/appBar.dart';
import 'package:lumin_admin/Essentials/colors.dart';

class PurchaseCourseList extends StatefulWidget {
  @override
  _PurchaseCourseListState createState() => _PurchaseCourseListState();
}

class _PurchaseCourseListState extends State<PurchaseCourseList> {
  LearneeAppBar appBar = LearneeAppBar();

  _teacherCard({
    @required String email,
    @required String courseName,
    @required String price,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 1,
                blurRadius: 2,
              )
            ],
            borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  courseName,
                  style: TextStyle(
                    color: Colors.black87,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  "₹$price",
                  style: TextStyle(
                    color: Colors.black87,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  email,
                  style: TextStyle(
                    color: Colors.black87,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getPurchasesAPI(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data != null) {
            print(snapshot.data);
            return snapshot.data != null
                ? ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return snapshot
                                  .data[index]['CourseDetails']['uid'].length !=
                              0
                          ? _teacherCard(
                              email: snapshot.data[index]['email'],
                              courseName: snapshot.data[index]['CourseDetails']
                                  ['title'],
                              price: snapshot.data[index]['CourseDetails']
                                  ['price'])
                          : Container();
                    },
                  )
                : Center(
                    child: Text("No courses has been bought yet"),
                  );
          } else {
            return Center(
              child: Text("No courses has been bought yet"),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
