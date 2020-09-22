import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DisplayCard extends StatelessWidget {
  String line1;
  String line2;
  var color;
  DisplayCard(
      {@required this.line1, @required this.line2, @required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width / 2.5,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(color: Colors.black12, spreadRadius: 1, blurRadius: 2)
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            line1,
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Roboto",
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
          Text(
            line2,
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Roboto",
                fontSize: 16,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
