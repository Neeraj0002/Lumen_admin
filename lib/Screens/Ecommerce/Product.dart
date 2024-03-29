import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lumin_admin/API_Functions/Ecommerce/Featured/addFeatured.dart';
import 'package:lumin_admin/API_Functions/Ecommerce/Popular/addPopular.dart';
import 'package:lumin_admin/Components/appBar.dart';
import 'package:lumin_admin/Components/buttons.dart';
import 'package:lumin_admin/Essentials/colors.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

// ignore: must_be_immutable
class Product extends StatefulWidget {
  var data;
  bool featured;
  bool popular;
  Product(
      {@required this.data, @required this.featured, @required this.popular});
  @override
  _ProductState createState() => _ProductState(data);
}

class _ProductState extends State<Product> {
  // ignore: unused_field
  var _data;
  int _current = 0;
  bool more = false;
  String desc =
      "Nisi ipsum magna sint sit ea reprehenderit. Nisi ut tempor id enim cupidatat deserunt nulla fugiat id. Enim sit non veniam labore aliquip elit deserunt in aliqua non amet exercitation reprehenderit. In sint est deserunt nisi qui.Nisi ipsum magna sint sit ea reprehenderit. Nisi ut tempor id enim cupidatat deserunt nulla fugiat id. Enim sit non veniam labore aliquip elit deserunt in aliqua non amet exercitation reprehenderit. In sint est deserunt nisi qui.Nisi ipsum magna sint sit ea reprehenderit. Nisi ut tempor id enim cupidatat deserunt nulla fugiat id. Enim sit non veniam labore aliquip elit deserunt in aliqua non amet exercitation reprehenderit. In sint est deserunt nisi qui.";
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

  // ignore: unused_element
  _starList(double value) {
    if (value == 5.0) {
      return List.generate(
          5, (index) => Icon(Icons.star, color: Colors.amber, size: 20));
    } else if (value >= 4.5 && value < 5.0) {
      return [
        Icon(Icons.star, color: Colors.amber, size: 20),
        Icon(Icons.star, color: Colors.amber, size: 20),
        Icon(Icons.star, color: Colors.amber, size: 20),
        Icon(Icons.star, color: Colors.amber, size: 20),
        Icon(Icons.star_half, color: Colors.amber, size: 20)
      ];
    } else if (value >= 4 && value < 4.5) {
      return [
        Icon(Icons.star, color: Colors.amber, size: 20),
        Icon(Icons.star, color: Colors.amber, size: 20),
        Icon(Icons.star, color: Colors.amber, size: 20),
        Icon(Icons.star, color: Colors.amber, size: 20),
        Icon(Icons.star_border, color: Colors.amber, size: 20)
      ];
    } else if (value >= 3.5 && value < 4) {
      return [
        Icon(Icons.star, color: Colors.amber, size: 20),
        Icon(Icons.star, color: Colors.amber, size: 20),
        Icon(Icons.star, color: Colors.amber, size: 20),
        Icon(Icons.star_half, color: Colors.amber, size: 20),
        Icon(Icons.star_border, color: Colors.amber, size: 20)
      ];
    } else if (value >= 3 && value < 3.5) {
      return [
        Icon(Icons.star, color: Colors.amber, size: 20),
        Icon(Icons.star, color: Colors.amber, size: 20),
        Icon(Icons.star, color: Colors.amber, size: 20),
        Icon(Icons.star_border, color: Colors.amber, size: 20),
        Icon(Icons.star_border, color: Colors.amber, size: 20)
      ];
    } else if (value >= 2.5 && value < 3) {
      return [
        Icon(Icons.star, color: Colors.amber, size: 20),
        Icon(Icons.star, color: Colors.amber, size: 20),
        Icon(Icons.star_half, color: Colors.amber, size: 20),
        Icon(Icons.star_border, color: Colors.amber, size: 20),
        Icon(Icons.star_border, color: Colors.amber, size: 20)
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
        Icon(Icons.star, color: Colors.amber, size: 20),
        Icon(Icons.star_half, color: Colors.amber, size: 20),
        Icon(Icons.star_border, color: Colors.amber, size: 20),
        Icon(Icons.star_border, color: Colors.amber, size: 20),
        Icon(Icons.star_border, color: Colors.amber, size: 20)
      ];
    } else if (value >= 1 && value < 1.5) {
      return [
        Icon(Icons.star, color: Colors.amber, size: 20),
        Icon(Icons.star_border, color: Colors.amber, size: 20),
        Icon(Icons.star_border, color: Colors.amber, size: 20),
        Icon(Icons.star_border, color: Colors.amber, size: 20),
        Icon(Icons.star_border, color: Colors.amber, size: 20)
      ];
    } else if (value >= 0.5 && value < 1) {
      return [
        Icon(Icons.star_half, color: Colors.amber, size: 20),
        Icon(Icons.star_border, color: Colors.amber, size: 20),
        Icon(Icons.star_border, color: Colors.amber, size: 20),
        Icon(Icons.star_border, color: Colors.amber, size: 20),
        Icon(Icons.star_border, color: Colors.amber, size: 20)
      ];
    } else {
      return [
        Icon(Icons.star_border, color: Colors.red, size: 20),
        Icon(Icons.star_border, color: Colors.red, size: 20),
        Icon(Icons.star_border, color: Colors.red, size: 20),
        Icon(Icons.star_border, color: Colors.red, size: 20),
        Icon(Icons.star_border, color: Colors.red, size: 20)
      ];
    }
  }

