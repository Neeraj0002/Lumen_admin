import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lumin_admin/API_Functions/Courses/DeleteCourse.dart';
import 'package:lumin_admin/API_Functions/Exam/getExamAPI.dart';
import 'package:lumin_admin/API_Functions/Featured_course/addFeaturedAPI.dart';
import 'package:lumin_admin/API_Functions/Featured_course/removeFeaturedAPI.dart';
import 'package:lumin_admin/API_Functions/Popular/addPopular.dart';
import 'package:lumin_admin/API_Functions/Popular/removePopular.dart';
import 'package:lumin_admin/Components/appBar.dart';
import 'package:lumin_admin/Components/buttons.dart';
import 'package:lumin_admin/Essentials/colors.dart';
import 'package:lumin_admin/Screens/AddExam.dart';
import 'package:lumin_admin/Screens/CourseDetails/FlashCards.dart';
import 'package:lumin_admin/Screens/CourseDetails/enrollScreen.dart';
import 'package:lumin_admin/Screens/CourseDetails/mentorProfile.dart';
import 'package:lumin_admin/Screens/QuizScreen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:video_player/video_player.dart';

class PurchasedCourseDetails extends StatefulWidget {
  var data;
  State parentKey;
  PurchasedCourseDetails({@required this.data, @required this.parentKey});
  @override
  _PurchasedCourseDetailsState createState() => _PurchasedCourseDetailsState();
}

class _PurchasedCourseDetailsState extends State<PurchasedCourseDetails>
    with TickerProviderStateMixin {
  TabController _tabController;
  int tabIndex = 0;
  bool featured = false;
  bool popular = false;
  LearneeAppBar appBar = LearneeAppBar();
  final videoPlayerController = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');

  ChewieController chewieController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          backgroundColor: bgColor,
          appBar: appBar.courseDetailsAppBar(
              tab1: "Resources",
              tab2: "Infromation",
              tab3: "Exam",
              tab4: "Manage",
              title: "Course Name",
              deleteAction: () {
                showDialog(
                    context: context,
                    child: AlertDialog(
                      content: Text(
                        "Are you sure that you want to delete this course?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: "OpenSans"),
                      ),
                      actions: [
                        FlatButton(
                          onPressed: () => Navigator.of(context).pop(),
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
                                            child: CircularProgressIndicator(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ));

                            deleteCourseAPI(context, id: widget.data["uid"])
                                .then((value) {
                              Navigator.of(context).pop();
                              if (value != 'fail') {
                                Navigator.of(context).pop();
                                Fluttertoast.showToast(
                                    msg: "Course Deleted",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: 14.0);
                                widget.parentKey.setState(() {});
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
              flashCardAction: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FlashCardScreen(show: true)));
              }),
          body: TabBarView(children: [
            VideoList(
              parent: this,
              data: widget.data,
            ),
            Information(parent: this, data: widget.data),
            Screen2(data: widget.data),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LearneeRegLogButton(
                        action: () {
                          if (widget.data['featured']) {
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
                            removeFeaturedAPI(context, id: widget.data['uid'])
                                .then((value) {
                              Navigator.of(context).pop();
                              if (value != 'fail') {
                                Navigator.of(context).pop();
                                Fluttertoast.showToast(
                                    msg: "Removed from featured",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 14.0);
                                widget.parentKey.setState(() {});
                              }
                            });
                          } else {
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
                            addFeaturedAPI(context, id: widget.data['uid'])
                                .then((value) {
                              Navigator.of(context).pop();
                              if (value != 'fail') {
                                Navigator.of(context).pop();
                                Fluttertoast.showToast(
                                    msg: "Added to featured",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: 14.0);
                                widget.parentKey.setState(() {});
                              }
                            });
                          }
                        },
                        color: appBarColor,
                        text: widget.data['featured']
                            ? "Remove from Featured"
                            : "Add to Featured")),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LearneeRegLogButton(
                        action: () {
                          if (widget.data['Popular']) {
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
                            removePopularAPI(context, id: widget.data['uid'])
                                .then((value) {
                              Navigator.of(context).pop();
                              if (value != 'fail') {
                                Navigator.of(context).pop();
                                Fluttertoast.showToast(
                                    msg: "Removed from featured",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 14.0);
                                widget.parentKey.setState(() {});
                              }
                            });
                          } else {
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
                            addPopularAPI(context, id: widget.data['uid'])
                                .then((value) {
                              Navigator.of(context).pop();
                              if (value != 'fail') {
                                Navigator.of(context).pop();
                                Fluttertoast.showToast(
                                    msg: "Added to popular",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: 14.0);
                                widget.parentKey.setState(() {});
                              }
                            });
                          }
                        },
                        color: appBarColor,
                        text: widget.data['Popular']
                            ? "Remove from Popular"
                            : "Add to Popular")),
              ],
            )
          ])),
    );
  }
}

