import 'package:flutter/material.dart';
import 'package:lumin_admin/Components/appBar.dart';
import 'package:lumin_admin/Components/courseCard.dart';
import 'package:lumin_admin/Essentials/colors.dart';

class MentorProfile extends StatefulWidget {
  @override
  _MentorProfileState createState() => _MentorProfileState();
}

class _MentorProfileState extends State<MentorProfile>
    with TickerProviderStateMixin {
  TabController _tabController;
  LearneeAppBar appBar = LearneeAppBar();
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: appBar.simpleAppBar(title: "Profile"),
      body: LayoutBuilder(builder: (context, constraints) {
        return ListView(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          children: [
            Container(
              height: constraints.maxHeight / 2,
              child: Stack(
                children: [
                  Container(
                    height: constraints.maxHeight / 2 - 30,
                    width: constraints.maxWidth,
                    color: appBarColor,
                  ),
                  Container(
                    height: constraints.maxHeight / 2 - 60,
                    width: constraints.maxWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey,
                              image: DecorationImage(
                                  image: NetworkImage(
                                    "https://i.pinimg.com/originals/a4/58/91/a45891b8705f918291eaf248d40edabd.jpg",
                                  ),
                                  fit: BoxFit.cover)),
                        ),
                        Text(
                          "<Name goes here>",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
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
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 1),
                              borderRadius: BorderRadius.circular(80),
                            ),
                            child: Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 6, 20, 6),
                                child: Text(
                                  "Follow",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Roboto",
                                      fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 60,
                        width: constraints.maxWidth * (0.8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 6,
                                  color: Colors.black26,
                                  offset: Offset(0, 1))
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "0",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Roboto",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20),
                                  ),
                                  Text(
                                    "Courses",
                                    style: TextStyle(
                                        color: Colors.black26,
                                        fontFamily: "Roboto",
                                        fontSize: 14),
                                  ),
                                ]),
                            Container(
                              height: 45,
                              width: 1,
                              color: Colors.black26,
                            ),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "16168",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Roboto",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20),
                                  ),
                                  Text(
                                    "Minutes",
                                    style: TextStyle(
                                        color: Colors.black26,
                                        fontFamily: "Roboto",
                                        fontSize: 14),
                                  ),
                                ]),
                            Container(
                              height: 45,
                              width: 1,
                              color: Colors.black26,
                            ),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "1000",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Roboto",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20),
                                  ),
                                  Text(
                                    "Followers",
                                    style: TextStyle(
                                        color: Colors.black26,
                                        fontFamily: "Roboto",
                                        fontSize: 14),
                                  ),
                                ]),
                          ],
                        ),
                      ))
                ],
              ),
            ),
            TabBar(
              controller: _tabController,
              indicatorColor: appBarColor,
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
                  text: "About",
                ),
                Tab(
                  text: "Courses",
                ),
                Tab(
                  text: "Badges",
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                height: screenHeight * (0.7),
                child: TabBarView(
                    physics: ScrollPhysics(),
                    controller: _tabController,
                    children: [
                      About(
                        parent: this,
                      ),
                      CourseList(
                        parent: this,
                      ),
                      BadgeList(
                        parent: this,
                      ),
                    ]),
              ),
            )
          ],
        );
      }),
    );
  }
}

// ignore: must_be_immutable
class About extends StatefulWidget {
  _MentorProfileState parent;
  About({@required this.parent});

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
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
              "Sunt dolor in excepteur officia est ipsum veniam aute aliqua veniam tempor incididunt ad sint. Velit irure Lorem sint veniam deserunt laborum do tempor. Adipisicing reprehenderit fugiat sit exercitation excepteur Lorem sit id proident culpa do sint. Do velit dolor labore non deserunt excepteur nostrud aute consequat elit nulla sit. Aliquip pariatur amet labore minim aliqua labore veniam ad eu. Dolore incididunt qui eiusmod sunt consequat dolore Lorem incididunt ullamco cupidatat nostrud sunt adipisicing minim.",
              style: TextStyle(
                color: Colors.black38,
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
class CourseList extends StatefulWidget {
  _MentorProfileState parent;
  CourseList({@required this.parent});
  @override
  _CourseListState createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      children: List.generate(3, (index) {
        return CourseCard2(
            imgUrl: null,
            action: () {},
            title: "<Couse Name>",
            price: "100",
            time: "16:28");
      }),
    );
  }
}

// ignore: must_be_immutable
class BadgeList extends StatefulWidget {
  _MentorProfileState parent;
  BadgeList({@required this.parent});
  @override
  _BadgeListState createState() => _BadgeListState();
}

class _BadgeListState extends State<BadgeList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      children: List.generate(3, (index) {
        return BadgesCard(
          action: () {},
          title: "<Title Goes Here>",
        );
      }),
    );
  }
}

// ignore: must_be_immutable
class BadgesCard extends StatelessWidget {
  Function action;
  String title;
  BadgesCard({@required this.action, @required this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
      child: InkWell(
        onTap: action,
        child: LayoutBuilder(builder: (context, constraints) {
          return Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 1,
                    blurRadius: 2,
                  )
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: constraints.maxWidth * (0.3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                    color: Colors.green,
                  ),
                ),
                Container(
                  height: 100,
                  width: constraints.maxWidth * (0.7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: constraints.maxWidth * (0.65),
                          child: Text(
                            title,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Roboto",
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
