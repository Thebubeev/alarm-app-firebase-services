import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_rays7c/home_layout/alarm_page.dart';
import 'package:flutter_alarm_rays7c/home_layout/list_alarm_page.dart';
import 'package:flutter_alarm_rays7c/home_layout/all_users_page.dart';
import 'package:flutter_alarm_rays7c/home_layout/time_alarm_page.dart';

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
        initialIndex: 0,
        length: 3,
        child: Scaffold(
          drawer: Drawer(
              child: ListView(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AllUsersPage()));
                  },
                  contentPadding: EdgeInsets.zero,
                  title: Row(children: [
                    Icon(
                      Icons.account_circle_outlined,
                      size: 30,
                    ),
                    SizedBox(
                      width: 7.0,
                    ),
                    Text(
                      'All Users',
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    )
                  ]),
                ),
              )
            ],
          )),
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
            centerTitle: true,
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
    );
  }
}
