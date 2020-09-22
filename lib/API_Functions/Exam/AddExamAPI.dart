import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lumin_admin/API_Functions/apiConfig.dart';

Future addExamAPI(BuildContext context,
    {@required String id, @required List questions, List resource}) async {
  final url = "$mainUrl2/quiz";

  Map<String, dynamic> body = {'courseid': id, 'questions': questions};

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
