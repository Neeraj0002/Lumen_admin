import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:lumin_admin/API_Functions/apiConfig.dart';

Future addPopularAPI(BuildContext context, {@required String id}) async {
  final url = "$mainUrl2/course/popular";

  Map<String, dynamic> body = {
    'id': id,
  };

  Response result;
  result = await post(url,
      body: json.encode(body), headers: {"Content-Type": "application/json"});
  if (result.statusCode == 200) {
    return result.body;
  } else {
    Fluttertoast.showToast(
        msg: result.statusCode.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0);
    print(result.statusCode);
    return "fail";
  }
}
