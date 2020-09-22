import 'package:flutter/material.dart';
import 'package:lumin_admin/Components/appBar.dart';
import 'package:lumin_admin/Essentials/colors.dart';
import 'package:lumin_admin/Screens/Ecommerce/myOrdersDetails.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  LearneeAppBar appBar = LearneeAppBar();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar.simpleAppBar(title: "My Orders"),
      backgroundColor: bgColor,
      body: ListView(
        children: [
          OrderItem(
            orderTime: "10:30",
            orderDate: "20/10/2020",
            orderStatus: "PROCESSING",
            orderRate: "1985.0",
            parent: this,
            action: () {
              Navigator.of(context).push(MaterialPageRoute(
                  settings: RouteSettings(name: "/myOrderDetails"),
                  builder: (context) => MyOrderDetails()));
            },
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class OrderItem extends StatelessWidget {
  final String orderDate;
  final String orderStatus;
  final String orderTime;
  final String orderRate;
  _MyOrdersState parent;
  Function action;
  OrderItem(
      {@required this.orderTime,
      @required this.orderDate,
      @required this.orderStatus,
      @required this.orderRate,
      @required this.parent,
      @required this.action});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 140,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "₹$orderRate",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Jost",
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  Text(
                    "$orderTime, $orderDate",
                    style: TextStyle(
                        color: Colors.black, fontFamily: "Jost", fontSize: 14),
                  ),
                  Text(
                    "$orderStatus",
                    style: TextStyle(
                        color: orderStatus.toLowerCase() != "cancelled"
                            ? (orderStatus == "Delivered"
                                ? Colors.green
                                : Colors.blue)
                            : Colors.red,
                        fontFamily: "Jost",
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  (orderStatus.toLowerCase() != 'cancelled' &&
                          (orderStatus.toLowerCase() == 'processing' ||
                              orderStatus.toLowerCase() == 'pending'))
                      ? InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                child: AlertDialog(
                                  content: Text(
                                    "Are you sure that you want to cancel the order?",
                                    style: TextStyle(
                                      fontFamily: "Jost",
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                  actions: [
                                    FlatButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        "Yes",
                                        style: TextStyle(
                                          fontFamily: "Jost",
                                          fontSize: 15,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                    FlatButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text(
                                        "No",
                                        style: TextStyle(
                                          fontFamily: "Jost",
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )
                                  ],
                                ));
                          },
                          child: Container(
                            width: 90,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Cancel ",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                      fontFamily: "Jost",
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(
                          height: 0,
                          width: 0,
                        ),
                  InkWell(
                    onTap: action,
                    child: Container(
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "View",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontFamily: "Jost",
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
