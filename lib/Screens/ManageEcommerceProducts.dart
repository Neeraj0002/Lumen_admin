import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lumin_admin/API_Functions/Category/getCategories.dart';
import 'package:lumin_admin/API_Functions/Ecommerce/Featured/getFeatured.dart';
import 'package:lumin_admin/API_Functions/Ecommerce/Popular/getPopular.dart';
import 'package:lumin_admin/API_Functions/Ecommerce/Products/addProductsAPI.dart';
import 'package:lumin_admin/API_Functions/Ecommerce/Products/deleteProduct.dart';
import 'package:lumin_admin/API_Functions/Ecommerce/Products/getProducts.dart';
import 'package:lumin_admin/Components/appBar.dart';
import 'package:lumin_admin/Components/buttons.dart';
import 'package:lumin_admin/Components/textBox.dart';
import 'package:lumin_admin/Essentials/colors.dart';
import 'package:lumin_admin/Screens/Ecommerce/Product.dart';

class ManageProducts extends StatefulWidget {
  var categories;
  ManageProducts({@required this.categories});
  @override
  _ManageProductsState createState() => _ManageProductsState();
}

class _ManageProductsState extends State<ManageProducts> {
  LearneeAppBar appBar = LearneeAppBar();
  TextEditingController category = TextEditingController();
  var result;
  @override
  void initState() {
    getCategoriesAPI().then((value) {
      print("DONE");
      setState(() {
        result = value;
      });
    });
    super.initState();
  }

