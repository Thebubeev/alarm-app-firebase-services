import 'package:flutter/material.dart';
import 'package:flutter_alarm_rays7c/Services/Alarm_helper.dart';
import 'package:flutter_alarm_rays7c/Services/NotificationServices.dart';
import 'package:flutter_alarm_rays7c/constants/constants.dart';
import 'package:flutter_alarm_rays7c/models/alarm_info.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

class AlarmTabBarWidget extends StatefulWidget {
  const AlarmTabBarWidget({Key key}) : super(key: key);

  @override
  _AlarmTabBarWidgetState createState() => _AlarmTabBarWidgetState();
}

class _AlarmTabBarWidgetState extends State<AlarmTabBarWidget> {
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
            Consumer<NotificationFunctions>(
              builder: (context, value, child) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        textStyle: usualText),
                    onPressed: () {
                      print('Notification starts - 1:30 hour');
                      context.read<NotificationFunctions>().showNotification(
                          1, "Alarm is on", "Wake up!", 5400, context);
                      context.read<NotificationFunctions>().fluttertoast(
                          'You succesfully set your alarm in 1:30 hour');
                      context.read<NotificationFunctions>().onSaveAlarm(1, 30);
                      print('Alarm in 1:30 hour is saved');
                    },
                    child: Text('Set 1:30 hour'),
                  ),
                );
              },
            ),
            Consumer<NotificationFunctions>(builder: (context, value, child) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      textStyle: usualText),
                  onPressed: () {
                    print('Notification starts - 2:15 hour');
                   context.read<NotificationFunctions>()
                        .showNotification(
                            2, "Alarm is on", "Wake up!", 8100, context);
                    context.read<NotificationFunctions>()
                        .fluttertoast(
                            'You succesfully set your alarm in 2:15 hour');
                   context.read<NotificationFunctions>()
                        .onSaveAlarm(2, 15);
                    print('Alarm in 2:15 hour is saved');
                  },
                  child: Text('Set 2:15 hour'),
                ),
              );
            }),
            Consumer<NotificationFunctions>(builder: (context, value, child) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      textStyle: usualText),
                  onPressed: () {
                    print('Notification starts - 3 hour');
                   context.read<NotificationFunctions>()
                        .showNotification(
                            3, "Alarm is on", "Wake up!", 10800, context);
                  context.read<NotificationFunctions>()
                        .fluttertoast(
                            'You succesfully set your alarm in 3 hour');

                  context.read<NotificationFunctions>()
                        .onSaveAlarm(3, 0);
                    print('Alarm in 3 hour is saved');
                  },
                  child: Text('Set 3 hour'),
                ),
              );
            }),
            Consumer<NotificationFunctions>(builder: (context, value, child) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      textStyle: usualText),
                  onPressed: () {
                    print('Notification starts - 6 hour');
                  context.read<NotificationFunctions>()
                        .showNotification(
                            4, "Alarm is on", "Wake up!", 21600, context);
                    context.read<NotificationFunctions>()
                        .fluttertoast(
                            'You succesfully set your alarm in 6 hour');

                  context.read<NotificationFunctions>()
                        .onSaveAlarm(6, 0);
                    print('Alarm is saved for 6 hour');
                  },
                  child: Text('Set 6 hour'),
                ),
              );
            }),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.redAccent[700],
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    textStyle: usualText),
                onPressed: () async {
                  await context.read<NotificationFunctions>()
                      .showAlertDialog(
                          context,
                         context.read<NotificationFunctions>()
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

class NotificationFunctions extends ChangeNotifier {
  AlarmHelper _alarmHelper = AlarmHelper();
  Future<List<AlarmInfo>> _alarms;

  void onSaveAlarm(int hour, int minute) {
    DateTime scheduleAlarmDateTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        DateTime.now().hour + hour,
        DateTime.now().minute + minute,
        DateTime.now().second);

    var alarmInfo = AlarmInfo(
      alarmDateTime: scheduleAlarmDateTime,
      title: 'Your alarm is set!',
    );
    _alarmHelper.insertAlarm(alarmInfo);
    loadAlarms();
  }

  void loadAlarms() {
    _alarms = _alarmHelper.getAlarms();
  }

  void showNotification(
      int id, String title, String body, int seconds, BuildContext context) {
    NotificationService().showNotification(id, title, body, seconds, context);
    notifyListeners();
  }

  Future showAlertDialog(BuildContext context, Function function) async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              backgroundColor: Colors.black,
              contentPadding: EdgeInsets.fromLTRB(15, 15, 15, 15),
              title: Center(
                  child: const Text('Are you sure?',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Gilroy'))),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text(
                      'No',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Gilroy',
                          color: Colors.white),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      print('Cancel all notification');
                      function();
                      Navigator.pop(context, 'Enter');
                    },
                    child: const Text(
                      'Yes',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Gilroy',
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ));
    _alarmHelper.deleteAllAlarm();
    notifyListeners();
  }

  void cancelAllNotification() {
    NotificationService().cancelAllNotifications();
    notifyListeners();
  }

  void fluttertoast(String text) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 10,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 20.0);
    notifyListeners();
  }
}
