import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lumin_admin/Components/appBar.dart';
import 'package:lumin_admin/Essentials/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyOrderDetails extends StatefulWidget {
  @override
  _MyOrderDetailsState createState() => _MyOrderDetailsState();
}

class _MyOrderDetailsState extends State<MyOrderDetails> {
  LearneeAppBar appBar = LearneeAppBar();
  double total = 0;
  double discount = 0;
  double grandTotal = 0;
  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("dummyData");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar.cartAppBar(title: "Order Details"),
      backgroundColor: bgColor,
      body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var parsedJson = jsonDecode(snapshot.data);
              List featuredData = parsedJson["products"]["featured"];

              if (snapshot.data != null) {
                total = 0;
                discount = 0;
                grandTotal = 0;
                for (int i = 0; i < featuredData.length; i++) {
                  if (featuredData[i]["offer_price"] != null) {
                    discount = discount +
                        (featuredData[i]["price"] -
                            featuredData[i]["offer_price"]);
                    grandTotal = grandTotal + featuredData[i]["offer_price"];
                    total = total + featuredData[i]["price"];
                    print("$grandTotal $total $discount");
                  } else {
                    grandTotal = grandTotal + featuredData[i]["price"];
                    total = total + featuredData[i]["price"];
                  }
                }
              }

              return ListView(
                children: List.generate(featuredData.length, (index) {
                  return index == 0
                      ? Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: appBarColor,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black26,
                                          spreadRadius: 1,
                                          blurRadius: 2,
                                          offset: Offset(0, 2))
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Total: ₹$total",
                                        style: TextStyle(
                                          color: Colors.white54,
                                          fontFamily: "OpenSans",
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        "Discount: ₹$discount",
                                        style: TextStyle(
                                          color: Colors.white54,
                                          fontFamily: "OpenSans",
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        "Grand Total: ₹$grandTotal",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "OpenSans",
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              OrderDetailsItem(
                                  price: "${featuredData[index]["price"]}",
                                  name: featuredData[index]["name"],
                                  action: () {},
                                  imgUrl: featuredData[index]["img"],
                                  offerPrice: featuredData[index]
                                      ["offer_price"],
                                  discountRate: featuredData[index]
                                      ["discount_rate"])
                            ],
                          ),
                        )
                      : (index == featuredData.length - 1)
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                OrderDetailsItem(
                                    price: "${featuredData[index]["price"]}",
                                    name: featuredData[index]["name"],
                                    action: () {},
                                    imgUrl: featuredData[index]["img"],
                                    offerPrice: featuredData[index]
                                        ["offer_price"],
                                    discountRate: featuredData[index]
                                        ["discount_rate"]),
                                SizedBox(
                                  height: 80,
                                )
                              ],
                            )
                          : OrderDetailsItem(
                              price: "${featuredData[index]["price"]}",
                              name: featuredData[index]["name"],
                              action: () {},
                              imgUrl: featuredData[index]["img"],
                              offerPrice: featuredData[index]["offer_price"],
                              discountRate: featuredData[index]
                                  ["discount_rate"]);
                }),
              );
            } else {
              return Container(
                height: 0,
                width: 0,
              );
            }
          }),
    );
  }
}

// ignore: must_be_immutable
class OrderDetailsItem extends StatelessWidget {
  String name;
  String price;
  Function action;
  String imgUrl;
  dynamic offerPrice;
  dynamic discountRate;
  OrderDetailsItem({
    @required this.price,
    @required this.name,
    @required this.action,
    @required this.imgUrl,
    @required this.offerPrice,
    @required this.discountRate,
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
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
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
