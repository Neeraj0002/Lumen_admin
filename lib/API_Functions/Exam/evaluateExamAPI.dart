import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:lumin_admin/API_Functions/apiConfig.dart';

Future evaluateExamAPI(
  BuildContext context, {
  @required String uid,
  @required List answers,
}) async {
  final url = "$mainUrl2/quiz/evaluate";

  Map<String, dynamic> body = {
    'quizid': uid,
    'answers': answers,
  };

  print(body);

  Response result;
  result = await post(url,
      body: json.encode(body), headers: {"Content-Type": "application/json"});
  if (result.statusCode == 200) {
    print(result.body);
    return jsonDecode(result.body);
  } else {
    Fluttertoast.showToast(
        msg: result.statusCode.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 14.0);
    return "fail";
  }
}
