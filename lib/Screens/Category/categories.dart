import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lumin_admin/API_Functions/HomeData/homeDataModel.dart';
import 'package:lumin_admin/API_Functions/apiConfig.dart';
import 'package:lumin_admin/Components/appBar.dart';
import 'package:lumin_admin/Components/courseCatCard.dart';
import 'package:lumin_admin/Essentials/colors.dart';
import 'package:lumin_admin/Screens/Category/categoryCourses.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class CourseCategories extends StatelessWidget {
  LearneeAppBar appBar = LearneeAppBar();
  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("homeDataResult");
  }

  ApiConfig config = ApiConfig();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        appBar: appBar.categoriesAppBar(
            title: "Course Categories", context: context),
        body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var parsedData = jsonDecode(snapshot.data);
              return ListView(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                children: List.generate(
                    HomeData.fromJson(parsedData).data.content.category.length,
                    (index) {
                  return MainCatItem(
                    img:
                        "${config.mainUrl}/${HomeData.fromJson(parsedData).data.content.category[index].icon}",
                    title: HomeData.fromJson(parsedData)
                        .data
                        .content
                        .category[index]
                        .title,
                    noOfCourses: HomeData.fromJson(parsedData)
                        .data
                        .content
                        .category[index]
                        .count
                        .toString(),
                    subCatList: HomeData.fromJson(parsedData)
                        .data
                        .content
                        .category[index]
                        .toJson()["childs"],
                  );
                }),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}

// ignore: must_be_immutable
class MainCatItem extends StatelessWidget {
  List subCatList;
  String title;
  String noOfCourses;
  String img;
  ApiConfig config = ApiConfig();
  MainCatItem(
      {@required this.img,
      @required this.noOfCourses,
      @required this.subCatList,
      @required this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ExpansionTile(
        backgroundColor: Colors.white,
        title: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Roboto",
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          "$noOfCourses Courses",
          style: TextStyle(
            color: Colors.black38,
            fontFamily: "Roboto",
            fontSize: 14,
          ),
        ),
        leading: Container(
          height: 35,
          width: 35,
          child: CachedNetworkImage(
            imageUrl: img,
            errorWidget: (context, url, error) {
              return Center(
                child: Icon(
                  Icons.error,
                  color: Colors.red,
                ),
              );
            },
            progressIndicatorBuilder: (context, url, progress) {
              return Center(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
            fit: BoxFit.fill,
          ),
        ),
        children: List.generate(subCatList.length, (index) {
          return CourseCatCard(
              action: () {
                Navigator.of(context).push(MaterialPageRoute(
                  settings: RouteSettings(
                    name: "/catCourseList",
                  ),
                  builder: (context) => CourseCatList(
                    catName: Child.fromJson(subCatList[index]).title,
                    id: Child.fromJson(subCatList[index]).id.toString(),
                  ),
                ));
              },
              title: Child.fromJson(subCatList[index]).title,
              img:
                  "${config.mainUrl}/${Child.fromJson(subCatList[index]).appIcon}");
        }),
      ),
    );
  }
}