// ignore: must_be_immutable
class VideoList extends StatefulWidget {
  _PurchasedCourseDetailsState parent;
  var data;
  VideoList({@required this.parent, @required this.data});
  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  VideoPlayerController videoPlayerController;

  ChewieController chewieController;
  int nowPlaying = 0;
  bool playing = false;
  pauseVideo() {
    chewieController.pause();
  }

  @override
  void initState() {
    if (widget.data["video"] != null) {
      print(widget.data["video"][nowPlaying]["url"]);
      videoPlayerController =
          VideoPlayerController.network(widget.data["video"][0]["url"]);
      chewieController = ChewieController(
          videoPlayerController: videoPlayerController,
          aspectRatio: 16 / 9,
          autoPlay: true,
          looping: true,
          deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
          fullScreenByDefault: false,
          overlay: Container(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Lumin",
                      style: TextStyle(
                          shadows: [
                            Shadow(color: Colors.black26, offset: Offset(1, 1))
                          ],
                          color: Colors.white.withOpacity(0.8),
                          fontFamily: "Roboto",
                          fontSize: 12),
                    ),
                  ),
                )
              ],
            ),
          ));
    } else {
      print("No data");
    }
    super.initState();
  }

  @override
  void dispose() {
    if (widget.data["video"] != null) {
      videoPlayerController.dispose();
      chewieController.dispose();
    }
    super.dispose();
  }

  @override
  void deactivate() {
    chewieController.pause();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return widget.data["video"] != null
        ? ListView(
            children: [
              Chewie(
                controller: chewieController,
              ),
              Column(
                children: [
                  Container(
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: screenWidth,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, right: 8.0),
                            child: Text(
                              widget.data["title"],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.black87,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: screenWidth,
                          child: Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Row(
                                children: [
                                  Icon(
                                    MdiIcons.clock,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    " 13:19 Min | User Experience",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: "Roboto",
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 16.0,
                              ),
                              child: Text(
                                "₹${widget.data["price"]}",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            /*Padding(
                          padding: const EdgeInsets.only(
                            right: 16.0,
                          ),
                          child: Row(
                            children: List.generate(5, (index) {
                              return Icon(
                                Icons.star_border,
                                color: Colors.amber,
                                size: 20,
                              );
                            }),
                          )),*/
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 10),
                    child: Container(
                      height: 0.5,
                      color: Colors.grey,
                    ),
                  ),
                  /*Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16),
              child: LayoutBuilder(builder: (context, constraints) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: Center(
                            child: Icon(
                              Icons.account_circle,
                              color: Colors.grey,
                              size: 45,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                            width: constraints.maxWidth * (0.45),
                            child: Text(
                              widget.data["tutor"],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: "Roboto",
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    /*InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          settings: RouteSettings(
                            name: "/mentorProfile",
                          ),
                          builder: (context) => MentorProfile(),
                        ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: buttonBgColor, width: 1),
                          borderRadius: BorderRadius.circular(80),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 6, 20, 6),
                            child: Text(
                              "Profile",
                              style: TextStyle(
                                  color: buttonBgColor,
                                  fontFamily: "Roboto",
                                  fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                    )*/
                  ],
                );
              }),
            )*/
                ],
              ),
              widget.data["video"] != null
                  ? Column(
                      children: List.generate(
                          widget.data["video"] == null
                              ? 0
                              : widget.data["video"].length, (index) {
                        return VideoListItem(
                          action: () {
                            setState(() {
                              if (nowPlaying == index) {
                                if (playing == true) {
                                  chewieController.pause();
                                  playing = false;
                                } else {
                                  chewieController.play();
                                  playing = true;
                                }
                              } else {
                                nowPlaying = index;
                                videoPlayerController =
                                    VideoPlayerController.network(
                                        widget.data["video"][0]["url"]);
                                chewieController = ChewieController(
                                    videoPlayerController:
                                        videoPlayerController,
                                    aspectRatio: 16 / 9,
                                    autoPlay: true,
                                    looping: true,
                                    deviceOrientationsAfterFullScreen: [
                                      DeviceOrientation.portraitUp
                                    ],
                                    fullScreenByDefault: false,
                                    overlay: Container(
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Lumin",
                                                style: TextStyle(
                                                    shadows: [
                                                      Shadow(
                                                          color: Colors.black26,
                                                          offset: Offset(1, 1))
                                                    ],
                                                    color: Colors.white
                                                        .withOpacity(0.8),
                                                    fontFamily: "Roboto",
                                                    fontSize: 12),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ));
                              }
                            });
                          },
                          icon: widget.data["video"][index]["demo"]
                              ? (playing ? MdiIcons.play : MdiIcons.pause)
                              : MdiIcons.lock,
                          title: widget.data["video"][index]["title"],
                          active: nowPlaying == index ? true : false,
                        );
                      }),
                    )
                  : Container(
                      child: Center(
                        child: Text("No resources available"),
                      ),
                    ),
            ],
          )
        : Center(
            child: Text("No resources available"),
          );
  }
}

