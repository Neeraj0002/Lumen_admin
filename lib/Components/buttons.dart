import 'package:flutter/material.dart';
import 'package:lumin_admin/Essentials/colors.dart';

// ignore: must_be_immutable
class LearneeRegLogButton extends StatelessWidget {
  var color;
  var text;
  Function action;
  LearneeRegLogButton(
      {@required this.action, @required this.color, @required this.text});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 1),
                  color: Colors.black26,
                  spreadRadius: 1,
                  blurRadius: 2)
            ]),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Roboto",
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class LearneeLightTextButton extends StatelessWidget {
  final String text;
  Function action;
  var textColor;
  LearneeLightTextButton(
      {@required this.action, @required this.text, @required this.textColor});
  @override
  Widget build(BuildContext context) {
    return FlatButton(
        splashColor: Colors.white,
        onPressed: action,
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontFamily: "Roboto",
              fontSize: 16,
            ),
          ),
        ));
  }
}

// ignore: must_be_immutable
class LearneeBoldTextButton extends StatelessWidget {
  final String text;
  Function action;
  var textColor;
  LearneeBoldTextButton(
      {@required this.action, @required this.text, @required this.textColor});
  @override
  Widget build(BuildContext context) {
    return FlatButton(
        splashColor: Colors.white,
        onPressed: action,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: textColor,
                fontFamily: "Roboto",
                fontSize: 16,
                fontWeight: FontWeight.w800),
          ),
        ));
  }
}

// ignore: must_be_immutable
class LearneeRoundedBtn extends StatelessWidget {
  String text;
  var icon;
  Function action;
  LearneeRoundedBtn({
    this.action,
    this.icon,
    this.text,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: action,
        child: Container(
          decoration: BoxDecoration(
              color: Color.fromRGBO(202, 216, 239, 1.0),
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 1),
                    color: Colors.black12,
                    spreadRadius: 1,
                    blurRadius: 1)
              ]),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: Colors.black,
                ),
                Text(
                  " $text",
                  style: TextStyle(
                      color: appBarColor,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Roboto",
                      fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
