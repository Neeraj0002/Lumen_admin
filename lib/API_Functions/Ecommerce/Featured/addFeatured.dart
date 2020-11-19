import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lumin_admin/API_Functions/apiConfig.dart';

Future addEcommerceFeaturedAPI(
  BuildContext context, {
  @required String name,
  @required String img,
  @required int price,
  @required int offerprice,
  @required String discountRate,
  @required List images,
}) async {
  final url = "$mainUrl2/ecommerce/featured";

  Map<String, dynamic> body = {
    'name': name,
    'img': img,
    'price': price,
    'offer_prize': offerprice,
    'discount_rate': discountRate,
    'images': images
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
