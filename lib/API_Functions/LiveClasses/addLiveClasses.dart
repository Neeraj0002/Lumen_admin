import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lumin_admin/API_Functions/apiConfig.dart';

Future addLiveClassAPI(
  BuildContext context, {
  @required String channel,
  @required String course,
  @required String time,
  @required String desc,
}) async {
  final url = "$mainUrl2/class";

  Map<String, dynamic> body = {
    'course': course,
    'time': time,
    'description': desc
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
