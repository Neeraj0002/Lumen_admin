import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CourseCatCard extends StatelessWidget {
  Function action;
  String title;
  String img;
  CourseCatCard(
      {@required this.action, @required this.title, @required this.img});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Column(
        children: [
          Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.white),
            child: LayoutBuilder(builder: (context, constraints) {
              return Padding(
                padding: const EdgeInsets.only(left: 40, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 35,
                      width: 35,
                      child: CachedNetworkImage(
                        imageUrl: img,
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
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Roboto",
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        /*Text(
                          "$courseNo courses",
                          style: TextStyle(
                            color: Colors.black26,
                            fontFamily: "Roboto",
                            fontSize: 14,
                          ),
                        )*/
                      ],
                    ),
                  ],
                ),
              );
            }),
          ),
          Container(
            height: 0.5,
            color: Colors.black54,
            width: MediaQuery.of(context).size.width,
          )
        ],
      ),
    );
  }
}
