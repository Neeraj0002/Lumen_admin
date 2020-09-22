import 'package:flutter/material.dart';

class BroadcastingStatus extends StatefulWidget {
  final String count;
  BroadcastingStatus(this.count);
  @override
  _BroadcastingStatusState createState() => _BroadcastingStatusState();
}

class _BroadcastingStatusState extends State<BroadcastingStatus> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.24,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Colors.red, border: Border.all(color: Colors.red)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(
                  Icons.fiber_manual_record,
                  size: 10,
                ),
                Text('LIVE'),
              ],
            ),
          ),
          Container(
            decoration:
                BoxDecoration(border: Border.all(color: Colors.white70)),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 1.0),
                  child: Icon(
                    Icons.remove_red_eye,
                    size: 15,
                    color: Colors.red,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 1.0),
                  child: Text(
                    widget.count,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
