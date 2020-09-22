import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lumin_admin/API_Functions/apiConfig.dart';

Future loginAPI(BuildContext context, String username, String password) async {
  final url = "$mainUrl2/login";

  Map<String, String> body = {
    'Email': username,
    'Pass': password,
  };

  Response result;
  result = await post(url,
      body: json.encode(body), headers: {"Content-Type": "application/json"});

  if (result.statusCode == 200) {
    if (result.body != "false") {
      return result.body;
    } else {
      return "fail";
    }
  } else {
    return "fail";
  }
}
