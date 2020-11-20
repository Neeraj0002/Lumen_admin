import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lumin_admin/Components/appBar.dart';
import 'package:lumin_admin/Essentials/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyOrderDetails extends StatefulWidget {
  var data;
  MyOrderDetails({@required this.data});
  @override
  _MyOrderDetailsState createState() => _MyOrderDetailsState();
}

class _MyOrderDetailsState extends State<MyOrderDetails> {
  LearneeAppBar appBar = LearneeAppBar();
  double total = 0;
  double discount = 0;
  double grandTotal = 0;

  @override
  Widget build(BuildContext context) {
    total = 0;
    discount = 0;
    grandTotal = 0;
    for (int i = 0; i < widget.data['order'].length; i++) {
      if (widget.data['order'][i]["offer_price"] != null) {
        discount = discount +
            (widget.data['order'][i]["price"] -
                widget.data['order'][i]["offer_price"]);
        grandTotal = grandTotal + widget.data['order'][i]["offer_price"];
        total = total + widget.data['order'][i]["price"];
        print("$grandTotal $total $discount");
      } else {
        grandTotal = grandTotal + widget.data['order'][i]["price"];
        total = total + widget.data['order'][i]["price"];
      }
    }
    return Scaffold(
        appBar: appBar.cartAppBar(title: "Order Details"),
        backgroundColor: bgColor,
        body: ListView(
          children: List.generate(widget.data['order'].length, (index) {
            return index == 0
                ? Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration:
                              BoxDecoration(color: appBarColor, boxShadow: [
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
                                  "${widget.data['name'] != null && widget.data['name'].length != 0 ? widget.data['name'] : "Name not available"}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "OpenSans",
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${widget.data['contact'] != null && widget.data['contact'].length != 0 ? widget.data['contact'] : "Contact not available"}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "OpenSans",
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                /*Text(
                                  "${widget.data['name'] != null && widget.data['name'].length != 0 ? widget.data['name'] : "Name not available"}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "OpenSans",
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),*/
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
                            quantity: widget.data['order'][index]["quantity"],
                            price: widget.data['order'][index]["price"],
                            name: widget.data['order'][index]["product_key"],
                            action: () {},
                            imgUrl:
                                "https://pixselo.com/wp-content/uploads/2018/03/dummy-placeholder-image-400x400.jpg",
                            offerPrice: widget.data['order'][index]
                                ["offer_price"],
                            discountRate: widget.data['order'][index]
                                ["discount_rate"])
                      ],
                    ),
                  )
                : (index == widget.data['order'].length - 1)
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          OrderDetailsItem(
                              quantity: widget.data['order'][index]["quantity"],
                              price: widget.data['order'][index]["price"],
                              name: widget.data['order'][index]["product_key"],
                              action: () {},
                              imgUrl:
                                  "https://pixselo.com/wp-content/uploads/2018/03/dummy-placeholder-image-400x400.jpg",
                              offerPrice: widget.data['order'][index]
                                  ["offer_price"],
                              discountRate: widget.data['order'][index]
                                  ["discount_rate"]),
                          SizedBox(
                            height: 80,
                          )
                        ],
                      )
                    : OrderDetailsItem(
                        quantity: widget.data['order'][index]["quantity"],
                        price: widget.data['order'][index]["price"],
                        name: widget.data['order'][index]["product_key"],
                        action: () {},
                        imgUrl:
                            "https://pixselo.com/wp-content/uploads/2018/03/dummy-placeholder-image-400x400.jpg",
                        offerPrice: widget.data['order'][index]["offer_price"],
                        discountRate: widget.data['order'][index]
                            ["discount_rate"]);
          }),
        ));
  }
}

// ignore: must_be_immutable
class OrderDetailsItem extends StatelessWidget {
  String name;
  int price;
  Function action;
  String imgUrl;
  dynamic offerPrice;
  dynamic discountRate;
  int quantity;
  OrderDetailsItem(
      {@required this.price,
      @required this.name,
      @required this.action,
      @required this.imgUrl,
      @required this.offerPrice,
      @required this.discountRate,
      @required this.quantity});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: action,
        child: LayoutBuilder(builder: (context, constraints) {
          return Container(
            height: 120,
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
                      height: 120,
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
                      height: 120,
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
                                            fontSize: 12,
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
                            Container(
                              width: constraints.maxWidth * (0.65),
                              child: Text(
                                "Quantity : $quantity",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Roboto",
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Container(
                              width: constraints.maxWidth * (0.65),
                              child: Text(
                                "Total : ₹${quantity * price}",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Roboto",
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
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
