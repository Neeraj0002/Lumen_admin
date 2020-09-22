import 'package:http/http.dart';

Future<Response> dummyDataAPI() async {
  final url = "https://my-json-server.typicode.com/Neeraj0002/dummy_data/db";

  Response result;
  result = await get(url);
  return result;
}
