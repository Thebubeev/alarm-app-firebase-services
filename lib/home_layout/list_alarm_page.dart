import 'package:flutter/material.dart';
import 'package:flutter_alarm_rays7c/Services/alarm_helper_service.dart';
import 'package:flutter_alarm_rays7c/Services/provider.dart';
import 'package:flutter_alarm_rays7c/models/alarm_info_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';

class ListAlarmLayout extends StatefulWidget {
  const ListAlarmLayout({Key key}) : super(key: key);

  @override
  _ListAlarmLayoutState createState() => _ListAlarmLayoutState();
}

class _ListAlarmLayoutState extends State<ListAlarmLayout> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder<List<AlarmInfo>>(
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
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
          context.read<NotificationFunctions>().deleteAlarm(alarmInfo.id);
          print('deleted result : ${alarmInfo.id}');
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
