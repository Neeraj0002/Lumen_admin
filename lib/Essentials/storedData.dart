import 'package:shared_preferences/shared_preferences.dart';

Future getAllCourses() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("allCourses");
}
