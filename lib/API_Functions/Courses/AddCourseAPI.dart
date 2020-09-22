import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lumin_admin/API_Functions/apiConfig.dart';

Future addCourseAPI(BuildContext context,
    {@required String courseName,
    @required String tutor,
    @required String tutorEmail,
    @required String price,
    @required String details,
    @required String thumbnail,
    @required String totalHours,
    @required String categoryName,
    @required List resource}) async {
  final url = "$mainUrl2/course";

  Map<String, dynamic> body = {
    'title': courseName,
    'price': price,
    'details': details,
    'video': resource,
    'thumbnail': thumbnail,
    'hours': totalHours,
    'tutor': {"Name": tutor, "Email": tutorEmail},
    'category': categoryName
  };

  print(body);

  Response result;
  result = await post(url,
      body: json.encode(body), headers: {"Content-Type": "application/json"});
  if (result.statusCode == 200) {
    return result.body;
  } else {
    print(result.statusCode);
    return "fail";
  }
}
