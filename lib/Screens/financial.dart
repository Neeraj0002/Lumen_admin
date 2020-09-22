import 'package:flutter/material.dart';
import 'package:lumin_admin/Components/appBar.dart';
import 'package:lumin_admin/Components/buttons.dart';
import 'package:lumin_admin/Components/textBox.dart';
import 'package:lumin_admin/Components/userDisplayCard.dart';
import 'package:lumin_admin/Essentials/colors.dart';
import 'package:lumin_admin/Screens/Purchases.dart';

class Financial extends StatefulWidget {
  @override
  _FinancialState createState() => _FinancialState();
}

class _FinancialState extends State<Financial> {
  LearneeAppBar appbar = LearneeAppBar();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: appbar.financialAppBar(
            title: "Financial",
            tabTitle1: "Sales",
            //tabTitle2: "Balances",
            tabTitle3: "Charge and Accounts"),
        backgroundColor: bgColor,
        body: TabBarView(
          children: [
            PurchaseCourseList(),
            /*Center(
              child: Container(
                height: 200,
                child: Image.asset(
                  "assets/img/state/financialdocs.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),*/
            ChargeAndAccounts()
          ],
        ),
      ),
    );
  }
}

class ChargeAndAccounts extends StatefulWidget {
  @override
  _ChargeAndAccountsState createState() => _ChargeAndAccountsState();
}

class _ChargeAndAccountsState extends State<ChargeAndAccounts> {
  String gateway;
  TextEditingController amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: LayoutBuilder(builder: (context, constraints) {
        return ListView(
          children: [
            /*Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 16, 0, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DisplayCard(
                        color: Color.fromRGBO(227, 89, 219, 1.0),
                        line1: "Payoutable",
                        line2: "₹0",
                      ),
                      DisplayCard(
                        color: Color.fromRGBO(51, 191, 254, 1.0),
                        line1: "Account charge",
                        line2: "₹0",
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
                /*PopupMenuButton(
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
                ),*/
                LearneeTextField(
                    hint: "Enter amount here",
                    label: "Amount",
                    hideText: false,
                    textController: amountController,
                    icon: Icons.credit_card)
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: LearneeRegLogButton(
                  action: () {}, color: buttonBgColor, text: "Pay"),
            )*/
          ],
        );
      }),
    );
  }
}
