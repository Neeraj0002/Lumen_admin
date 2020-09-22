import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lumin_admin/Components/appBar.dart';
import 'package:lumin_admin/Components/buttons.dart';
import 'package:lumin_admin/Essentials/colors.dart';
import 'package:lumin_admin/Screens/CourseDetails/FlashCards.dart';
import 'package:lumin_admin/Screens/CourseDetails/enrollScreen.dart';
import 'package:lumin_admin/Screens/CourseDetails/mentorProfile.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:video_player/video_player.dart';

class CourseDetails extends StatefulWidget {
  @override
  _CourseDetailsState createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails>
    with TickerProviderStateMixin {
  TabController _tabController;
  int tabIndex = 0;
  onTabChanged() {
    switch (tabIndex) {
      case 0:
        return Container(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
            child: LearneeRegLogButton(
                action: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    settings: RouteSettings(
                      name: "/enroll",
                    ),
                    builder: (context) => Enroll(),
                  ));
                },
                color: buttonBgColor,
                text: "Enroll on the course"),
          ),
        );
        break;
      case 1:
        return Container(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
            child: LearneeRegLogButton(
                action: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    settings: RouteSettings(
                      name: "/enroll",
                    ),
                    builder: (context) => Enroll(),
                  ));
                },
                color: buttonBgColor,
                text: "Enroll on the course"),
          ),
        );
        break;
      case 2:
        return Container(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
            child: LearneeRegLogButton(
                action: () {}, color: buttonBgColor, text: "Write a review"),
          ),
        );
        break;
      case 3:
        return Container(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
            child: LearneeRegLogButton(
                action: () {},
                color: Colors.black45,
                text: "Course not supported"),
          ),
        );
        break;
    }
  }

  LearneeAppBar appBar = LearneeAppBar();
  final videoPlayerController = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');

  ChewieController chewieController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
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
                    "Torc Infotech",
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
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: appBar.simpleAppBar(
        title: "Course Name",
      ),
      bottomSheet: onTabChanged(),
      body: ListView(
        physics: ScrollPhysics(),
        shrinkWrap: true,
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
                        padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                        child: Text(
                          "<Course Name Goes Here>",
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 16.0,
                          ),
                          child: Text(
                            "₹250",
                            style: TextStyle(
                              color: Colors.green,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
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
                            )),
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
              Padding(
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
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "https://i.pinimg.com/originals/a4/58/91/a45891b8705f918291eaf248d40edabd.jpg"),
                                    fit: BoxFit.cover)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Container(
                              width: constraints.maxWidth * (0.45),
                              child: Text(
                                "<Name Goes Here>",
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
                      InkWell(
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
                      )
                    ],
                  );
                }),
              )
            ],
          ),
          Column(
            children: [
              TabBar(
                controller: _tabController,
                indicatorColor: appBarColor,
                onTap: (value) {
                  setState(() {
                    tabIndex = value;
                  });
                },
                labelColor: appBarColor,
                unselectedLabelColor: Colors.grey,
                labelStyle: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
                tabs: [
                  Tab(
                    text: "Courses",
                  ),
                  Tab(
                    text: "Information",
                  ),
                  Tab(
                    text: "Comments",
                  ),
                  Tab(
                    text: "Support",
                  )
                ],
              ),
              Container(
                height:
                    screenHeight - (MediaQuery.of(context).padding.top + 120),
                child: TabBarView(controller: _tabController, children: [
                  VideoList(
                    parent: this,
                  ),
                  Information(
                    parent: this,
                  ),
                  CommentList(
                    parent: this,
                  ),
                  CourseSupport(
                    parent: this,
                  )
                ]),
              )
            ],
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class VideoList extends StatefulWidget {
  _CourseDetailsState parent;
  VideoList({@required this.parent});
  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => widget.parent.setState(() {
              widget.parent.tabIndex = 0;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(5, (index) {
        return VideoListItem(
            action: () {},
            duration: "00:07",
            icon: (index == 2 || index == 3) ? MdiIcons.lock : MdiIcons.play,
            title: "<Video title goes here>");
      }),
    );
  }
}

// ignore: must_be_immutable
class VideoListItem extends StatelessWidget {
  Function action;
  var icon;
  String title;
  String duration;
  VideoListItem(
      {@required this.action,
      @required this.duration,
      @required this.icon,
      @required this.title});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Container(
        color: Colors.transparent,
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: LayoutBuilder(builder: (context, limits) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(
                      icon,
                      color: Colors.black,
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
                          color: Colors.black54,
                          fontFamily: "Roboto",
                          fontSize: 14,
                        ),
                      ),
                    )
                  ],
                ),
                Text(
                  duration,
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.black45,
                    fontFamily: "Roboto",
                    fontSize: 14,
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class Information extends StatefulWidget {
  _CourseDetailsState parent;
  Information({@required this.parent});

  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => widget.parent.setState(() {
              widget.parent.tabIndex = 1;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "<Title Goes here>",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Roboto",
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 8),
            child: Text(
              "<Subtitle Goes here>",
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
              "Sunt dolor in excepteur officia est ipsum veniam aute aliqua veniam tempor incididunt ad sint. Velit irure Lorem sint veniam deserunt laborum do tempor. Adipisicing reprehenderit fugiat sit exercitation excepteur Lorem sit id proident culpa do sint. Do velit dolor labore non deserunt excepteur nostrud aute consequat elit nulla sit. Aliquip pariatur amet labore minim aliqua labore veniam ad eu. Dolore incididunt qui eiusmod sunt consequat dolore Lorem incididunt ullamco cupidatat nostrud sunt adipisicing minim.",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Roboto",
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class CommentList extends StatefulWidget {
  _CourseDetailsState parent;
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
  _CourseDetailsState parent;
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
