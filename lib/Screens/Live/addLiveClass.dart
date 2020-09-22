import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lumin_admin/API_Functions/LiveClasses/addLiveClasses.dart';
import 'package:lumin_admin/Components/appBar.dart';
import 'package:lumin_admin/Components/buttons.dart';
import 'package:lumin_admin/Components/textBox.dart';
import 'package:lumin_admin/Essentials/colors.dart';

class AddLiveClass extends StatefulWidget {
  var data;
  State parentKey;
  AddLiveClass({@required this.data, @required this.parentKey});
  @override
  _AddLiveClassState createState() => _AddLiveClassState();
}

class _AddLiveClassState extends State<AddLiveClass> {
  LearneeAppBar appBar = LearneeAppBar();
  TextEditingController description = TextEditingController();
  String courseName;
  DateTime pickedDate;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar.simpleAppBar(title: "Add Live Class"),
      backgroundColor: bgColor,
      bottomSheet: Container(
        height: 60,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: LearneeRegLogButton(
              action: () {
                if (description.text.isNotEmpty &&
                    courseName.isNotEmpty &&
                    pickedDate != null) {
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
                  addLiveClassAPI(context,
                          channel: null,
                          course: courseName,
                          time: pickedDate.toString(),
                          desc: description.text)
                      .then((value) {
                    Navigator.of(context).pop();
                    if (value != 'fail') {
                      Navigator.of(context).pop();
                      Fluttertoast.showToast(
                          msg: "Live class added",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 14.0);
                      widget.parentKey.setState(() {});
                    }
                  });
                } else {
                  Fluttertoast.showToast(
                      msg: "Please enter all data",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 14.0);
                }
              },
              color: appBarColor,
              text: "Submit"),
        ),
      ),
      body: ListView(
        children: [
          PopupMenuButton(
            itemBuilder: (context) => List.generate(
              widget.data.length,
              (index) => PopupMenuItem(
                value: widget.data[index]['title'],
                child: Text(widget.data[index]['title']),
              ),
            ),
            initialValue: null,
            onSelected: (value) async {
              FocusScope.of(context).requestFocus(new FocusNode());
              setState(() {
                courseName = value;
              });
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 0))
                    ]),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          courseName == null ? "Select Course" : courseName,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.arrow_drop_down,
                          size: 20,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          FlatButton(
            child: Container(
              height: 55,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12, spreadRadius: 1, blurRadius: 2)
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(pickedDate != null
                      ? pickedDate.toString()
                      : "Pick date and time"),
                ),
              ),
            ),
            onPressed: () {
              DatePicker.showDateTimePicker(context,
                  showTitleActions: true,
                  minTime: DateTime(DateTime.now().year - 5),
                  maxTime: DateTime(DateTime.now().year + 5),
                  onChanged: (date) {
                setState(() {
                  pickedDate = date;
                });
              }, onConfirm: (date) {
                setState(() {
                  pickedDate = date;
                });
              }, locale: LocaleType.en);
            },
          ),
          LearneeMultipleLineTextField(
              hint: "Description",
              label: "Description",
              textController: description,
              icon: null,
              noOfLines: 5),
        ],
      ),
    );
  }
}
