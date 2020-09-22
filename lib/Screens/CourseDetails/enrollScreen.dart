import 'package:flutter/material.dart';
import 'package:lumin_admin/Components/appBar.dart';
import 'package:lumin_admin/Components/buttons.dart';
import 'package:lumin_admin/Components/courseCard.dart';
import 'package:lumin_admin/Essentials/colors.dart';

class Enroll extends StatefulWidget {
  @override
  _EnrollState createState() => _EnrollState();
}

class _EnrollState extends State<Enroll> {
  LearneeAppBar appBar = LearneeAppBar();
  String gateway = "Select a payment gateway";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar.simpleAppBar(title: "Enroll on the course"),
      backgroundColor: bgColor,
      bottomSheet: Container(
        height: 70,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Container(
                width: 120,
                child: LearneeRegLogButton(
                    action: () {}, color: buttonBgColor, text: "Pay"),
              ),
            )
          ],
        ),
      ),
      body: ListView(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                  left: 20.0,
                ),
                child: Text(
                  "Item",
                  style: TextStyle(
                    color: Colors.black87,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CourseCard2(
              imgUrl: null,
              action: () {},
              time: "13:19",
              price: "₹100",
              title: "<Coures name>",
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  left: 20.0,
                ),
                child: Text(
                  "Information",
                  style: TextStyle(
                    color: Colors.black87,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
              )
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 8, 40, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Item price:",
                      style: TextStyle(
                        color: Colors.black38,
                        fontFamily: "Roboto",
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "₹100",
                      style: TextStyle(
                        color: Colors.black38,
                        fontFamily: "Roboto",
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 8, 40, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Discount:",
                      style: TextStyle(
                        color: Colors.black38,
                        fontFamily: "Roboto",
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "₹0",
                      style: TextStyle(
                        color: Colors.black38,
                        fontFamily: "Roboto",
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 8, 40, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "tax:",
                      style: TextStyle(
                        color: Colors.black38,
                        fontFamily: "Roboto",
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "₹0",
                      style: TextStyle(
                        color: Colors.black38,
                        fontFamily: "Roboto",
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 8, 40, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total:",
                      style: TextStyle(
                        color: Colors.black38,
                        fontFamily: "Roboto",
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "₹100",
                      style: TextStyle(
                        color: Colors.black38,
                        fontFamily: "Roboto",
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      left: 20.0,
                    ),
                    child: Text(
                      "Payment gateway",
                      style: TextStyle(
                        color: Colors.black87,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'Gateway 1 ',
                    child: Container(
                        width: MediaQuery.of(context).size.width * (0.95),
                        child: Text("Gateway 1")),
                  ),
                  PopupMenuItem(
                    value: 'Gateway 2 ',
                    child: Container(
                        width: MediaQuery.of(context).size.width * (0.95),
                        child: Text("Gateway 2")),
                  ),
                  PopupMenuItem(
                    value: 'Gateway 3 ',
                    child: Container(
                        width: MediaQuery.of(context).size.width * (0.95),
                        child: Text("Gateway 3")),
                  ),
                  PopupMenuItem(
                    value: 'Gateway 4 ',
                    child: Container(
                        width: MediaQuery.of(context).size.width * (0.95),
                        child: Text("Gateway 4")),
                  ),
                ],
                initialValue: "Gateway",
                onSelected: (value) async {
                  setState(() {
                    gateway = value;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 55,
                    //width: screenWidth * (0.8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 2,
                              blurRadius: 6,
                              offset: Offset(2, 2))
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            gateway != null ? gateway : "Select a gateway",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.arrow_drop_down,
                                size: 20,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 10,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
