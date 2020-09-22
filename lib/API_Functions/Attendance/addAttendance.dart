import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lumin_admin/API_Functions/apiConfig.dart';

Future addAttendanceAPI(BuildContext context,
    {@required String classId,
    @required List attendance,
    @required String courseId,
    @required String date}) async {
  final url = "$mainUrl2/attendance";

  Map<String, dynamic> body = {
    'courseId': courseId,
    'attendance': attendance,
    'classId': classId,
    'date': date
  };

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
