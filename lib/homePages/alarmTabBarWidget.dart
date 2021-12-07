import 'package:flutter/material.dart';
import 'package:flutter_alarm_rays7c/Services/NotificationServices.dart';
import 'package:flutter_alarm_rays7c/constants/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

class AlarmTabBarWidget extends StatefulWidget {
  const AlarmTabBarWidget({Key key}) : super(key: key);

  @override
  _AlarmTabBarWidgetState createState() => _AlarmTabBarWidgetState();
}

class _AlarmTabBarWidgetState extends State<AlarmTabBarWidget> {
  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Consumer<NotificationFunctions>(
            builder: (context, value, child) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    textStyle: usualText),
                onPressed: () {
                  print('Notification starts - 15 min');
                  value.showNotification(
                      1, "Alarm is on", "Wake up!", 5, context);
                  value
                      .fluttertoast('You succesfully set your alarm in 15 min');
                },
                child: Text('Set 15 min'),
              );
            },
          ),
          Consumer<NotificationFunctions>(
            builder: (context, value, child) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    textStyle: usualText),
                onPressed: () {
                  print('Notification starts - 30 min');

                  value.showNotification(
                      2, "Alarm is on", "Wake up!", 25, context);
                  value
                      .fluttertoast('You succesfully set your alarm in 30 min');
                },
                child: Text('Set 30 min'),
              );
            },
          ),
          Consumer<NotificationFunctions>(
            builder: (context, value, child) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    textStyle: usualText),
                onPressed: () {
                  print('Notification starts - 45 min');
                  value.showNotification(
                      3, "Alarm is on", "Wake up!", 125, context);
                  value
                      .fluttertoast('You succesfully set your alarm in 45 min');
                },
                child: Text('Set 45 min'),
              );
            },
          ),
          Consumer<NotificationFunctions>(
            builder: (context, value, child) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    textStyle: usualText),
                onPressed: () {
                  print('Notification starts - 60 min');
                  value.showNotification(
                      4, "Alarm is on", "Wake up!", 125, context);
                  value
                      .fluttertoast('You succesfully set your alarm in 60 min');
                },
                child: Text('Set 60 min'),
              );
            },
          ),
          Consumer<NotificationFunctions>(
            builder: (context, value, child) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.redAccent[700],
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    textStyle: usualText),
                onPressed: () async {
                  await value.showAlertDialog(
                      context, value.cancelAllNotification);
                },
                child: Text(
                  'Cancel all alarms',
                ),
              );
            },
          ),
        ],
      
    );
  }
}

class NotificationFunctions extends ChangeNotifier {
  void showNotification(
      int id, String title, String body, int seconds, BuildContext context) {
    NotificationService().showNotification(id, title, body, seconds, context);
    notifyListeners();
  }

  Future showAlertDialog(BuildContext context, Function function) async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Center(
                  child: const Text('Are you sure?',
                      style: TextStyle(
                          fontSize: 25,
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
                          color: Colors.black),
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
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
            ));

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