  _ProductState(this._data);
  LearneeAppBar appBar = LearneeAppBar();
  @override
  Widget build(BuildContext context) {
    print(_data);
    List imageList = _data["Images"];
    int price = _data["price"];
    int offerPrice = _data["offer_prize"];
    return Scaffold(
      appBar: appBar.simpleAppBar(title: null),
      backgroundColor: Colors.white,
      body: LayoutBuilder(builder: (context, constraints) {
        return ListView(
          children: [
            Container(
              height: 300,
              width: constraints.maxWidth,
              child: Stack(
                children: [
                  Swiper(
                    itemCount: _data["Images"].length,
                    autoplay: _data["Images"].length > 1 ? true : false,
                    onIndexChanged: (value) {
                      setState(() {
                        _current = value;
                      });
                    },
                    itemBuilder: (context, index) {
                      return CachedNetworkImage(
                        imageUrl: _data["Images"][index],
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
                      );
                    },
                  ),
                  imageList.length > 1
                      ? Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: imageList.map((url) {
                              int index = imageList.indexOf(url);
                              return Container(
                                width: 8.0,
                                height: 8.0,
                                margin: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 2.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _current == index
                                      ? Colors.yellow
                                      : Colors.grey,
                                ),
                              );
                            }).toList(),
                          ),
                        )
                      : Container(
                          height: 0,
                          width: 0,
                        ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: constraints.maxWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _data["name"],
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: "OpenSans",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            offerPrice != null
                                ? RichText(
                                    text: TextSpan(
                                      text: "Before: ",
                                      children: [
                                        TextSpan(
                                          text: "₹${price.toString()}",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontFamily: "OpenSans",
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              decorationColor: Colors.red,
                                              decorationStyle:
                                                  TextDecorationStyle.solid,
                                              decorationThickness: 1,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        )
                                      ],
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: "OpenSans",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                  )
                                : Container(
                                    height: 0,
                                    width: 0,
                                  ),
                            Text(
                              offerPrice != null
                                  ? "₹${offerPrice.toString()}"
                                  : "₹${price.toString()}",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontFamily: "OpenSans",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ],
                        ),
                        _data["rating"] != null &&
                                _data["rating"].toString().length != 0
                            ? CircularPercentIndicator(
                                radius: 40.0,
                                lineWidth: 4.0,
                                percent: _data["rating"] / 5.0,
                                center: new Text(_data["rating"].toString()),
                                progressColor: _progressColor(
                                    double.parse(_data["rating"].toString())),
                                backgroundColor: Colors.white,
                                circularStrokeCap: CircularStrokeCap.round,
                              )
                            : Container()
                      ],
                    ),
                  ],
                ),
              ),
            ),
            desc != null
                ? Container(
                    width: constraints.maxWidth,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: ConstrainedBox(
                              constraints: more
                                  ? new BoxConstraints()
                                  : new BoxConstraints(maxHeight: 50.0),
                              child: new Text(
                                desc,
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              )),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: FlatButton(
                                onPressed: () {
                                  setState(() {
                                    more = !more;
                                  });
                                },
                                child: Center(
                                  child: Text(
                                    more ? "Show Less" : "Show More",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontFamily: "OpenSans",
                                        fontSize: 12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                : Container(
                    height: 0,
                    width: 0,
                  ),
            !widget.popular
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: LearneeRegLogButton(
                        color: Colors.blue,
                        text: "Add to popular",
                        action: () {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              child: AlertDialog(
                                content: Container(
                                  height: 80,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                          addEcommercePopularAPI(context,
                                  name: widget.data['name'],
                                  img: widget.data['img'],
                                  price: widget.data['price'],
                                  offerprice: widget.data['offer_prize'],
                                  discountRate: widget.data['discount_rate'],
                                  images: widget.data['Images'])
                              .then((value) {
                            if (value != 'fail') {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                              Fluttertoast.showToast(
                                  msg: "Added to popular",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 14.0);
                            } else {
                              Navigator.of(context).pop();
                              Fluttertoast.showToast(
                                  msg: "Failed",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 14.0);
                            }
                          });
                        },
                      ),
                    ),
                  )
                : Container(),
            !widget.featured
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: LearneeRegLogButton(
                        color: Colors.blue,
                        text: "Add to Featured",
                        action: () {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              child: AlertDialog(
                                content: Container(
                                  height: 80,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                          addEcommerceFeaturedAPI(context,
                                  name: widget.data['name'],
                                  img: widget.data['img'],
                                  price: widget.data['price'],
                                  offerprice: widget.data['offer_prize'],
                                  discountRate: widget.data['discount_rate'],
                                  images: widget.data['Images'])
                              .then((value) {
                            if (value != 'fail') {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                              Fluttertoast.showToast(
                                  msg: "Added to popular",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 14.0);
                            } else {
                              Navigator.of(context).pop();
                              Fluttertoast.showToast(
                                  msg: "Failed",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 14.0);
                            }
                          });
                        },
                      ),
                    ),
                  )
                : Container(),
            /*HeadingText(text: "Reviews"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: List.generate(5, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: constraints.maxWidth,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 1,
                              blurRadius: 2,
                              color: Colors.black26,
                            )
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: constraints.maxWidth / 2,
                                  child: Text(
                                    "<Name goes here>",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "OpenSans",
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                _data["rating"] != null &&
                                        _data["rating"].toString().length != 0
                                    ? Row(
                                        children: _starList(double.parse(
                                            _data["rating"].toString())),
                                      )
                                    : Container()
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Velit ut qui non enim cupidatat eu labore excepteur incididunt nisi quis adipisicing ullamco. Proident sit nostrud mollit aute. Est nulla consectetur occaecat dolor Lorem ullamco officia eiusmod eu veniam deserunt. Ad pariatur aliqua velit aliquip commodo Lorem non qui reprehenderit non nulla. Magna elit exercitation irure eiusmod id anim voluptate nisi consequat cupidatat consequat.",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "OpenSans",
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),*/
            /*Column(
              children: [
                HeadingText(text: "Other Products"),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 220,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    children:
                        List.generate(widget.similarProducts.length, (index) {
                      return EcommerceHomeItemCard(
                          name: widget.similarProducts[index]["name"],
                          price: "\$${widget.similarProducts[index]["price"]}",
                          offerPrice: widget.similarProducts[index]
                              ["offer_price"],
                          discountRate: widget.similarProducts[index]
                              ["discount_rate"],
                          imgUrl: widget.similarProducts[index]["img"],
                          rating: widget.similarProducts[index]["rating"],
                          action: () {
                            print("Presses");
                            Navigator.of(context).push(MaterialPageRoute(
                              settings: RouteSettings(name: "product"),
                              builder: (context) => Product(
                                data: widget.similarProducts[index],
                                similarProducts: widget.similarProducts,
                              ),
                            ));
                          });
                    }),
                  ),
                ),
              ],
            ),*/
            SizedBox(
              height: 70,
            )
          ],
        );
      }),
    );
  }
}

