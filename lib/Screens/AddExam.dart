import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lumin_admin/API_Functions/Exam/AddExamAPI.dart';
import 'package:lumin_admin/Components/appBar.dart';
import 'package:lumin_admin/Components/buttons.dart';
import 'package:lumin_admin/Components/textBox.dart';
import 'package:lumin_admin/Essentials/colors.dart';
import 'package:lumin_admin/Essentials/getterFunctions.dart';
import 'package:lumin_admin/Components/appBar.dart';

class AddExam extends StatefulWidget {
  String courseId;
  State parent;
  AddExam({@required this.courseId, @required this.parent});
  @override
  _AddExamState createState() => _AddExamState();
}

class _AddExamState extends State<AddExam> {
  LearneeAppBar appBar = LearneeAppBar();
  List _parsedList = List();
  TextEditingController _question = TextEditingController();
  TextEditingController _answer = TextEditingController();
  TextEditingController _option1 = TextEditingController();
  TextEditingController _option2 = TextEditingController();
  TextEditingController _option3 = TextEditingController();
  TextEditingController _option4 = TextEditingController();

  TextEditingController _editquestion = TextEditingController();
  TextEditingController _editanswer = TextEditingController();
  TextEditingController _editoption1 = TextEditingController();
  TextEditingController _editoption2 = TextEditingController();
  TextEditingController _editoption3 = TextEditingController();
  TextEditingController _editoption4 = TextEditingController();
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
              LearneeMultipleLineTextField(
                  hint: "Enter question",
                  label: "Question",
                  noOfLines: 2,
                  textController: _question,
                  icon: null),
              LearneeTextField(
                  hint: "Enter Correct Answer",
                  label: "Correct Answer",
                  hideText: false,
                  textController: _answer,
                  icon: null),
              LearneeTextField(
                  hint: "Enter Option 1",
                  label: "Option 1",
                  hideText: false,
                  textController: _option1,
                  icon: null),
              LearneeTextField(
                  hint: "Enter Option 2",
                  label: "Option 2",
                  hideText: false,
                  textController: _option2,
                  icon: null),
              LearneeTextField(
                  hint: "Enter Option 3",
                  label: "Option 3",
                  hideText: false,
                  textController: _option3,
                  icon: null),
              LearneeTextField(
                  hint: "Enter Option 4",
                  label: "Option 4",
                  hideText: false,
                  textController: _option4,
                  icon: null),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LearneeRegLogButton(
                    action: () {
                      if (_question.text.isNotEmpty) {
                        if (_answer.text.isNotEmpty) {
                          if (_option1.text.isNotEmpty &&
                              _option2.text.isNotEmpty &&
                              _option3.text.isNotEmpty &&
                              _option4.text.isNotEmpty) {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            _parsedList.add({
                              "question": _question.text,
                              "answer": _answer.text,
                              "options": [
                                {"option": _option1.text},
                                {"option": _option2.text},
                                {"option": _option3.text},
                                {"option": _option4.text}
                              ]
                            });
                            setState(() {
                              _answer.clear();
                              _question.clear();
                              _option1.clear();
                              _option2.clear();
                              _option3.clear();
                              _option4.clear();
                              add = false;
                            });
                          } else {
                            Fluttertoast.showToast(
                                msg: "Please enter all four options",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 14.0);
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg: "Answer is Empty",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 14.0);
                        }
                      } else {
                        Fluttertoast.showToast(
                            msg: "Question is Empty",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 14.0);
                      }
                    },
                    color: appBarColor,
                    text: "Add Question"),
              )
            ],
          ),
        ),
      ),
    );
  }

  _resourceView(int index, String question, String answer, String option1,
      String option2, String option3, String option4) {
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
                  "Question:-\nquestion",
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
                  "Correct Answer:-\n$answer",
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
                padding: const EdgeInsets.fromLTRB(16.0, 8.0, 0, 8.0),
                child: Text(
                  "Option 1 : $option1",
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
                padding: const EdgeInsets.fromLTRB(16.0, 8.0, 0, 8.0),
                child: Text(
                  "Option 2 : $option2",
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
                padding: const EdgeInsets.fromLTRB(16.0, 8.0, 0, 8.0),
                child: Text(
                  "Option 3 : $option3",
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
                padding: const EdgeInsets.fromLTRB(16.0, 8.0, 0, 8.0),
                child: Text(
                  "Option 4 : $option4",
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
                            _editquestion.text = question;
                            _editanswer.text = answer;
                            _editoption1.text = option1;
                            _editoption2.text = option2;
                            _editoption3.text = option3;
                            _editoption4.text = option4;
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
                                      LearneeMultipleLineTextField(
                                          hint: "Enter question",
                                          label: "Question",
                                          noOfLines: 2,
                                          textController: _editquestion,
                                          icon: null),
                                      LearneeTextField(
                                          hint: "Enter Option 1",
                                          label: "Option 1",
                                          hideText: false,
                                          textController: _editoption1,
                                          icon: null),
                                      LearneeTextField(
                                          hint: "Enter Option 2",
                                          label: "Option 2",
                                          hideText: false,
                                          textController: _editoption2,
                                          icon: null),
                                      LearneeTextField(
                                          hint: "Enter Option 3",
                                          label: "Option 3",
                                          hideText: false,
                                          textController: _editoption3,
                                          icon: null),
                                      LearneeTextField(
                                          hint: "Enter Option 4",
                                          label: "Option 4",
                                          hideText: false,
                                          textController: _editoption4,
                                          icon: null),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: LearneeRegLogButton(
                                            action: () {
                                              if (_editquestion
                                                  .text.isNotEmpty) {
                                                if (_editanswer
                                                    .text.isNotEmpty) {
                                                  if (_editoption1.text.isNotEmpty &&
                                                      _editoption2
                                                          .text.isNotEmpty &&
                                                      _editoption3
                                                          .text.isNotEmpty &&
                                                      _editoption4
                                                          .text.isNotEmpty) {
                                                    FocusScope.of(context)
                                                        .requestFocus(
                                                            new FocusNode());
                                                    _parsedList.add({
                                                      "question":
                                                          _question.text,
                                                      "answer": _answer.text,
                                                      "options": [
                                                        {
                                                          "option1":
                                                              _editoption1.text
                                                        },
                                                        {
                                                          "option2":
                                                              _editoption2.text
                                                        },
                                                        {
                                                          "option3":
                                                              _editoption3.text
                                                        },
                                                        {
                                                          "option4":
                                                              _editoption4.text
                                                        }
                                                      ]
                                                    });
                                                    setState(() {
                                                      _editanswer.clear();
                                                      _editquestion.clear();
                                                      _editoption1.clear();
                                                      _editoption2.clear();
                                                      _editoption3.clear();
                                                      _editoption4.clear();
                                                      add = false;
                                                    });
                                                  } else {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "Please enter all four options",
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
                                                      msg: "Answer is Empty",
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
                                                    msg: "Question is Empty",
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
                                            text: "Add Question"),
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
      body: ListView(
        children: [
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
                            "Add Question",
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
              return _resourceView(
                  index + 1,
                  _parsedList[index]["question"],
                  _parsedList[index]["answer"],
                  _parsedList[index]["options"][0]["option"],
                  _parsedList[index]["options"][1]["option"],
                  _parsedList[index]["options"][2]["option"],
                  _parsedList[index]["options"][3]["option"]);
            }),
          ),
          _parsedList.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(45, 16, 45, 16),
                  child: LearneeRegLogButton(
                      action: () {
                        if (widget.courseId.isNotEmpty) {
                          if (_parsedList.isNotEmpty) {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                child: AlertDialog(
                                  content: Container(
                                    height: 80,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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

                            addExamAPI(context,
                                    id: widget.courseId, questions: _parsedList)
                                .then((value) {
                              Navigator.of(context).pop();
                              if (value != "fail") {
                                Navigator.of(context).pop();
                                Fluttertoast.showToast(
                                    msg: "Exam Added",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 14.0);
                                widget.parent.setState(() {});
                              }
                            });
                          } else {
                            Fluttertoast.showToast(
                                msg: "No questions have been added",
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
                      text: "Submit"))
              : Container(),
        ],
      ),
    );
  }
}
