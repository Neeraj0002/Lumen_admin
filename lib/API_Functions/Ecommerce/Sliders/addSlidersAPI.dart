import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lumin_admin/API_Functions/apiConfig.dart';

Future addEcommerceSliderImageAPI(
  BuildContext context, {
  @required String imageurl,
}) async {
  final url = "$mainUrl2/ecommerce/slider";
  print(url);
  Map<String, dynamic> body = {
    'imageurl': imageurl,
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
