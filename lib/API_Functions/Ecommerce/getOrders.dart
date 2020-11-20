import 'package:http/http.dart';
import 'package:lumin_admin/API_Functions/apiConfig.dart';

Future viewOrder() async {
  final url = "$mainUrl2/ecommerce/order";
  print(url);
  Response result;
  result = await get(url);
  if (result.statusCode == 200) {
    return result.body;
  } else {
    return 'fail';
  }
}
