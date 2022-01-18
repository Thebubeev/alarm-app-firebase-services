import 'package:flutter/material.dart';
import 'package:flutter_alarm_rays7c/Services/alarm_helper_service.dart';
import 'package:flutter_alarm_rays7c/Services/notification_service.dart';
import 'package:flutter_alarm_rays7c/models/alarm_info_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NotificationFunctions extends ChangeNotifier {
  AlarmHelper _alarmHelper = AlarmHelper();
  Future<List<AlarmInfo>> _alarms;

  void onSaveAlarm(int hour, int minute, BuildContext context) {
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
    NotificationService()
        .showNotification(scheduleAlarmDateTime, alarmInfo, context);
    notifyListeners();
  }

  void loadAlarms() {
    _alarms = _alarmHelper.getAlarms();
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

  void deleteAlarm(int id) {
    _alarmHelper.delete(id);
    NotificationService().cancelNotifications(1);
    loadAlarms();
    notifyListeners();
  }
}
