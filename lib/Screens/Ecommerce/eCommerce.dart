import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:lumin_admin/Components/EcommerceHomeItemCard.dart';
import 'package:lumin_admin/Components/appBar.dart';
import 'package:lumin_admin/Components/ecommerceCatCard.dart';
import 'package:lumin_admin/Components/headingText.dart';
import 'package:lumin_admin/Essentials/colors.dart';
import 'package:lumin_admin/Screens/Ecommerce/Cart.dart';
import 'package:lumin_admin/Screens/Ecommerce/CategoryProds.dart';
import 'package:lumin_admin/Screens/Ecommerce/Product.dart';
import 'package:lumin_admin/Screens/Ecommerce/myOrders.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EcommerceHomePage extends StatefulWidget {
  @override
  _EcommerceHomePageState createState() => _EcommerceHomePageState();
}

class _EcommerceHomePageState extends State<EcommerceHomePage> {
  LearneeAppBar appBar = LearneeAppBar();
  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("dummyData");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar.ecommerceAppBar(
            title: "E-Cart",
            myOrdersAction: () {
              Navigator.of(context).push(MaterialPageRoute(
                  settings: RouteSettings(name: "/myOrders"),
                  builder: (context) => MyOrders()));
            },
            cartButtonAction: () {
              Navigator.of(context).push(MaterialPageRoute(
                  settings: RouteSettings(name: "/cart"),
                  builder: (context) => Cart()));
            }),
        backgroundColor: bgColor,
        body: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var parsedData = jsonDecode(snapshot.data);
                List categoryData = parsedData["category_data"];
                List sliderData = parsedData["slider"];
                List recomended = parsedData["products"]["recomended"];
                List featured = parsedData["products"]["featured"];
                List mostPopular = parsedData["products"]["most_popular"];

                return ListView(children: [
                  Container(
                    height: 100,
                    decoration: BoxDecoration(color: appBarColor, boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 2))
                    ]),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      children: List.generate(categoryData.length, (index) {
                        return EcommerceCatCard(
                          title: categoryData[index]["title"],
                          img: categoryData[index]["img"],
                          action: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                settings:
                                    RouteSettings(name: "/categoryProducts"),
                                builder: (context) => CategoryProds(
                                      data: recomended,
                                      title: categoryData[index]["title"],
                                    )));
                          },
                        );
                      }),
                    ),
                  ),
                  Container(
                    height: 200,
                    child: Swiper(
                      itemCount: sliderData.length,
                      autoplay: true,
                      itemBuilder: (context, index) {
                        return CachedNetworkImage(
                          imageUrl: sliderData[index],
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
                        );
                      },
                    ),
                  ),
                  Column(
                    children: [
                      HeadingText(text: "Recomended Products"),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 220,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          children: List.generate(recomended.length, (index) {
                            return EcommerceHomeItemCard(
                                name: recomended[index]["name"],
                                price: "${recomended[index]["price"]}",
                                offerPrice: recomended[index]["offer_price"],
                                discountRate: recomended[index]
                                    ["discount_rate"],
                                imgUrl: recomended[index]["img"],
                                rating: recomended[index]["rating"],
                                action: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    settings: RouteSettings(name: "product"),
                                    builder: (context) => Product(
                                      data: recomended[index],
                                    ),
                                  ));
                                });
                          }),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      HeadingText(text: "Frequently Searched"),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 220,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: List.generate(featured.length, (index) {
                            return EcommerceHomeItemCard(
                              name: featured[index]["name"],
                              price: "${featured[index]["price"]}",
                              action: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  settings: RouteSettings(name: "product"),
                                  builder: (context) => Product(
                                    data: featured[index],
                                  ),
                                ));
                              },
                              offerPrice: featured[index]["offer_price"],
                              discountRate: featured[index]["discount_rate"],
                              imgUrl: featured[index]["img"],
                              rating: featured[index]["rating"],
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      HeadingText(text: "Featured Products"),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 220,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: List.generate(mostPopular.length, (index) {
                            return EcommerceHomeItemCard(
                              name: mostPopular[index]["name"],
                              price: "${mostPopular[index]["price"]}",
                              action: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  settings: RouteSettings(name: "product"),
                                  builder: (context) => Product(
                                    data: mostPopular[index],
                                  ),
                                ));
                              },
                              offerPrice: mostPopular[index]["offer_price"],
                              discountRate: mostPopular[index]["discount_rate"],
                              imgUrl: mostPopular[index]["img"],
                              rating: mostPopular[index]["rating"],
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ]);
              } else {
                return Container(
                  height: 0,
                  width: 0,
                );
              }
            }));
  }
}
