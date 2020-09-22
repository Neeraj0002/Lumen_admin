import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lumin_admin/API_Functions/LiveClasses/deleteLiveClasses.dart';
import 'package:lumin_admin/Components/appBar.dart';
import 'package:lumin_admin/Components/buttons.dart';
import 'package:lumin_admin/Components/headingText.dart';
import 'package:lumin_admin/Essentials/colors.dart';
import 'package:lumin_admin/constants.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LiveClassDetails extends StatefulWidget {
  final String time;
  final String courseName;
  final String channelName;
  final String desc;
  State parent;
  LiveClassDetails({
    @required this.desc,
    @required this.parent,
    @required this.courseName,
    @required this.time,
    @required this.channelName,
  });
  @override
  _LiveClassDetailsState createState() => _LiveClassDetailsState();
}

class _LiveClassDetailsState extends State<LiveClassDetails> {
  LearneeAppBar appBar = LearneeAppBar();
  Future setUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Constants.myName = prefs.getString("userName");
    Constants.email = prefs.getString("userEmail");
    return "done";
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }

  @override
  void initState() {
    setUserName().then((value) => setState(() {}));
    super.initState();
  }

  //final PermissionHandler _permissionHandler = PermissionHandler();
  @override
  Widget build(BuildContext context) {
    print(Constants.myName);
    return Scaffold(
      appBar: appBar.simpleAppBar(title: widget.courseName),
      bottomSheet: Container(
        height: 60,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: LearneeRegLogButton(
              action: () async {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    child: AlertDialog(
                      content: Container(
                        height: 80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Container(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ));
                deleteLiveClassAPI(context, id: widget.channelName)
                    .then((value) {
                  Navigator.of(context).pop();
                  if (value != 'fail') {
                    Navigator.of(context).pop();
                    Fluttertoast.showToast(
                        msg: "Deleted",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 14.0);
                    widget.parent.setState(() {});
                  }
                });
              },
              color: Colors.red,
              text: "Delete this class"),
        ),
      ),
      backgroundColor: bgColor,
      body: ListView(
        children: [
          HeadingText(
            text: widget.courseName,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0),
            child: Text(
              widget.time,
              style: TextStyle(
                  color: Colors.black87, fontFamily: "OpenSans", fontSize: 14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Divider(
              color: Colors.black45,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0),
            child: Text(
              widget.desc,
              style: TextStyle(
                  color: Colors.black87, fontFamily: "OpenSans", fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
