import 'package:flutter/material.dart';
import 'package:flutter_alarm_rays7c/Services/Alarm_helper.dart';
import 'package:flutter_alarm_rays7c/Services/NotificationServices.dart';
import 'package:flutter_alarm_rays7c/models/alarm_info.dart';
import 'package:intl/intl.dart';

class ListAlarmTabBarWidgets extends StatefulWidget {
  const ListAlarmTabBarWidgets({Key key}) : super(key: key);

  @override
  _ListAlarmTabBarWidgetsState createState() => _ListAlarmTabBarWidgetsState();
}

class _ListAlarmTabBarWidgetsState extends State<ListAlarmTabBarWidgets> {
  AlarmHelper _alarmHelper = AlarmHelper();
  Future<List<AlarmInfo>> _alarms;

  @override
  void initState() {
    loadAlarms();
    super.initState();
  }

  void loadAlarms() {
    _alarms = _alarmHelper.getAlarms();
    if (mounted) setState(() {});
  }

  void deleteAlarm(int id) {
    _alarmHelper.delete(id);
    //unsubscribe for notification
    loadAlarms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder<List<AlarmInfo>>(
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.data.isEmpty) {
                  return Center(
                    child: Text('There are no alarms!'),
                  );
                }
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return _buildAlarm(snapshot.data[index]);
                    },
                    itemCount: snapshot.data.length,
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error...'),
                  );
                }
                return CircularProgressIndicator();
              },
              future: _alarms,
            )));
  }

  Widget _buildAlarm(AlarmInfo alarmInfo) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Dismissible(
        direction: DismissDirection.startToEnd,
        onDismissed: (direction) {
          setState(() {
            deleteAlarm(alarmInfo.id);
            print('deleted result : ${alarmInfo.id}');
          });
        },
        background: Container(
          color: Colors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(Icons.delete)],
          ),
        ),
        key: UniqueKey(),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Colors.black,
          elevation: 3,
          child: ListTile(
            title: Text(
              DateFormat('HH:mm').format(alarmInfo.alarmDateTime),
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            subtitle: Text(
              alarmInfo.title,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
