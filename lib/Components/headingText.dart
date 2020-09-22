import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HeadingText extends StatelessWidget {
  String text;
  HeadingText({@required this.text});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 8.0),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.black87,
              fontFamily: "Roboto",
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
        )
      ],
    );
  }
}
