import 'package:shared_preferences/shared_preferences.dart';

Future<bool> checkUserLoggedIn() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  // ignore: await_only_futures
  return await preferences.getBool("loggedIn");
}

Future getUserName() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  // ignore: await_only_futures
  return await preferences.getString("name");
}

Future getUserPhone() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  // ignore: await_only_futures
  return await preferences.getString("phone");
}

Future getUserEmail() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  // ignore: await_only_futures
  return await preferences.getString("email");
}

Future getUserGroup() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  // ignore: await_only_futures
  return await preferences.getString("userGroup");
}
