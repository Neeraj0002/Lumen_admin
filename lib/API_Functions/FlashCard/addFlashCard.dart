import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lumin_admin/API_Functions/apiConfig.dart';

Future addFlashCardAPI(BuildContext context,
    {@required String content, @required String answer}) async {
  final url = "$mainUrl2/flashcard";

  Map<String, dynamic> body = {'Content': content, 'answer': answer};

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
