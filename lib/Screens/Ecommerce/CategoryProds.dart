import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lumin_admin/Components/appBar.dart';
import 'package:lumin_admin/Essentials/colors.dart';
import 'package:lumin_admin/Screens/Ecommerce/Product.dart';

// ignore: must_be_immutable
class CategoryProds extends StatefulWidget {
  List data;
  String title;
  CategoryProds({this.data, this.title});
  @override
  _CategoryProdsState createState() => _CategoryProdsState(data);
}

class _CategoryProdsState extends State<CategoryProds> {
  // ignore: unused_field
  List _data;
  _CategoryProdsState(this._data);
  LearneeAppBar appBar = LearneeAppBar();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar.simpleAppBar(title: widget.title),
      backgroundColor: bgColor,
      body: ListView(
        children: List.generate(_data.length, (index) {
          return CategoryProductsItem(
            name: _data[index]["name"],
            price: _data[index]["price"].toString(),
            offerPrice: _data[index]["offer_price"],
            discountRate: _data[index]["discount_rate"],
            imgUrl: _data[index]["img"],
            rating: _data[index]["rating"],
            action: () {
              Navigator.of(context).push(MaterialPageRoute(
                  settings: RouteSettings(name: "/categoryProducts"),
                  builder: (context) =>
                      Product(data: _data[index], similarProducts: _data)));
            },
          );
        }),
      ),
    );
  }
}

// ignore: must_be_immutable
class CategoryProductsItem extends StatelessWidget {
  String name;
  String price;
  Function action;
  String imgUrl;
  dynamic offerPrice;
  dynamic discountRate;
  var rating;

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

  CategoryProductsItem(
      {@required this.price,
      @required this.name,
      @required this.action,
      @required this.imgUrl,
      @required this.offerPrice,
      @required this.discountRate,
      @required this.rating});
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
            child: Stack(
              children: [
                Row(
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
                                "$name",
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
                    ),
                  ],
                ),
                discountRate != null
                    ? Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          height: 30,
                          width: 60,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10))),
                          child: Center(
                              child: Text(
                            "$discountRate off",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "OpenSans",
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          )),
                        ),
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
