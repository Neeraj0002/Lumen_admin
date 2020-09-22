import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lumin_admin/API_Functions/Courses/AddCourseAPI.dart';
import 'package:lumin_admin/Components/appBar.dart';
import 'package:lumin_admin/Components/buttons.dart';
import 'package:lumin_admin/Components/textBox.dart';
import 'package:lumin_admin/Essentials/colors.dart';

class AddCourse extends StatefulWidget {
  var categories;
  AddCourse({@required this.categories});
  @override
  _AddCourseState createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  LearneeAppBar appBar = LearneeAppBar();
  List _parsedList = List();
  TextEditingController _resourceTitle = TextEditingController();
  TextEditingController _resourceUrl = TextEditingController();
  TextEditingController _courseName = TextEditingController();
  TextEditingController _tutorName = TextEditingController();
  TextEditingController _tutorEmail = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _details = TextEditingController();
  TextEditingController _thumbnailUrl = TextEditingController();
  TextEditingController _totalHours = TextEditingController();
  bool demoVideo;
  TextEditingController _editresourceTitle = TextEditingController();
  TextEditingController _editresourceUrl = TextEditingController();
  bool editdemoVideo;
  bool add = false;
  String categoryName;

  _resourceWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(1, 1))
            ],
            borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 8.0, 0, 8.0),
                child: Text(
                  "Resource",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black87,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
              ),
              LearneeTextField(
                  hint: "Enter Resource Title",
                  label: "Title",
                  hideText: false,
                  textController: _resourceTitle,
                  icon: null),
              LearneeTextField(
                  hint: "Enter Resource URL",
                  label: "Resource URL",
                  hideText: false,
                  textController: _resourceUrl,
                  icon: null),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 8.0, 0, 8.0),
                child: Text(
                  "Is this a demo video?",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black87,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
              ),
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: true,
                    child: Text("Yes"),
                  ),
                  PopupMenuItem(
                    value: false,
                    child: Text("No"),
                  ),
                ],
                initialValue: null,
                onSelected: (value) async {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  setState(() {
                    demoVideo = value;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 55,
                    //width: screenWidth * (0.8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 2,
                              blurRadius: 6,
                              offset: Offset(2, 2))
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              demoVideo == null
                                  ? "Select Yes or No"
                                  : (demoVideo ? "Yes" : "No"),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LearneeRegLogButton(
                    action: () {
                      if (_resourceTitle.text.isNotEmpty) {
                        if (_resourceUrl.text.isNotEmpty) {
                          if (demoVideo != null) {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            _parsedList.add({
                              "title": _resourceTitle.text,
                              "url": _resourceUrl.text,
                              "demo": demoVideo
                            });
                            setState(() {
                              _resourceTitle.clear();
                              _resourceUrl.clear();
                              add = false;
                              demoVideo = null;
                            });
                            print(_parsedList);
                          } else {
                            Fluttertoast.showToast(
                                msg: "You have not set demo video",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 14.0);
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg: "Resource URL is Empty",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 14.0);
                        }
                      } else {
                        Fluttertoast.showToast(
                            msg: "Resource Title is Empty",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 14.0);
                      }
                    },
                    color: appBarColor,
                    text: "Add Resource"),
              )
            ],
          ),
        ),
      ),
    );
  }

  _resourceView(int index, String title, String url, bool demo) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(1, 1))
            ],
            borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 8.0, 0, 0.0),
                child: Text(
                  "Resource $index",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black87,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 8.0, 0, 0.0),
                child: Text(
                  title,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black87,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 8.0, 0, 0.0),
                child: Text(
                  url,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black87,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 8.0, 0, 8.0),
                    child: Text(
                      "Demo Video : $demo",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black87,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        tooltip: "Delete",
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () {
                          setState(() {
                            _parsedList.removeAt(index - 1);
                          });
                        },
                      ),
                      IconButton(
                        tooltip: "Edit",
                        icon: Icon(Icons.edit),
                        color: Colors.blue,
                        onPressed: () {
                          setState(() {
                            _editresourceTitle.text = title;
                            _editresourceUrl.text = url;
                            editdemoVideo = demo;
                          });
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Container(
                                  height: 350,
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            16.0, 8.0, 0, 8.0),
                                        child: Text(
                                          "Resource",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontFamily: "Roboto",
                                            fontWeight: FontWeight.w800,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      LearneeTextField(
                                          hint: "Enter Resource Title",
                                          label: "Title",
                                          hideText: false,
                                          textController: _editresourceTitle,
                                          icon: null),
                                      LearneeTextField(
                                          hint: "Enter Resource URL",
                                          label: "Resource URL",
                                          hideText: false,
                                          textController: _editresourceUrl,
                                          icon: null),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            16.0, 8.0, 0, 8.0),
                                        child: Text(
                                          "Is this a demo video?",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontFamily: "Roboto",
                                            fontWeight: FontWeight.w800,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      PopupMenuButton(
                                        itemBuilder: (context) => [
                                          PopupMenuItem(
                                            value: true,
                                            child: Text("Yes"),
                                          ),
                                          PopupMenuItem(
                                            value: false,
                                            child: Text("No"),
                                          ),
                                        ],
                                        initialValue: null,
                                        onSelected: (value) async {
                                          FocusScope.of(context)
                                              .requestFocus(new FocusNode());
                                          setState(() {
                                            editdemoVideo = value;
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 55,
                                            //width: screenWidth * (0.8),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15.0)),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black12,
                                                      spreadRadius: 2,
                                                      blurRadius: 6,
                                                      offset: Offset(2, 2))
                                                ]),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Text(
                                                      editdemoVideo == null
                                                          ? "Select Yes or No"
                                                          : (editdemoVideo
                                                              ? "Yes"
                                                              : "No"),
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8.0),
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
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: LearneeRegLogButton(
                                            action: () {
                                              if (_editresourceTitle
                                                  .text.isNotEmpty) {
                                                if (_editresourceUrl
                                                    .text.isNotEmpty) {
                                                  if (editdemoVideo != null) {
                                                    FocusScope.of(context)
                                                        .requestFocus(
                                                            new FocusNode());

                                                    setState(() {
                                                      _parsedList[index - 1]
                                                              ["title"] =
                                                          _editresourceTitle
                                                              .text;
                                                      _parsedList[index - 1]
                                                              ["url"] =
                                                          _editresourceUrl.text;
                                                      _parsedList[index - 1]
                                                              ["demo"] =
                                                          editdemoVideo;
                                                      _editresourceTitle
                                                          .clear();
                                                      _editresourceUrl.clear();
                                                      editdemoVideo = null;
                                                    });
                                                    Navigator.pop(context);

                                                    print(_parsedList);
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "Resource $index edited",
                                                        toastLength:
                                                            Toast.LENGTH_SHORT,
                                                        gravity:
                                                            ToastGravity.BOTTOM,
                                                        timeInSecForIosWeb: 1,
                                                        backgroundColor:
                                                            Colors.green,
                                                        textColor: Colors.white,
                                                        fontSize: 14.0);
                                                  } else {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "You have not set demo video",
                                                        toastLength:
                                                            Toast.LENGTH_SHORT,
                                                        gravity:
                                                            ToastGravity.BOTTOM,
                                                        timeInSecForIosWeb: 1,
                                                        backgroundColor:
                                                            Colors.red,
                                                        textColor: Colors.white,
                                                        fontSize: 14.0);
                                                  }
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Resource URL is Empty",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.BOTTOM,
                                                      timeInSecForIosWeb: 1,
                                                      backgroundColor:
                                                          Colors.red,
                                                      textColor: Colors.white,
                                                      fontSize: 14.0);
                                                }
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Resource Title is Empty",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors.red,
                                                    textColor: Colors.white,
                                                    fontSize: 14.0);
                                              }
                                            },
                                            color: appBarColor,
                                            text: "Edit Resource"),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar.simpleAppBar(title: "Add Course"),
      backgroundColor: bgColor,
      bottomSheet: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: LearneeRegLogButton(
              action: () {
                if (_courseName.text.isNotEmpty &&
                    _tutorName.text.isNotEmpty &&
                    _tutorEmail.text.isNotEmpty &&
                    _price.text.isNotEmpty &&
                    _details.text.isNotEmpty &&
                    _thumbnailUrl.text.isNotEmpty &&
                    _totalHours.text.isNotEmpty &&
                    categoryName.isNotEmpty) {
                  if (_parsedList.isNotEmpty) {
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
                    addCourseAPI(context,
                            courseName: _courseName.text,
                            tutor: _tutorName.text,
                            price: _price.text,
                            details: _details.text,
                            tutorEmail: _tutorEmail.text,
                            thumbnail: _thumbnailUrl.text,
                            totalHours: _totalHours.text,
                            resource: _parsedList,
                            categoryName: categoryName)
                        .then((value) {
                      Navigator.of(context).pop();
                      if (value != "fail") {
                        Navigator.of(context).pop();
                        Fluttertoast.showToast(
                            msg: "Course Succesfully Added",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 14.0);
                      } else {
                        Fluttertoast.showToast(
                            msg: "Failed",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 14.0);
                      }
                    });
                  } else {
                    Fluttertoast.showToast(
                        msg: "No resources have been added",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 14.0);
                  }
                } else {
                  Fluttertoast.showToast(
                      msg: "All the fields are compulsary",
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
          LearneeTextField(
              hint: "Enter Course Name",
              label: "Course Name",
              hideText: false,
              textController: _courseName,
              icon: null),
          PopupMenuButton(
            itemBuilder: (context) => List.generate(
              widget.categories.length,
              (index) => PopupMenuItem(
                value: widget.categories[index]['name'],
                child: Text(widget.categories[index]['name']),
              ),
            ),
            initialValue: null,
            onSelected: (value) async {
              FocusScope.of(context).requestFocus(new FocusNode());
              setState(() {
                categoryName = value;
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
                          categoryName == null
                              ? "Select Category"
                              : categoryName,
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
          LearneeTextField(
              hint: "Enter Tutor Name",
              label: "Tutor Name",
              hideText: false,
              textController: _tutorName,
              icon: null),
          LearneeTextField(
              hint: "Enter Tutor Email",
              label: "Tutor Email",
              hideText: false,
              textController: _tutorEmail,
              icon: null),
          LearneeTextField(
              hint: "Enter Price",
              label: "Price",
              hideText: false,
              textController: _price,
              icon: null),
          LearneeMultipleLineTextField(
              hint: "Enter Details",
              label: "Details",
              noOfLines: 5,
              textController: _details,
              icon: null),
          LearneeTextField(
              hint: "Enter Thumbnail Url",
              label: "Thumbnail Url",
              hideText: false,
              textController: _thumbnailUrl,
              icon: null),
          LearneeTextField(
              hint: "Enter Total Hours",
              label: "Total Hours",
              hideText: false,
              textController: _totalHours,
              icon: null),
          !add
              ? Center(
                  child: FlatButton(
                    onPressed: () {
                      setState(() {
                        add = true;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                          child: Text(
                            "Add resource",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
          add ? _resourceWidget() : Container(),
          Column(
            children: List.generate(_parsedList.length, (index) {
              return _resourceView(index + 1, _parsedList[index]["title"],
                  _parsedList[index]["url"], _parsedList[index]["demo"]);
            }),
          ),
          SizedBox(
            height: 80,
          )
        ],
      ),
    );
  }
}
