import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lumin_admin/API_Functions/Category/addCategory.dart';
import 'package:lumin_admin/API_Functions/Category/deleteCategory.dart';
import 'package:lumin_admin/API_Functions/Category/getCategories.dart';
import 'package:lumin_admin/Components/appBar.dart';
import 'package:lumin_admin/Components/buttons.dart';
import 'package:lumin_admin/Components/textBox.dart';
import 'package:lumin_admin/Essentials/colors.dart';

class ManageCategory extends StatefulWidget {
  @override
  _ManageCategoryState createState() => _ManageCategoryState();
}

class _ManageCategoryState extends State<ManageCategory> {
  LearneeAppBar appBar = LearneeAppBar();
  TextEditingController category = TextEditingController();
  var result;
  @override
  void initState() {
    getCategoriesAPI().then((value) {
      print("DONE");
      setState(() {
        result = value;
      });
    });
    super.initState();
  }

  /* */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar.liveAppBar(
          title: "Categories",
          addAction: () {
            showDialog(
                context: context,
                child: AlertDialog(
                  content: Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                      children: [
                        LearneeTextField(
                            hint: "Enter Category Name",
                            label: "Category name",
                            hideText: false,
                            textController: category,
                            icon: null),
                        LearneeRegLogButton(
                            action: () {
                              if (category.text.isNotEmpty) {
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
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ));
                                addCategoryAPI(context, name: category.text)
                                    .then((value) {
                                  Navigator.pop(context);
                                  if (value != 'fail') {
                                    category.clear();
                                    Navigator.pop(context);
                                    Fluttertoast.showToast(
                                        msg: "Category Added",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.green,
                                        textColor: Colors.white,
                                        fontSize: 14.0);
                                    setState(() {});
                                  }
                                });
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Category name is empty",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 14.0);
                              }
                            },
                            color: appBarColor,
                            text: "Add Category"),
                      ],
                    ),
                  ),
                ));
          }),
      backgroundColor: bgColor,
      body: FutureBuilder(
          future: getCategoriesAPI(),
          builder: (context, snapshot) {
            if (ConnectionState.done == snapshot.connectionState) {
              if (snapshot.hasData) {
                return ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: List.generate(snapshot.data.length, (index) {
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
                                      blurRadius: 2)
                                ],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        (0.75),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${snapshot.data[index]["name"]}",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Roboto",
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: IconButton(
                                      icon: Icon(Icons.delete),
                                      color: Colors.red,
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            child: AlertDialog(
                                              content: Text(
                                                "Are you sure that you want to delete this Category?",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontFamily: "OpenSans"),
                                              ),
                                              actions: [
                                                FlatButton(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(),
                                                  child: Center(
                                                    child: Text(
                                                      "No",
                                                      style: TextStyle(
                                                        color: Colors.green,
                                                        fontFamily: "OpenSans",
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                FlatButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    showDialog(
                                                        context: context,
                                                        barrierDismissible:
                                                            false,
                                                        child: AlertDialog(
                                                          content: Container(
                                                            height: 80,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Center(
                                                                  child:
                                                                      Container(
                                                                    height: 30,
                                                                    width: 30,
                                                                    child:
                                                                        CircularProgressIndicator(),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ));

                                                    deleteCategoryAPI(context,
                                                            id: snapshot
                                                                    .data[index]
                                                                ["id"])
                                                        .then((value) {
                                                      Navigator.of(context)
                                                          .pop();
                                                      if (value != 'fail') {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "Category Deleted",
                                                            toastLength: Toast
                                                                .LENGTH_SHORT,
                                                            gravity:
                                                                ToastGravity
                                                                    .SNACKBAR,
                                                            timeInSecForIosWeb:
                                                                1,
                                                            backgroundColor:
                                                                Colors.black,
                                                            textColor:
                                                                Colors.white,
                                                            fontSize: 14.0);
                                                        setState(() {});
                                                      }
                                                    });
                                                  },
                                                  child: Text(
                                                    "Yes",
                                                    style: TextStyle(
                                                      color: appBarColor,
                                                      fontFamily: "OpenSans",
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ));
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.width * (0.9),
                    )
                  ],
                );
              } else {
                return Center(
                  child: Container(
                    child: Text("No Categories"),
                  ),
                );
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
