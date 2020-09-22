import 'package:flutter/material.dart';
import 'package:lumin_admin/Components/appBar.dart';
import 'package:lumin_admin/Screens/AddTeacher.dart';
import 'package:lumin_admin/Screens/UserDetails.dart';

// ignore: must_be_immutable
class Users extends StatefulWidget {
  String group;
  var data;
  String title;
  Users({@required this.data, @required this.group, @required this.title});
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  LearneeAppBar appBar = LearneeAppBar();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.group == 'teacher'
          ? appBar.liveAppBar(
              title: widget.title,
              addAction: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddTeacher(
                          parent: this,
                        )));
              })
          : appBar.simpleAppBar(title: widget.title),
      body: ListView.builder(
        itemCount: widget.data["Allusers"].length,
        itemBuilder: (context, index) {
          return widget.data["Allusers"][index]["Group"] == widget.group
              ? InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => UserDetails(
                              data: widget.data["Allusers"][index],
                            )));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.data["Allusers"][index]["Name"],
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              widget.data["Allusers"][index]["Email"],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              widget.data["Allusers"][index]["Phone"],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : Container();
        },
      ),
    );
  }
}
