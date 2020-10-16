import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:lumin_admin/API_Functions/apiConfig.dart';

Future deleteEcommerceCategoryAPI(BuildContext context,
    {@required String id}) async {
  final url = "$mainUrl2/ecommerce/category/$id";

  Response result;
  result = await delete(url, headers: {"Content-Type": "application/json"});

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
    return "fail";
  }
}
