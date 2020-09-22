import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CourseCard extends StatelessWidget {
  final String title;
  final String price;
  Function action;
  final String duration;
  String imgUrl;
  CourseCard(
      {@required this.price,
      @required this.title,
      @required this.action,
      @required this.duration,
      @required this.imgUrl});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LayoutBuilder(builder: (context, constraints) {
          return Container(
            width: 220,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black12, spreadRadius: 1, blurRadius: 2)
              ],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Container(
                  height: constraints.maxHeight * (0.6),
                  width: constraints.maxWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    child: CachedNetworkImage(
                      imageUrl: imgUrl,
                      errorWidget: (context, url, error) {
                        return Center(
                          child: Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                        );
                      },
                      progressIndicatorBuilder: (context, url, progress) {
                        return Center(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  height: constraints.maxHeight * (0.4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: constraints.maxWidth,
                          child: Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Roboto",
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          width: constraints.maxWidth,
                          child: Text(
                            price,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.green,
                                fontFamily: "Roboto",
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          width: constraints.maxWidth,
                          child: Text(
                            duration,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black26,
                                fontFamily: "Roboto",
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}

// ignore: must_be_immutable
class CourseCard2 extends StatelessWidget {
  String title;
  Function action;
  String price;
  String time;
  String imgUrl;
  bool featured;
  bool popular;
  CourseCard2(
      {@required this.action,
      @required this.title,
      @required this.price,
      @required this.time,
      @required this.imgUrl,
      @required this.featured,
      @required this.popular});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                    child: CachedNetworkImage(
                      imageUrl: imgUrl,
                      errorWidget: (context, url, error) {
                        return Center(
                          child: Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                        );
                      },
                      progressIndicatorBuilder: (context, url, progress) {
                        return Center(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                      fit: BoxFit.cover,
                    ),
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
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          width: constraints.maxWidth * (0.65),
                          child: Text(
                            price,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.lightGreen,
                                fontFamily: "Roboto",
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          width: constraints.maxWidth * (0.65),
                          child: Text(
                            "Featured",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                              color: featured ? Colors.green : Colors.red,
                              fontFamily: "Roboto",
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Container(
                          width: constraints.maxWidth * (0.65),
                          child: Text(
                            "Popular",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                              color: popular ? Colors.green : Colors.red,
                              fontFamily: "Roboto",
                              fontSize: 14,
                            ),
                          ),
                        ),
                        time != null
                            ? Container(
                                width: constraints.maxWidth * (0.65),
                                child: Text(
                                  time,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: Colors.black26,
                                    fontFamily: "Roboto",
                                    fontSize: 12,
                                  ),
                                ),
                              )
                            : Container(),
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
