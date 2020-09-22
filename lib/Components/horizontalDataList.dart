import 'package:flutter/material.dart';
import 'package:lumin_admin/API_Functions/HomeData/homeDataModel.dart';
import 'package:lumin_admin/API_Functions/apiConfig.dart';
import 'package:lumin_admin/Components/courseCard.dart';
import 'package:lumin_admin/Screens/CourseDetails/CourseDetails.dart';

// ignore: must_be_immutable
class HorizontalDataList extends StatelessWidget {
  final String title;
  List dataList;
  ApiConfig config = ApiConfig();
  HorizontalDataList({@required this.dataList, @required this.title});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 8.0),
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.black87,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                ),
              ),
            )
          ],
        ),
        Container(
          height: 240,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                children: List.generate(dataList.length, (index) {
                  return CourseCard(
                    action: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        settings: RouteSettings(
                          name: "/courseDetails",
                        ),
                        builder: (context) => CourseDetails(),
                      ));
                    },
                    title: New.fromJson(dataList[index]).title,
                    price: "₹${New.fromJson(dataList[index]).price}",
                    duration: New.fromJson(dataList[index]).duration.toString(),
                    imgUrl:
                        "${config.mainUrl}${New.fromJson(dataList[index]).thumbnail}",
                  );
                })),
          ),
        )
      ],
    );
  }
}

/** */
