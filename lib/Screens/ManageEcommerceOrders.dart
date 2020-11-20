import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lumin_admin/API_Functions/Ecommerce/getOrders.dart';
import 'package:lumin_admin/Components/appBar.dart';
import 'package:lumin_admin/Essentials/colors.dart';
import 'package:lumin_admin/Screens/Ecommerce/myOrdersDetails.dart';

class EcommerceOrders extends StatefulWidget {
  @override
  _EcommerceOrdersState createState() => _EcommerceOrdersState();
}

class _EcommerceOrdersState extends State<EcommerceOrders> {
  LearneeAppBar appBar = LearneeAppBar();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar.simpleAppBar(title: "Orders"),
      backgroundColor: bgColor,
      body: FutureBuilder(
          future: viewOrder(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                var parsedData = jsonDecode(snapshot.data);
                return ListView(
                    children: List.generate(parsedData.length, (index) {
                  return OrderItem(
                    name: parsedData[index]['name'],
                    contact: parsedData[index]['contact'],
                    address: parsedData[index]['address'],
                    action: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          settings: RouteSettings(name: "/myOrderDetails"),
                          builder: (context) => MyOrderDetails(
                                data: parsedData[index],
                              )));
                    },
                  );
                }));
              } else {
                return Container();
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

// ignore: must_be_immutable
class OrderItem extends StatelessWidget {
  final String name;
  final String contact;
  final List address;
  Function action;
  OrderItem(
      {@required this.name,
      @required this.contact,
      @required this.address,
      @required this.action});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    spreadRadius: 2,
                    blurRadius: 6,
                    color: Colors.black26,
                    offset: Offset(0, 2))
              ],
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name != null && name.length != 0
                      ? "$name"
                      : "Name not available",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Jost",
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                  child: Text(
                    contact != null && contact.length != 0
                        ? "$contact"
                        : "Contact not available",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Jost",
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                  child: Text(
                    address != null && address.length != 0
                        ? "address\naddress\naddress"
                        : "Address not available",
                    style: TextStyle(
                        color: Colors.black, fontFamily: "Jost", fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
