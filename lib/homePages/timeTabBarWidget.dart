import 'package:flutter/material.dart';
import 'package:flutter_alarm_rays7c/models/clock.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 35,
          ),
          StreamBuilder(
            stream: stream,
            builder: (context, snapshot) {
              return Align(
                child: Container(
                  width: 280,
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  child: Center(
                    child: Text(
                      DateFormat('hh:mm:ss').format(DateTime.now()),
                      style: TextStyle(fontSize: 60, color: Colors.black),
                    ),
                  ),
                ),
              );
            },
          ),
          ClockView(
            size: MediaQuery.of(context).size.height / 2,
          )
        ],
      ),
    );
  }
}
