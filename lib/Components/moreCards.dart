import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MoreCard1 extends StatelessWidget {
  String title;
  Function action;
  String favNo;
  String imgUrl;
  MoreCard1({
    @required this.action,
    @required this.title,
    @required this.favNo,
    @required this.imgUrl,
  });
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
                    color: Colors.white,
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
                      fit: BoxFit.fill,
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
                        Row(
                          children: [
                            Icon(
                              Icons.favorite_border,
                              color: Colors.red,
                            ),
                            Text(
                              " $favNo",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Roboto",
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        )
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
