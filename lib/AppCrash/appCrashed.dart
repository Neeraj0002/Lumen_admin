import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lumin_admin/Essentials/colors.dart';

class AppCrashed extends StatefulWidget {
  @override
  _AppCrashedState createState() => _AppCrashedState();
}

class _AppCrashedState extends State<AppCrashed> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: appBarColor,
        systemNavigationBarIconBrightness: Brightness.light));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: appBarColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              ": (",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Roboto",
                fontSize: 120,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Our Server is facing some issues\nWe'll be back soon.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white, fontFamily: "Roboto", fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
