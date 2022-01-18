import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_rays7c/Services/provider.dart';
import 'package:flutter_alarm_rays7c/home_layout/alarm_page.dart';
import 'package:flutter_alarm_rays7c/home_layout/list_alarm_page.dart';
import 'package:flutter_alarm_rays7c/home_layout/time_alarm_page.dart';
import 'package:provider/provider.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key key}) : super(key: key);

  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        initialIndex: 1,
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
                indicatorColor: Colors.white,
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
                AlarmLayout(),
                ListAlarmLayout(),
                TimeAlarmLayout(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
