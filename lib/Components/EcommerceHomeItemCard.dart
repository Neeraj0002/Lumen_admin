import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EcommerceHomeItemCard extends StatelessWidget {
  final String name;
  final String price;
  Function action;
  String imgUrl;
  dynamic offerPrice;
  dynamic discountRate;
  var rating;
  // ignore: unused_element
  _progressColor(double value) {
    if (value < 2) {
      return Colors.red;
    } else if (value < 3 && value >= 2) {
      return Colors.orange;
    } else if (value < 4 && value >= 3) {
      return Colors.yellow;
    } else {
      return Colors.green;
    }
  }

  _starList(double value) {
    if (value == 5.0) {
      return List.generate(
          5, (index) => Icon(Icons.star, color: Colors.amber, size: 12));
    } else if (value >= 4.5 && value < 5.0) {
      return [
        Icon(Icons.star, color: Colors.amber, size: 12),
        Icon(Icons.star, color: Colors.amber, size: 12),
        Icon(Icons.star, color: Colors.amber, size: 12),
        Icon(Icons.star, color: Colors.amber, size: 12),
        Icon(Icons.star_half, color: Colors.amber, size: 12)
      ];
    } else if (value >= 4 && value < 4.5) {
      return [
        Icon(Icons.star, color: Colors.amber, size: 12),
        Icon(Icons.star, color: Colors.amber, size: 12),
        Icon(Icons.star, color: Colors.amber, size: 12),
        Icon(Icons.star, color: Colors.amber, size: 12),
        Icon(Icons.star_border, color: Colors.amber, size: 12)
      ];
    } else if (value >= 3.5 && value < 4) {
      return [
        Icon(Icons.star, color: Colors.amber, size: 12),
        Icon(Icons.star, color: Colors.amber, size: 12),
        Icon(Icons.star, color: Colors.amber, size: 12),
        Icon(Icons.star_half, color: Colors.amber, size: 12),
        Icon(Icons.star_border, color: Colors.amber, size: 12)
      ];
    } else if (value >= 3 && value < 3.5) {
      return [
        Icon(Icons.star, color: Colors.amber, size: 12),
        Icon(Icons.star, color: Colors.amber, size: 12),
        Icon(Icons.star, color: Colors.amber, size: 12),
        Icon(Icons.star_border, color: Colors.amber, size: 12),
        Icon(Icons.star_border, color: Colors.amber, size: 12)
      ];
    } else if (value >= 2.5 && value < 3) {
      return [
        Icon(Icons.star, color: Colors.amber, size: 12),
        Icon(Icons.star, color: Colors.amber, size: 12),
        Icon(Icons.star_half, color: Colors.amber, size: 12),
        Icon(Icons.star_border, color: Colors.amber, size: 12),
        Icon(Icons.star_border, color: Colors.amber, size: 12)
      ];
    } else if (value >= 2 && value < 2.5) {
      return [
        Icon(Icons.star, color: Colors.amber, size: 20),
        Icon(Icons.star, color: Colors.amber, size: 20),
        Icon(Icons.star_border, color: Colors.amber, size: 20),
        Icon(Icons.star_border, color: Colors.amber, size: 20),
        Icon(Icons.star_border, color: Colors.amber, size: 20)
      ];
    } else if (value >= 1.5 && value < 2) {
      return [
        Icon(Icons.star, color: Colors.amber, size: 12),
        Icon(Icons.star_half, color: Colors.amber, size: 12),
        Icon(Icons.star_border, color: Colors.amber, size: 12),
        Icon(Icons.star_border, color: Colors.amber, size: 12),
        Icon(Icons.star_border, color: Colors.amber, size: 12)
      ];
    } else if (value >= 1 && value < 1.5) {
      return [
        Icon(Icons.star, color: Colors.amber, size: 12),
        Icon(Icons.star_border, color: Colors.amber, size: 12),
        Icon(Icons.star_border, color: Colors.amber, size: 12),
        Icon(Icons.star_border, color: Colors.amber, size: 12),
        Icon(Icons.star_border, color: Colors.amber, size: 12)
      ];
    } else if (value >= 0.5 && value < 1) {
      return [
        Icon(Icons.star_half, color: Colors.amber, size: 12),
        Icon(Icons.star_border, color: Colors.amber, size: 12),
        Icon(Icons.star_border, color: Colors.amber, size: 12),
        Icon(Icons.star_border, color: Colors.amber, size: 12),
        Icon(Icons.star_border, color: Colors.amber, size: 12)
      ];
    } else {
      return [
        Icon(Icons.star_border, color: Colors.red, size: 12),
        Icon(Icons.star_border, color: Colors.red, size: 12),
        Icon(Icons.star_border, color: Colors.red, size: 12),
        Icon(Icons.star_border, color: Colors.red, size: 12),
        Icon(Icons.star_border, color: Colors.red, size: 12)
      ];
    }
  }

  EcommerceHomeItemCard(
      {@required this.price,
      @required this.name,
      @required this.action,
      @required this.imgUrl,
      @required this.offerPrice,
      @required this.discountRate,
      @required this.rating});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 4.0),
        child: LayoutBuilder(builder: (context, constraints) {
          return Container(
            width: 170,
            height: 220,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black12, spreadRadius: 1, blurRadius: 2)
              ],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Column(
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
                          fit: BoxFit.contain,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: constraints.maxWidth,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Roboto",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            Container(
                              width: constraints.maxWidth,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        offerPrice != null
                                            ? "₹$offerPrice"
                                            : "₹$price",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontFamily: "Roboto",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        width: offerPrice != null ? 5 : 0,
                                      ),
                                      offerPrice != null
                                          ? Text(
                                              "₹$price",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  decorationColor: Colors.red,
                                                  decorationThickness: 1,
                                                  decorationStyle:
                                                      TextDecorationStyle.solid,
                                                  fontFamily: "Roboto",
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600),
                                            )
                                          : Container(
                                              width: 0,
                                              height: 0,
                                            ),
                                    ],
                                  ),
                                  Row(
                                    children: _starList(
                                        double.parse(rating.toString())),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                discountRate != null
                    ? Container(
                        height: 30,
                        width: 60,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20))),
                        child: Center(
                            child: Text(
                          "$discountRate off",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "OpenSans",
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        )),
                      )
                    : Container(
                        height: 0,
                        width: 0,
                      )
              ],
            ),
          );
        }),
      ),
    );
  }
}
