import 'package:flutter/material.dart';
import 'package:lumin_admin/Components/appBar.dart';
import 'package:lumin_admin/Essentials/colors.dart';
import 'package:lumin_admin/Screens/User/newTicketScreen.dart';

class Suppourt extends StatefulWidget {
  @override
  _SuppourtState createState() => _SuppourtState();
}

class _SuppourtState extends State<Suppourt> {
  LearneeAppBar appbar = LearneeAppBar();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: appbar.supportAppBar(
            title: "Support",
            tabTitle1: "Support",
            tabTitle2: "Comments",
            tabTitle3: "Students",
            contactAction: () {
              Navigator.of(context).push(MaterialPageRoute(
                settings: RouteSettings(name: "/newTicket"),
                builder: (context) => NewTicketSreen(),
              ));
            }),
        backgroundColor: bgColor,
        body: TabBarView(
          children: [
            Center(
              child: Container(
                height: 200,
                child: Image.asset(
                  "assets/img/state/tickets.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Center(
              child: Container(
                height: 200,
                child: Image.asset(
                  "assets/img/state/comments.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Center(
              child: Container(
                height: 200,
                child: Image.asset(
                  "assets/img/state/productssupport.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
