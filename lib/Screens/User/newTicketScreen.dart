import 'package:flutter/material.dart';
import 'package:lumin_admin/Components/appBar.dart';
import 'package:lumin_admin/Components/buttons.dart';
import 'package:lumin_admin/Components/textBox.dart';
import 'package:lumin_admin/Essentials/colors.dart';

class NewTicketSreen extends StatefulWidget {
  @override
  _NewTicketSreenState createState() => _NewTicketSreenState();
}

class _NewTicketSreenState extends State<NewTicketSreen> {
  LearneeAppBar appBar = LearneeAppBar();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: appBar.simpleAppBar(title: "New Ticket"),
        bottomSheet: Container(
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: LayoutBuilder(builder: (context, constraints) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: constraints.maxWidth * (0.5),
                  child: LearneeRegLogButton(
                      action: () {}, color: buttonBgColor, text: "Send"),
                ),
                Container(
                  width: constraints.maxWidth * (0.35),
                  child: LearneeRegLogButton(
                      action: () {}, color: Colors.amber, text: "Attach File"),
                )
              ],
            );
          }),
        ),
        body: ListView(
          children: [
            LearneeTextField(
                hint: "Title..",
                label: "Title",
                hideText: false,
                textController: null,
                icon: null),
            LearneeMultipleLineTextField(
                hint: "Write your message",
                label: "Message",
                textController: null,
                icon: null,
                noOfLines: 6),
          ],
        ),
      ),
    );
  }
}
