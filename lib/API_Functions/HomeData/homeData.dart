import 'package:http/http.dart';
import 'package:lumin_admin/API_Functions/apiConfig.dart';

Future<Response> homeDataAPI() async {
  ApiConfig config = ApiConfig();
  final url = "${config.mainUrl}/api/v${config.version}/content";

  Response result;
  result = await get(url);
  return result;
}
