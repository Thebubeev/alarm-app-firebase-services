import 'package:flutter/material.dart';
import 'package:flutter_alarm_rays7c/Services/alarm_helper_service.dart';
import 'package:flutter_alarm_rays7c/Services/provider.dart';
import 'package:flutter_alarm_rays7c/constants/constants.dart';
import 'package:flutter_alarm_rays7c/models/alarm_info_model.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

class AlarmLayout extends StatefulWidget {
  const AlarmLayout({Key key}) : super(key: key);

  @override
  _AlarmLayoutState createState() => _AlarmLayoutState();
}

class _AlarmLayoutState extends State<AlarmLayout> {
  AlarmHelper _alarmHelper = AlarmHelper();
  Future<List<AlarmInfo>> _alarms;

  @override
  void initState() {
    _alarmHelper.initializeDatabase().then((value) {
      print('------database intialized');
      context.read<NotificationFunctions>().loadAlarms();
    });
    tz.initializeTimeZones();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    textStyle: usualText),
                onPressed: () {
                  print('Notification starts - 45 min');
                  context
                      .read<NotificationFunctions>()
                      .fluttertoast('You succesfully set your alarm in 45 min');
                  context
                      .read<NotificationFunctions>()
                      .onSaveAlarm(0, 0, context);
                  print('Alarm in 45 minutes is saved');
                },
                child: Text('Set 45 min'),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    textStyle: usualText),
                onPressed: () {
                  print('Notification starts - 1:30 hour');
                  Provider.of<NotificationFunctions>(context, listen: false)
                      .fluttertoast(
                          'You succesfully set your alarm in 1:30 hour');
                  Provider.of<NotificationFunctions>(context, listen: false)
                      .onSaveAlarm(0, 1, context);
                  print('Alarm is saved');
                },
                child: Text('Set 1:30 hour'),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    textStyle: usualText),
                onPressed: () {
                  print('Notification starts - 2:15 hour');
                  Provider.of<NotificationFunctions>(context, listen: false)
                      .fluttertoast(
                          'You succesfully set your alarm in 2:15 hour');

                  Provider.of<NotificationFunctions>(context, listen: false)
                      .onSaveAlarm(0, 2, context);
                  print('Alarm is saved');
                },
                child: Text('Set 2:15 hour'),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    textStyle: usualText),
                onPressed: () {
                  print('Notification starts - 3 hour');
                  Provider.of<NotificationFunctions>(context, listen: false)
                      .fluttertoast('You succesfully set your alarm in 3 hour');

                  Provider.of<NotificationFunctions>(context, listen: false)
                      .onSaveAlarm(0, 3, context);
                  print('Alarm is saved for 3 hour');
                },
                child: Text('Set 3 hour'),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.redAccent[700],
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    textStyle: usualText),
                onPressed: () async {
                  await Provider.of<NotificationFunctions>(context,
                          listen: false)
                      .showAlertDialog(
                          context,
                          Provider.of<NotificationFunctions>(context,
                                  listen: false)
                              .cancelAllNotification);
                },
                child: Text(
                  'Cancel all alarms',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