  /* */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar.liveAppBar(
          title: "Products",
          addAction: () {
            showDialog(
                context: context,
                child: AddProductDialog(
                  parent: this,
                  categories: widget.categories,
                ));
          }),
      backgroundColor: bgColor,
      body: FutureBuilder(
          future: getEcommerceProductsAPI(),
          builder: (context, snapshot) {
            if (ConnectionState.done == snapshot.connectionState) {
              if (snapshot.hasData) {
                return ListView(
                  children:
                      List.generate(snapshot.data["Products"].length, (index) {
                    return ProductItem(
                        parent: this,
                        id: snapshot.data["Products"][index]['id'],
                        price: snapshot.data["Products"][index]['price'],
                        name: snapshot.data["Products"][index]['name'],
                        action: () {
                          bool featured;
                          bool popular;
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
                          getEcommerceFeaturedAPI().then((featuredValue) {
                            if (featuredValue != 'fail') {
                              List featuredProds = featuredValue['featured'];
                              for (int i = 0; i < featuredProds.length; i++) {
                                if (featuredProds[i]['name'] ==
                                    snapshot.data["Products"][index]['name']) {
                                  featured = true;
                                  break;
                                } else {
                                  featured = false;
                                }
                              }
                              getEcommercePopularAPI().then((popularValue) {
                                if (popularValue != 'fail') {
                                  List popularProds =
                                      popularValue['most_popular'];
                                  for (int j = 0;
                                      j < popularProds.length;
                                      j++) {
                                    if (popularProds[j]['name'] ==
                                        snapshot.data["Products"][index]
                                            ['name']) {
                                      popular = true;
                                      break;
                                    } else {
                                      popular = false;
                                    }
                                  }
                                  Navigator.pop(context);
                                  Navigator.of(context).push(MaterialPageRoute(
                                    settings: RouteSettings(name: "product"),
                                    builder: (context) => Product(
                                      featured: featured,
                                      popular: popular,
                                      data: snapshot.data["Products"][index],
                                    ),
                                  ));
                                } else {
                                  Navigator.pop(context);
                                }
                              });
                            } else {
                              Navigator.pop(context);
                            }
                          });
                        },
                        imgUrl: snapshot.data["Products"][index]['img'],
                        offerPrice: snapshot.data["Products"][index]
                            ['offer_prize'],
                        discountRate: snapshot.data["Products"][index]
                            ['discount_rate']);
                  }),
                );
              } else {
                return Center(
                  child: Container(
                    child: Text("No Categories"),
                  ),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

class ProductItem extends StatelessWidget {
  String name;
  int price;
  Function action;
  String imgUrl;
  int offerPrice;
  dynamic discountRate;
  String id;
  _ManageProductsState parent;
  ProductItem(
      {@required this.price,
      @required this.name,
      @required this.action,
      @required this.imgUrl,
      @required this.offerPrice,
      @required this.discountRate,
      @required this.id,
      @required this.parent});
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
                                        offerPrice != null && offerPrice != 0
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
                                      offerPrice != null && offerPrice != 0
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
                                  IconButton(
                                      icon: Icon(Icons.delete),
                                      color: Colors.red,
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            child: AlertDialog(
                                              content: Container(
                                                height: 80,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Center(
                                                      child: Container(
                                                        height: 30,
                                                        width: 30,
                                                        child:
                                                            CircularProgressIndicator(),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ));
                                        deleteEcommerceProductAPI(context,
                                                id: id)
                                            .then((value) {
                                          Navigator.pop(context);
                                          if (value != 'fail') {
                                            Fluttertoast.showToast(
                                                msg: "Deleted",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.green,
                                                textColor: Colors.white,
                                                fontSize: 14.0);
                                            parent.setState(() {});
                                          } else {
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
                                      })
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                discountRate != null && discountRate.length != 0
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

// ignore: must_be_immutable
class AddProductDialog extends StatefulWidget {
  _ManageProductsState parent;
  var categories;
  AddProductDialog({this.parent, this.categories});
  @override
  _AddProductDialogState createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController offerPrice = TextEditingController();
  TextEditingController imgUrl = TextEditingController();
  TextEditingController discountRate = TextEditingController();
  String categoryName;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            LearneeTextField(
                hint: "Enter Name",
                label: "Name",
                hideText: false,
                textController: name,
                icon: null),
            PopupMenuButton(
              itemBuilder: (context) => List.generate(
                widget.categories['Categories'].length,
                (index) => PopupMenuItem(
                  value: widget.categories['Categories'][index]['title'],
                  child: Text(widget.categories['Categories'][index]['title']),
                ),
              ),
              initialValue: null,
              onSelected: (value) async {
                FocusScope.of(context).requestFocus(new FocusNode());
                setState(() {
                  categoryName = value;
                });
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 0))
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            categoryName == null
                                ? "Select Category"
                                : categoryName,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.arrow_drop_down,
                            size: 20,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            LearneeTextField(
                hint: "Enter Price",
                label: "Price",
                hideText: false,
                textController: price,
                icon: null),
            LearneeTextField(
                hint: "Enter Offer Price",
                label: "Offer Price",
                hideText: false,
                textController: offerPrice,
                icon: null),
            LearneeTextField(
                hint: "Enter Image Url",
                label: "Image Url",
                hideText: false,
                textController: imgUrl,
                icon: null),
            LearneeTextField(
                hint: "Enter Discount rate",
                label: "Discount rate",
                hideText: false,
                textController: discountRate,
                icon: null),
            LearneeRegLogButton(
                action: () {
                  if (name.text.isNotEmpty &&
                      price.text.isNotEmpty &&
                      imgUrl.text.isNotEmpty &&
                      categoryName != null) {
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

                    addEcommerceProductsAPI(context,
                        name: name.text,
                        img: imgUrl.text,
                        price: price.text,
                        offerprice: offerPrice.text,
                        discountRate: discountRate.text,
                        category: categoryName,
                        images: [imgUrl.text]).then((value) {
                      Navigator.pop(context);
                      if (value != 'fail') {
                        Navigator.pop(context);
                        Fluttertoast.showToast(
                            msg: "Added products",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 14.0);
                        widget.parent.setState(() {});
                      } else {
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
                  } else {
                    Fluttertoast.showToast(
                        msg: "Please enter name, price and image url",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 14.0);
                  }
                },
                color: appBarColor,
                text: "Add Product"),
          ],
        ),
      ),
    );
  }
}
