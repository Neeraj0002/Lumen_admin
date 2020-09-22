import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lumin_admin/API_Functions/HomeData/Search/SearchData.dart';
import 'package:lumin_admin/API_Functions/courseListModel.dart';
import 'package:lumin_admin/Components/appBar.dart';
import 'package:lumin_admin/Components/courseCard.dart';
import 'package:lumin_admin/Essentials/colors.dart';
import 'package:lumin_admin/Essentials/storedData.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  LearneeAppBar appBar = LearneeAppBar();
  TextEditingController searchController = TextEditingController();
  FocusNode searchNode = FocusNode();
  var _data;
  List _sorted;
  Future sortData(String keyword) async {
    _sorted = List();
    for (int i = 0; i < _data["AllCourses"].length; i++) {
      print(_data["AllCourses"][i]["title"].toLowerCase());
      if (_data["AllCourses"][i]["title"].toLowerCase().contains(keyword)) {
        _sorted.add(_data["AllCourses"][i]);
      }
    }
    return _sorted;
  }

  @override
  void initState() {
    searchNode.requestFocus();
    getAllCourses().then((value) {
      setState(() {
        _data = jsonDecode(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: appBar.searchAppBar(
            node: searchNode,
            closeAction: () {
              setState(() {
                searchController.clear();
              });
            },
            controller: searchController,
            onEdit: (value) {
              setState(() {});
            },
            onSubmitted: (value) {
              setState(() {});
            }),
        body: FutureBuilder(
            future: sortData(searchController.text.toLowerCase()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                if (snapshot.data.length != 0) {
                  return searchController.text.length != 0
                      ? ListView(
                          children:
                              List.generate(snapshot.data.length, (index) {
                            return CourseCard2(
                              featured: snapshot.data[index]['featured'],
                              popular: snapshot.data[index]['Popular'],
                              action: () {},
                              title: snapshot.data[index]["title"],
                              price: "₹${snapshot.data[index]["price"]}",
                              time: snapshot.data[index]["hours"],
                              imgUrl: snapshot.data[index]["thumbnail"],
                            );
                          }),
                        )
                      : Container(
                          height: 0,
                          width: 0,
                        );
                } else {
                  return Center(
                    child: Text("No results found"),
                  );
                }
              } else {
                return searchController.text.length != 0
                    ? Center(
                        child: Text("No results found"),
                      )
                    : Container(
                        height: 0,
                        width: 0,
                      );
              }
            }),
      ),
    );
  }
}
