import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:lumin_admin/Essentials/colors.dart';
import 'package:lumin_admin/Essentials/getterFunctions.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// ignore: camel_case_types
class LearneeAppBar {
  dashboardScreenAppBar({
    @required String title,
    @required BuildContext context,
    @required Function logoutAction,
  }) {
    return AppBar(
      backgroundColor: appBarColor,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
            color: Colors.white,
            fontFamily: "OpenSans",
            fontWeight: FontWeight.w700,
            fontSize: 16),
      ),
      leading: IconButton(
        tooltip: "Logout",
        color: Colors.white,
        icon: Icon(MdiIcons.logout),
        onPressed: logoutAction,
      ),
    );
  }

  homeScreenAppBar({
    @required String title,
    @required BuildContext context,
    @required Function searchAction,
    @required Function chatAction,
    @required bool showChat,
  }) {
    return AppBar(
      brightness: Brightness.dark,
      excludeHeaderSemantics: true,
      backgroundColor: appBarColor,
      centerTitle: false,
      title: Text(
        title,
        style: TextStyle(
            color: Colors.white,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w700,
            fontSize: 18),
      ),
      actions: [
        showChat
            ? IconButton(
                tooltip: "Chat",
                color: Colors.white,
                icon: Icon(Icons.chat),
                onPressed: chatAction,
              )
            : Container(
                height: 0,
                width: 0,
              ),
        IconButton(
          tooltip: "Search",
          color: Colors.white,
          icon: Icon(Icons.search),
          onPressed: searchAction,
        ),
      ],
    );
  }

  categoriesAppBar({@required String title, @required BuildContext context}) {
    return AppBar(
      brightness: Brightness.dark,
      excludeHeaderSemantics: true,
      backgroundColor: appBarColor,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
            color: Colors.white,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w700,
            fontSize: 18),
      ),
    );
  }

  morePageAppBar({@required String title, @required BuildContext context}) {
    return AppBar(
      brightness: Brightness.dark,
      excludeHeaderSemantics: true,
      backgroundColor: appBarColor,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
            color: Colors.white,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w700,
            fontSize: 18),
      ),
    );
  }

  loginScreenAppBar({@required BuildContext context}) {
    return AppBar(
      toolbarHeight: 0,
      backgroundColor: bgColor,
      elevation: 0,
      brightness: Brightness.light,
    );
  }

  simpleAppBar({@required String title}) {
    return AppBar(
      brightness: Brightness.dark,
      excludeHeaderSemantics: true,
      backgroundColor: appBarColor,
      centerTitle: true,
      title: title != null
          ? Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w700,
                  fontSize: 18),
            )
          : Container(
              height: 0,
              width: 0,
            ),
    );
  }

  courseDetailsAppBar(
      {@required String title,
      @required flashCardAction,
      @required deleteAction,
      @required String tab1,
      @required String tab2,
      @required String tab3,
      @required String tab4}) {
    return AppBar(
      brightness: Brightness.dark,
      excludeHeaderSemantics: true,
      backgroundColor: appBarColor,
      centerTitle: true,
      title: title != null
          ? Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w700,
                  fontSize: 18),
            )
          : Container(
              height: 0,
              width: 0,
            ),
      actions: [
        IconButton(
          icon: Icon(Icons.flash_on),
          onPressed: flashCardAction,
          color: Colors.white,
        ),
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: deleteAction,
          color: Colors.red,
        ),
      ],
      bottom: TabBar(
        indicatorColor: Colors.white,
        labelStyle: TextStyle(
            fontFamily: "Roboto", fontSize: 16, fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(
            fontFamily: "Roboto", fontSize: 16, fontWeight: FontWeight.w600),
        tabs: [
          Tab(
            text: tab1,
          ),
          Tab(
            text: tab2,
          ),
          Tab(
            text: tab3,
          ),
          Tab(
            text: tab4,
          )
        ],
      ),
    );
  }

  liveAppBar({@required String title, @required Function addAction}) {
    return AppBar(
      brightness: Brightness.dark,
      excludeHeaderSemantics: true,
      backgroundColor: appBarColor,
      centerTitle: true,
      title: title != null
          ? Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w700,
                  fontSize: 18),
            )
          : Container(
              height: 0,
              width: 0,
            ),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          color: Colors.white,
          onPressed: addAction,
        )
      ],
    );
  }

  cartAppBar({@required String title}) {
    return AppBar(
      brightness: Brightness.dark,
      excludeHeaderSemantics: true,
      backgroundColor: appBarColor,
      centerTitle: true,
      elevation: 0,
      title: title != null
          ? Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w700,
                  fontSize: 18),
            )
          : Container(
              height: 0,
              width: 0,
            ),
    );
  }

  ecommerceAppBar(
      {@required String title,
      @required Function cartButtonAction,
      @required Function myOrdersAction}) {
    return AppBar(
      brightness: Brightness.dark,
      excludeHeaderSemantics: true,
      backgroundColor: appBarColor,
      elevation: 0,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
            color: Colors.white,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w700,
            fontSize: 18),
      ),
      leading: IconButton(
        onPressed: myOrdersAction,
        color: Colors.white,
        tooltip: "My Orders",
        icon: Icon(MdiIcons.shoppingOutline),
      ),
      actions: [
        IconButton(
          tooltip: "Cart",
          color: Colors.white,
          onPressed: cartButtonAction,
          icon: Icon(MdiIcons.cart),
        )
      ],
    );
  }

  searchAppBar({
    @required Function closeAction,
    @required TextEditingController controller,
    @required Function(String) onEdit,
    @required Function(String) onSubmitted,
    @required FocusNode node,
  }) {
    return AppBar(
      brightness: Brightness.dark,
      excludeHeaderSemantics: true,
      backgroundColor: appBarColor,
      centerTitle: false,
      title: TextField(
        focusNode: node,
        style: TextStyle(color: Colors.white),
        controller: controller,
        onChanged: onEdit,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.white),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          hintText: "Search",
          border: InputBorder.none,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.close),
          color: Colors.white,
          onPressed: closeAction,
        )
      ],
    );
  }

  myCoursesAndPurchasesAppBar(
      {@required String title, @required tabTitle1, @required tabTitle2}) {
    return AppBar(
      brightness: Brightness.dark,
      excludeHeaderSemantics: true,
      backgroundColor: appBarColor,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
            color: Colors.white,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w700,
            fontSize: 18),
      ),
      bottom: TabBar(
        indicatorColor: Colors.white,
        labelStyle: TextStyle(
            fontFamily: "Roboto", fontSize: 16, fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(
            fontFamily: "Roboto", fontSize: 16, fontWeight: FontWeight.w600),
        tabs: [
          Tab(
            text: tabTitle1,
          ),
          Tab(
            text: tabTitle2,
          )
        ],
      ),
    );
  }

  financialAppBar(
      {@required String title,
      @required tabTitle1,
      //@required tabTitle2,
      @required tabTitle3}) {
    return AppBar(
      brightness: Brightness.dark,
      excludeHeaderSemantics: true,
      backgroundColor: appBarColor,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
            color: Colors.white,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w700,
            fontSize: 18),
      ),
      bottom: TabBar(
        indicatorColor: Colors.white,
        labelStyle: TextStyle(
            fontFamily: "Roboto", fontSize: 16, fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(
            fontFamily: "Roboto", fontSize: 16, fontWeight: FontWeight.w600),
        tabs: [
          Tab(
            text: tabTitle1,
          ),
          /*Tab(
            text: tabTitle2,
          ),*/
          Tab(
            text: tabTitle3,
          )
        ],
      ),
    );
  }

  supportAppBar({
    @required String title,
    @required tabTitle1,
    @required tabTitle2,
    @required tabTitle3,
    @required Function contactAction,
  }) {
    return AppBar(
      brightness: Brightness.dark,
      excludeHeaderSemantics: true,
      backgroundColor: appBarColor,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
            color: Colors.white,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w700,
            fontSize: 18),
      ),
      actions: [
        IconButton(
          onPressed: contactAction,
          icon: Icon(Icons.add),
          color: Colors.white,
        )
      ],
      bottom: TabBar(
        indicatorColor: Colors.white,
        labelStyle: TextStyle(
            fontFamily: "Roboto", fontSize: 16, fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(
            fontFamily: "Roboto", fontSize: 16, fontWeight: FontWeight.w600),
        tabs: [
          Tab(
            text: tabTitle1,
          ),
          Tab(
            text: tabTitle2,
          ),
          Tab(
            text: tabTitle3,
          )
        ],
      ),
    );
  }
}