// ignore: must_be_immutable
class QuantitySelector extends StatefulWidget {
  _ProductState parent;
  String name;
  var price;
  var userId;

  QuantitySelector(
      {@required this.parent,
      @required this.name,
      @required this.userId,
      @required this.price});
  @override
  _QuantitySelectorState createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Quantity",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              fontFamily: "OpenSans",
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.remove_circle_outline),
                  color: Colors.black,
                  iconSize: 30,
                  onPressed: () {
                    if (quantity > 1) {
                      setState(() {
                        quantity = quantity - 1;
                      });
                    }
                  },
                ),
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 3)),
                  child: Center(
                      child: Text(
                    quantity.toString(),
                    style:
                        TextStyle(color: Colors.black, fontFamily: "OpenSans"),
                  )),
                ),
                IconButton(
                  icon: Icon(Icons.add_circle_outline),
                  color: Colors.black,
                  iconSize: 30,
                  onPressed: () {
                    if (quantity < 10) {
                      setState(() {
                        quantity = quantity + 1;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 4, 40, 4),
            child: LearneeRegLogButton(
                action: () {
                  /*showDialog(
                      context: context,
                      barrierDismissible: false,
                      child: AlertDialog(
                        content: Container(
                          height: 80,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                  addToCart(context,
                          userId: widget.userId,
                          name: widget.name,
                          price: widget.price,
                          quantity: quantity)
                      .then((value) {
                    var decoded = jsonDecode(value.body);
                    Navigator.of(context).pop();
                    if (value.statusCode == 200) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Fluttertoast.showToast(
                          msg: "Added to cart",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 14.0);
                    } else {
                      Fluttertoast.showToast(
                          msg: decoded.statusCode.toString(),
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 14.0);
                    }
                  });*/
                },
                color: appBarColor,
                text: "Add to Cart"),
          )
        ],
      ),
    );
  }
}
