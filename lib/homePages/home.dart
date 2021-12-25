import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_rays7c/homePages/ListAlarmsTabBarWidget.dart';
import 'package:flutter_alarm_rays7c/homePages/alarmTabBarWidget.dart';
import 'package:flutter_alarm_rays7c/homePages/timeTabBarWidget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider<NotificationFunctions>.value(
                value: NotificationFunctions()),
          ],
          child: Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    padding: EdgeInsets.only(right: 15),
                    icon: Icon(Icons.exit_to_app),
                    color: Colors.white,
                    iconSize: 30,
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushNamed(context, '/wrapper');
                      print('User is out');
                    }),
              ],
              bottom: TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.access_alarm),
                    text: "Alarm",
                  ),
                  Tab(
                    icon: Icon(Icons.alarm_on_sharp),
                    text: 'Your alarms',
                  ),
                  Tab(
                    icon: Icon(Icons.access_time),
                    text: "Clock",
                  ),
                ],
              ),
              title: Text('Alarm Rays7c'),
              backgroundColor: Colors.black,
            ),
            body: TabBarView(
              children: [
                AlarmTabBarWidget(),
                ListAlarmTabBarWidgets(),
                TimeTabBarWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
