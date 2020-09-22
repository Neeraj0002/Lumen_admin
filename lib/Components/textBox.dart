import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lumin_admin/Essentials/colors.dart';

// ignore: must_be_immutable
class LearneeTextField extends StatelessWidget {
  final String hint;
  final String label;
  final TextEditingController textController;
  final bool hideText;
  var icon;
  int maxStringLength;
  LearneeTextField(
      {@required this.hint,
      @required this.label,
      @required this.hideText,
      @required this.textController,
      @required this.icon,
      this.maxStringLength});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: constraints.maxWidth * (0.9),
              child: TextField(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(
                      maxStringLength != null ? maxStringLength : -1)
                ],
                controller: textController,
                obscureText: hideText,
                decoration: InputDecoration(
                  prefixIcon: icon != null
                      ? Icon(
                          icon,
                          color: appBarColor,
                        )
                      : null,
                  focusedBorder: new OutlineInputBorder(
                      borderSide: new BorderSide(color: appBarColor)),
                  enabledBorder: new OutlineInputBorder(
                      borderSide: new BorderSide(
                          color: Color.fromRGBO(98, 98, 96, 1.0))),
                  hintText: hint,
                  labelText: label,
                  labelStyle: TextStyle(color: appBarColor),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

// ignore: must_be_immutable
class LearneeMultipleLineTextField extends StatelessWidget {
  final String hint;
  final String label;
  final TextEditingController textController;
  var icon;
  final int noOfLines;
  LearneeMultipleLineTextField(
      {@required this.hint,
      @required this.label,
      @required this.textController,
      @required this.icon,
      @required this.noOfLines});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: constraints.maxWidth * (0.9),
              child: TextField(
                maxLines: noOfLines,
                controller: textController,
                decoration: InputDecoration(
                    prefixIcon: icon != null
                        ? Icon(
                            icon,
                            color: appBarColor,
                          )
                        : null,
                    focusedBorder: new OutlineInputBorder(
                        borderSide: new BorderSide(color: appBarColor)),
                    enabledBorder: new OutlineInputBorder(
                        borderSide: new BorderSide(
                            color: Color.fromRGBO(98, 98, 96, 1.0))),
                    hintText: hint,
                    labelText: label,
                    labelStyle: TextStyle(color: appBarColor),
                    alignLabelWithHint: true),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class LearneeEmailTextField extends StatelessWidget {
  final String hint;
  final String label;
  final TextEditingController textController;
  final bool hideText;
  bool error;
  var icon;
  Function(String) onEdit;
  int maxStringLength;
  LearneeEmailTextField(
      {@required this.onEdit,
      @required this.hint,
      @required this.label,
      @required this.hideText,
      @required this.textController,
      @required this.icon,
      @required this.error});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: constraints.maxWidth * (0.9),
              child: TextField(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(
                      maxStringLength != null ? maxStringLength : -1)
                ],
                controller: textController,
                obscureText: hideText,
                onChanged: onEdit,
                decoration: InputDecoration(
                  errorText: error ? "Enter correct email format" : null,
                  errorBorder: new OutlineInputBorder(
                      borderSide: new BorderSide(color: appBarColor)),
                  prefixIcon: icon != null
                      ? Icon(
                          icon,
                          color: !error ? appBarColor : Colors.red,
                        )
                      : null,
                  focusedBorder: new OutlineInputBorder(
                      borderSide: new BorderSide(color: appBarColor)),
                  enabledBorder: new OutlineInputBorder(
                      borderSide: new BorderSide(
                          color: Color.fromRGBO(98, 98, 96, 1.0))),
                  hintText: !error ? hint : "",
                  labelText: !error ? label : "",
                  labelStyle: TextStyle(color: appBarColor),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
