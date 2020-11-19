import 'package:flutter/material.dart';
import 'package:lumin_admin/Components/appBar.dart';
import 'package:lumin_admin/Components/buttons.dart';
import 'package:lumin_admin/Screens/Ecommerce/ManageCategory.dart';
import 'package:lumin_admin/Screens/Ecommerce/ManageProducts.dart';
import 'package:lumin_admin/Screens/Ecommerce/ManageSlider.dart';
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
                Navigator.of(context).push(MaterialPageRoute(
                  settings: RouteSettings(name: "/products"),
                  builder: (context) => ManageProducts(),
                ));
              },
              text: "Products",
              icon: Icons.shopping_cart,
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
