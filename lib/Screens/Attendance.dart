import 'package:flutter/material.dart';
import 'package:lumin_admin/API_Functions/Attendance/getAttendance.dart';
import 'package:lumin_admin/Components/appBar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Attendance extends StatefulWidget {
  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  LearneeAppBar appBar = LearneeAppBar();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar.simpleAppBar(title: "Attendance"),
        body: FutureBuilder(
          future: getAttendanceAPI(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return ListView(
                  children: List.generate(snapshot.data.length, (index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                AttendanceDetails(data: snapshot.data[index])));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              snapshot.data[index]['date'].toString().isNotEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Date: ${DateTime.parse(snapshot.data[index]['date']).hour}:${DateTime.parse(snapshot.data[index]['date']).minute} ,${DateTime.parse(snapshot.data[index]['date']).day}/${DateTime.parse(snapshot.data[index]['date']).month}/${DateTime.parse(snapshot.data[index]['date']).year}",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    )
                                  : Container(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Total Attended : ${snapshot.data[index]['attendance'].length}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                );
              } else {
                return Container();
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}

class AttendanceDetails extends StatefulWidget {
  var data;
  AttendanceDetails({this.data});
  @override
  _AttendanceDetailsState createState() => _AttendanceDetailsState();
}

class _AttendanceDetailsState extends State<AttendanceDetails> {
  LearneeAppBar appBar = LearneeAppBar();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar.simpleAppBar(
          title:
              "${DateTime.parse(widget.data['date']).hour}:${DateTime.parse(widget.data['date']).minute} ,${DateTime.parse(widget.data['date']).day}/${DateTime.parse(widget.data['date']).month}/${DateTime.parse(widget.data['date']).year}"),
      body: ListView(
        children: List.generate(widget.data['attendance'].length, (index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Card(
                  elevation: 2,
                  child: Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: constraints.maxWidth * (0.8),
                            child:
                                Text(widget.data['attendance'][index]['name']),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            widget.data['attendance'][index]['present']
                                ? Icons.done
                                : Icons.remove,
                            color: widget.data['attendance'][index]['present']
                                ? Colors.green
                                : Colors.red,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
