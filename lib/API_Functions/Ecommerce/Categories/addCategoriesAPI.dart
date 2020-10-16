import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lumin_admin/API_Functions/apiConfig.dart';

Future addEcommerceCategoryAPI(
  BuildContext context, {
  @required String title,
  @required String img,
}) async {
  final url = "$mainUrl2/ecommerce/category";

  Map<String, dynamic> body = {'title': title, 'img': img};

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
