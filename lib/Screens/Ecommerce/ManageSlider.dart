import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lumin_admin/API_Functions/Ecommerce/Sliders/addSlidersAPI.dart';
import 'package:lumin_admin/API_Functions/Ecommerce/Sliders/deleteSliders.dart';
import 'package:lumin_admin/API_Functions/Ecommerce/Sliders/getSlidersAPI.dart';
import 'package:lumin_admin/Components/appBar.dart';
import 'package:lumin_admin/Components/buttons.dart';
import 'package:lumin_admin/Components/textBox.dart';
import 'package:lumin_admin/Essentials/colors.dart';

class ManageEcommerceSlider extends StatefulWidget {
  @override
  _ManageEcommerceSliderState createState() => _ManageEcommerceSliderState();
}

class _ManageEcommerceSliderState extends State<ManageEcommerceSlider> {
  LearneeAppBar appBar = LearneeAppBar();
  @override
  TextEditingController sliderImage = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar.liveAppBar(
          title: "Slider Images",
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
                            hint: "Enter Image url",
                            label: "Image Url",
                            hideText: false,
                            textController: sliderImage,
                            icon: null),
                        LearneeRegLogButton(
                            action: () {
                              if (sliderImage.text.isNotEmpty) {
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
                                addEcommerceSliderImageAPI(context,
                                        imageurl: sliderImage.text)
                                    .then((value) {
                                  Navigator.pop(context);
                                  if (value != 'fail') {
                                    sliderImage.clear();
                                    Navigator.pop(context);
                                    Fluttertoast.showToast(
                                        msg: "Image Added",
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
                                    msg: "Image url is empty",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 14.0);
                              }
                            },
                            color: appBarColor,
                            text: "Add Image"),
                      ],
                    ),
                  ),
                ));
          }),
      backgroundColor: bgColor,
      body: FutureBuilder(
          future: getEcommerceSliderImagesAPI(),
          builder: (context, snapshot) {
            if (ConnectionState.done == snapshot.connectionState) {
              if (snapshot.hasData) {
                print(snapshot.data);
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
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 200,
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot.data[index]
                                          ["imageurl"],
                                      errorWidget: (context, url, error) {
                                        return Center(
                                          child: Icon(
                                            Icons.error,
                                            color: Colors.red,
                                          ),
                                        );
                                      },
                                      progressIndicatorBuilder:
                                          (context, url, progress) {
                                        return Center(
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        );
                                      },
                                      fit: BoxFit.fill,
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
                                                "Are you sure that you want to delete this Image?",
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

                                                    deleteEcommerceSLiderImagesAPI(
                                                            context,
                                                            id: snapshot
                                                                    .data[index]
                                                                ["id"])
                                                        .then((value) {
                                                      Navigator.of(context)
                                                          .pop();
                                                      if (value != 'fail') {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "Image Deleted",
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
                    child: Text("No Images"),
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
