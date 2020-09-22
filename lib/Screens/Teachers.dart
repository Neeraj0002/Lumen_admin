import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lumin_admin/API_Functions/Teacher/approveTeacherAPI.dart';
import 'package:lumin_admin/API_Functions/Teacher/requestListAPI.dart';
import 'package:lumin_admin/Components/appBar.dart';
import 'package:lumin_admin/Components/buttons.dart';
import 'package:lumin_admin/Components/headingText.dart';
import 'package:lumin_admin/Essentials/colors.dart';

class Teachers extends StatefulWidget {
  @override
  _TeachersState createState() => _TeachersState();
}

class _TeachersState extends State<Teachers> {
  LearneeAppBar appBar = LearneeAppBar();

  _teacherCard(
      {@required Function action,
      @required String email,
      @required String name}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: action,
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 1,
                  blurRadius: 2,
                )
              ],
              borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    name,
                    style: TextStyle(
                      color: Colors.black87,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    email,
                    style: TextStyle(
                      color: Colors.black87,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar.simpleAppBar(title: "Teachers"),
      backgroundColor: bgColor,
      body: FutureBuilder(
          future: getTeacherRequestsAPI(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                print(snapshot.data);
                List _approved = List();
                List _pending = List();
                if (snapshot.data["Requests"] != null) {
                  for (int i = 0; i < snapshot.data["Requests"].length; i++) {
                    if (snapshot.data["Requests"][i]['status'] == 'approved') {
                      _approved.add(snapshot.data["Requests"][i]);
                    } else {
                      _pending.add(snapshot.data["Requests"][i]);
                    }
                  }
                }
                return ListView(
                  children: [
                    Column(
                      children: [
                        HeadingText(text: "PENDING"),
                        _pending.length != 0
                            ? Column(
                                children: List.generate(
                                    _pending.length,
                                    (index) => _teacherCard(
                                        action: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      TeacherDetails(
                                                          parent: this,
                                                          data: _pending[
                                                              index])));
                                        },
                                        email: _pending[index]['email'],
                                        name: _pending[index]['name'])),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("No requests found"),
                              )
                      ],
                    ),
                    Column(
                      children: [
                        HeadingText(text: "APPROVED"),
                        _approved.length != 0
                            ? Column(
                                children: List.generate(
                                    _approved.length,
                                    (index) => _teacherCard(
                                        action: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      TeacherDetails(
                                                          parent: this,
                                                          data: _approved[
                                                              index])));
                                        },
                                        email: _approved[index]['email'],
                                        name: _approved[index]['name'])),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("No requests approved"),
                              )
                      ],
                    )
                  ],
                );
              } else {
                return Container();
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

class TeacherDetails extends StatefulWidget {
  var data;
  _TeachersState parent;
  TeacherDetails({@required this.data, @required this.parent});
  @override
  _TeacherDetailsState createState() => _TeacherDetailsState();
}

class _TeacherDetailsState extends State<TeacherDetails> {
  LearneeAppBar appBar = LearneeAppBar();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar.simpleAppBar(title: "Teacher Details"),
      backgroundColor: bgColor,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              widget.data['name'],
              style: TextStyle(
                color: Colors.black87,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              widget.data['email'],
              style: TextStyle(
                color: Colors.black87,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              widget.data['phone'],
              style: TextStyle(
                color: Colors.black87,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              widget.data['desc'],
              style: TextStyle(
                color: Colors.black87,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
            ),
          ),
          widget.data['status'] != 'approved'
              ? LearneeRegLogButton(
                  action: () {
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

                    approveTeacherAPI(context, id: widget.data['id'])
                        .then((value) {
                      Navigator.pop(context);
                      if (value != 'fail') {
                        Navigator.pop(context);
                        Fluttertoast.showToast(
                            msg: "Approved",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 14.0);
                        widget.parent.setState(() {});
                      }
                    });
                    widget.parent.setState(() {});
                  },
                  color: Colors.green,
                  text: "APPROVE")
              : Container(),
        ],
      ),
    );
  }
}