class VideoListItem extends StatelessWidget {
  Function action;
  var icon;
  String title;
  bool active;
  VideoListItem({
    @required this.action,
    @required this.icon,
    @required this.title,
    @required this.active,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Column(
        children: [
          Container(
            color: active ? appBarColor : Colors.transparent,
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: LayoutBuilder(builder: (context, limits) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(
                          icon,
                          color: active ? Colors.white : Colors.black54,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: limits.maxWidth * (0.6),
                          child: Text(
                            title,
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            style: TextStyle(
                              color: active ? Colors.white : Colors.black54,
                              fontFamily: "Roboto",
                              fontSize: 14,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class Information extends StatefulWidget {
  _PurchasedCourseDetailsState parent;
  var data;
  Information({@required this.parent, @required this.data});

  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: LayoutBuilder(builder: (context, constraints) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.account_circle,
                            size: 45,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          width: constraints.maxWidth * (0.45),
                          child: Text(
                            widget.data["tutor"]["Name"],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: "Roboto",
                            ),
                          ),
                        ),
                      )
                    ],
                  ),

                  /*InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        settings: RouteSettings(
                          name: "/mentorProfile",
                        ),
                        builder: (context) => MentorProfile(),
                      ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: buttonBgColor, width: 1),
                        borderRadius: BorderRadius.circular(80),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 6, 20, 6),
                          child: Text(
                            "Profile",
                            style: TextStyle(
                                color: buttonBgColor,
                                fontFamily: "Roboto",
                                fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                  )*/
                ],
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
            child: Divider(
              color: Colors.black54,
              height: 2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Row(
                    children: [
                      Icon(
                        MdiIcons.clock,
                        color: Colors.grey,
                      ),
                      Text(
                        " ${widget.data['hours']}hrs | ${widget.data['category']}",
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: "Roboto",
                          fontSize: 14,
                        ),
                      ),
                    ],
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
            child: Divider(
              color: Colors.black54,
              height: 2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
            child: Text(
              widget.data["details"],
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Roboto",
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(
            height: 70,
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class CommentList extends StatefulWidget {
  _PurchasedCourseDetailsState parent;
  CommentList({@required this.parent});
  @override
  _CommentListState createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => widget.parent.setState(() {
              widget.parent.tabIndex = 2;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      children: List.generate(5, (index) {
        return index == 4
            ? Padding(
                padding: const EdgeInsets.only(bottom: 70.0),
                child: CommentListItem(),
              )
            : CommentListItem();
      }),
    );
  }
}

class CommentListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(color: Colors.black12, spreadRadius: 1, blurRadius: 2)
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "<Name Goes here>",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Roboto",
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "<Comment Goes here>",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: "Roboto",
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CourseSupport extends StatefulWidget {
  _PurchasedCourseDetailsState parent;
  CourseSupport({this.parent});
  @override
  _CourseSupportState createState() => _CourseSupportState();
}

class _CourseSupportState extends State<CourseSupport> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => widget.parent.setState(() {
              widget.parent.tabIndex = 3;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [],
    );
  }
}

class Screen2 extends StatefulWidget {
  var data;
  Screen2({@required this.data});
  @override
  _Screen2State createState() => _Screen2State(data);
}

class _Screen2State extends State<Screen2> {
  List _sortedList = List();
  var _data;
  _Screen2State(this._data);

  @override
  void initState() {
    //_sortList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
            future: getExamsAPI(widget.data['uid']),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  print(snapshot.data);
                  return snapshot.data['AllQuiz'] != null
                      ? ListView.builder(
                          itemCount: snapshot.data['AllQuiz'] == null
                              ? 0
                              : snapshot.data['AllQuiz'].length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        width: 2, color: Colors.black)),
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(PageRouteBuilder(
                                      pageBuilder: (_, __, ___) => QuizScreen(
                                        question: snapshot.data['AllQuiz']
                                            [index]['questions'],
                                        id: snapshot.data['AllQuiz'][index]
                                            ['id'],
                                      ),
                                    ));
                                  },
                                  child: Center(
                                    child: Text(
                                      "Exam ${index + 1}",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: "ProximaNova",
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          })
                      : Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              height: 50,
                              child: LearneeRegLogButton(
                                  action: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => AddExam(
                                                  parent: this,
                                                  courseId: widget.data['uid'],
                                                )));
                                  },
                                  color: appBarColor,
                                  text: "Add Exam"),
                            ),
                          ),
                        );
                } else {
                  return Container();
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            })
        /*: Center(
            child: Text("No test available"),
          )*/
        ;
  }
}
