import 'package:flutter/material.dart';
import 'package:lumin_admin/API_Functions/Ecommerce/Categories/getCategoriesAPI.dart';
import 'package:lumin_admin/Components/appBar.dart';
import 'package:lumin_admin/Components/buttons.dart';
import 'package:lumin_admin/Screens/Ecommerce/ManageCategory.dart';
import 'package:lumin_admin/Screens/Ecommerce/ManageProducts.dart';
import 'package:lumin_admin/Screens/Ecommerce/ManageSlider.dart';
import 'package:lumin_admin/Screens/ManageEcommerceFeatured.dart';
import 'package:lumin_admin/Screens/ManageEcommerceOrders.dart';
import 'package:lumin_admin/Screens/ManageEcommercePopular.dart';
import 'package:lumin_admin/Screens/ManageEcommerceProducts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Essentials/colors.dart';

class EcommerceDashboard extends StatefulWidget {
  @override
  _EcommerceDashboardState createState() => _EcommerceDashboardState();
}

class _EcommerceDashboardState extends State<EcommerceDashboard> {
  LearneeAppBar appbar = LearneeAppBar();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar.simpleAppBar(title: "Ecommerce Dashboard"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          shrinkWrap: true,
          childAspectRatio: 80 / 30,
          crossAxisCount: 2,
          children: [
            LearneeRoundedBtn(
              action: () {
                Navigator.of(context).push(MaterialPageRoute(
                  settings: RouteSettings(name: "/sliders"),
                  builder: (context) => ManageEcommerceSlider(),
                ));
              },
              text: "Sliders",
              icon: MdiIcons.imageArea,
            ),
            LearneeRoundedBtn(
              action: () {
                Navigator.of(context).push(MaterialPageRoute(
                  settings: RouteSettings(name: "/sliders"),
                  builder: (context) => ManageEcommerceCategory(),
                ));
              },
              text: "Categories",
              icon: Icons.list,
            ),
            LearneeRoundedBtn(
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
                getEcommerceCategoriesAPI().then((value) {
                  Navigator.pop(context);
                  if (value != 'null') {
                    Navigator.of(context).push(MaterialPageRoute(
                      settings: RouteSettings(name: "/products"),
                      builder: (context) => ManageProducts(
                        categories: value,
                      ),
                    ));
                  }
                });
              },
              text: "Products",
              icon: Icons.shopping_cart,
            ),
            LearneeRoundedBtn(
              action: () {
                Navigator.of(context).push(MaterialPageRoute(
                  settings: RouteSettings(name: "/featured"),
                  builder: (context) => ManageEcommerceFeatured(),
                ));
              },
              text: "Featured",
              icon: Icons.featured_play_list,
            ),
            LearneeRoundedBtn(
              action: () {
                Navigator.of(context).push(MaterialPageRoute(
                  settings: RouteSettings(name: "/popular"),
                  builder: (context) => ManageEcommercePopular(),
                ));
              },
              text: "Popular",
              icon: MdiIcons.finance,
            ),
            LearneeRoundedBtn(
              action: () {
                Navigator.of(context).push(MaterialPageRoute(
                  settings: RouteSettings(name: "/orders"),
                  builder: (context) => EcommerceOrders(),
                ));
              },
              text: "Orders",
              icon: MdiIcons.shoppingOutline,
            ),
            /*LearneeRoundedBtn(
              action: () {
                Navigator.of(context).push(MaterialPageRoute(
                  settings: RouteSettings(name: "/products"),
                  builder: (context) => ManageEcommerceProducts(),
                ));
              },
              text: "Products",
              icon: Icons.storage,
            ),*/
          ],
        ),
      ),
    );
  }
}
