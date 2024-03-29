import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lumin_admin/API_Functions/FlashCard/addFlashCard.dart';
import 'package:lumin_admin/API_Functions/FlashCard/deleteFlashCard.dart';
import 'package:lumin_admin/API_Functions/FlashCard/getFlashCards.dart';
import 'package:lumin_admin/Components/appBar.dart';
import 'package:lumin_admin/Components/buttons.dart';
import 'package:lumin_admin/Components/textBox.dart';
import 'package:lumin_admin/Essentials/colors.dart';
import 'package:lumin_admin/Essentials/getterFunctions.dart';

// ignore: must_be_immutable
class FlashCardScreen extends StatefulWidget {
  bool show;
  FlashCardScreen({@required this.show});
  @override
  _FlashCardScreenState createState() => _FlashCardScreenState();
}

class _FlashCardScreenState extends State<FlashCardScreen>
    with TickerProviderStateMixin {
  LearneeAppBar appBar = LearneeAppBar();
  TextEditingController content = TextEditingController();
  TextEditingController answer = TextEditingController();

  _flipCardItem(String content, String id, bool question) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, spreadRadius: 0.5, blurRadius: 1)
              ],
              gradient: LinearGradient(
                  tileMode: TileMode.mirror,
                  colors: [Colors.blue, Colors.purple, Colors.green],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  question ? "QUESTION" : "ANSWER",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  content,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        widget.show
            ? FutureBuilder(
                future: getUserGroup(),
                builder: (context, usergroupsnapshot) {
                  if (usergroupsnapshot.hasData) {
                    if (usergroupsnapshot.data == "teacher" ||
                        usergroupsnapshot.data == "admin") {
                      return Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          icon: Icon(Icons.delete),
                          color: Colors.red[200],
                          onPressed: () {
                            showDialog(
                                context: context,
                                child: AlertDialog(
                                  content: Text(
                                    "Are you sure that you want to delete this flash card?",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontFamily: "OpenSans"),
                                  ),
                                  actions: [
                                    FlatButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
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
                                        deleteLFlashCardAPI(context, id: id)
                                            .then((value) {
                                          Navigator.of(context).pop();
                                          if (value != 'fail') {
                                            Fluttertoast.showToast(
                                                msg: "Flash Card Deleted",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.SNACKBAR,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.black,
                                                textColor: Colors.white,
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
                      );
                    } else {
                      return Container();
                    }
                  } else {
                    return Container();
                  }
                },
              )
            : Container()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    CardController controller; //Use this to trigger swap.
    return new Scaffold(
      appBar: widget.show
          ? appBar.liveAppBar(
              addAction: () {
                showDialog(
                    context: context,
                    child: AlertDialog(
                      content: Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: ListView(
                          children: [
                            LearneeTextField(
                                hint: "Enter Content",
                                label: "Content",
                                hideText: false,
                                textController: content,
                                icon: null),
                            LearneeTextField(
                                hint: "Enter Answer",
                                label: "Answer",
                                hideText: false,
                                textController: answer,
                                icon: null),
                            LearneeRegLogButton(
                                action: () {
                                  if (content.text.isNotEmpty &&
                                      answer.text.isNotEmpty) {
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
                                    addFlashCardAPI(context,
                                            content: content.text,
                                            answer: answer.text)
                                        .then((value) {
                                      Navigator.pop(context);
                                      if (value != 'fail') {
                                        content.clear();
                                        answer.clear();
                                        Navigator.pop(context);
                                        Fluttertoast.showToast(
                                            msg: "Content Added",
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
                                    if (content.text.isEmpty) {
                                      Fluttertoast.showToast(
                                          msg: "Content is empty",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 14.0);
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Answer is empty",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 14.0);
                                    }
                                  }
                                },
                                color: appBarColor,
                                text: "Add Content"),
                          ],
                        ),
                      ),
                    ));
              },
              title: "Flash Cards")
          : appBar.simpleAppBar(title: "Flash Cards"),
      body: FutureBuilder(
          future: getFlashCardAPI(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                print(snapshot.data);
                return Stack(
                  children: [
                    RefreshIndicator(
                        child: ListView(
                          children: [],
                        ),
                        onRefresh: () async {
                          setState(() {});
                        }),
                    Center(
                      child: Text(
                        snapshot.data["All"] != null
                            ? "All Done !!\nSwipe down to refresh"
                            : "No cards added",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    new Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: new TinderSwapCard(
                          orientation: AmassOrientation.BOTTOM,
                          totalNum: snapshot.data["All"] == null
                              ? 0
                              : snapshot.data["All"].length,
                          stackNum: 3,
                          swipeEdge: 4.0,
                          maxWidth: MediaQuery.of(context).size.width * 0.9,
                          maxHeight: MediaQuery.of(context).size.width * 0.9,
                          minWidth: MediaQuery.of(context).size.width * 0.8,
                          minHeight: MediaQuery.of(context).size.width * 0.8,
                          cardBuilder: (context, index) {
                            return FlipCard(
                              speed: 200,
                              direction: FlipDirection.HORIZONTAL, // default
                              front: _flipCardItem(
                                  snapshot.data["All"][index]["content"],
                                  snapshot.data["All"][index]["id"],
                                  true),
                              back: _flipCardItem(
                                  snapshot.data["All"][index]["answer"],
                                  snapshot.data["All"][index]["id"],
                                  false),
                            );
                          },
                          cardController: controller = CardController(),
                          swipeUpdateCallback:
                              (DragUpdateDetails details, Alignment align) {
                            /// Get swiping card's alignment
                            if (align.x < 0) {
                              //print("Card is LEFT swiping");
                            } else if (align.x > 0) {
                              //print("Card is RIGHT swiping");
                            }
                          },
                          swipeCompleteCallback:
                              (CardSwipeOrientation orientation, int index) {
                            print(orientation.toString());
                            if (orientation == CardSwipeOrientation.LEFT) {
                            } else if (orientation ==
                                CardSwipeOrientation.RIGHT) {}
                          },
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Text("Will be added soon :)"),
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
