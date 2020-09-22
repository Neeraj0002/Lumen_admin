import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lumin_admin/API_Functions/apiConfig.dart';
import 'package:http/http.dart';

Future getCoursesByIdAPI(BuildContext context, String id) async {
  ApiConfig config = ApiConfig();
  final url = "${config.mainUrl}/api/v${config.version}/category";

  Map<String, String> body = {
    'Secret': config.secret,
    'id': id,
  };

  Response result;
  result = await post(url, body: json.encode(body), headers: {
    "Content-Type": "application/json",
    "Accept": "application/json"
  });

  if (result.statusCode == 200) {
    return result.body;
  } else {
    return "fail";
  }
}
