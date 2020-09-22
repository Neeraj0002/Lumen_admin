import 'dart:convert';

import 'package:http/http.dart';
import 'package:lumin_admin/API_Functions/apiConfig.dart';

Future searchDataAPI(query) async {
  ApiConfig config = ApiConfig();
  final url =
      "${config.mainUrl}/api/v${config.version}/product/search?q=$query";

  Response result;
  result = await get(url);
  var parsedData = jsonDecode(result.body);
  return parsedData;
}
