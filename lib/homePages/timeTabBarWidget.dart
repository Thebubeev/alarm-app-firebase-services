import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeTabBarWidget extends StatefulWidget {
  const TimeTabBarWidget({Key key}) : super(key: key);

  @override
  _TimeTabBarWidgetState createState() => _TimeTabBarWidgetState();
}

class _TimeTabBarWidgetState extends State<TimeTabBarWidget> {
  Stream stream =
      Stream.periodic(const Duration(seconds: 1)).asBroadcastStream();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        return Align(
          child: Container(
            width: 250,
            height: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30), color: Colors.black),
            child: Center(
              child: Text(
                DateFormat('hh:mm:ss').format(DateTime.now()),
                style: TextStyle(fontSize: 50, color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }
}
