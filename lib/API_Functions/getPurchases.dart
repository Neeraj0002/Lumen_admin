import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

import 'apiConfig.dart';

Future getPurchasesAPI() async {
  final url = "$mainUrl2/purchase";

  Response result;
  result = await get(url);

  if (result.statusCode == 200) {
    return jsonDecode(result.body);
  } else {
    Fluttertoast.showToast(
        msg: result.statusCode.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0);
    return 'fail';
  }
}
