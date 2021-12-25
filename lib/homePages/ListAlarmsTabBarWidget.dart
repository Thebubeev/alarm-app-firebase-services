import 'package:flutter/material.dart';

class ListAlarmTabBarWidgets extends StatefulWidget {
  const ListAlarmTabBarWidgets({Key key}) : super(key: key);

  @override
  _ListAlarmTabBarWidgetsState createState() => _ListAlarmTabBarWidgetsState();
}

class _ListAlarmTabBarWidgetsState extends State<ListAlarmTabBarWidgets> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(title: Text('Alarm #1'), subtitle: Text('12:30')),
        ListTile(title: Text('Alarm #2'), subtitle: Text('12:30')),
        ListTile(title: Text('Alarm #3'), subtitle: Text('12:30')),
      ],
    );
  }
}
