import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("HH:mm");
    String string = dateFormat.format(DateTime.now());
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
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
                  }),
            ],
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.access_alarm),
                  text: "Alarm",
                ),
                Tab(
                  icon: Icon(Icons.access_time),
                  text: "Clock",
                ),
                Tab(icon: Icon(Icons.timer), text: "Timer"),
              ],
            ),
            title: Text('Alarm Rays7c'),
            backgroundColor: Colors.black,
          ),
          body: TabBarView(
            children: [
              Icon(Icons.access_alarm),
              StreamBuilder(
                stream: Stream.periodic(const Duration(seconds: 1)),
                builder: (context, snapshot) {
                  return Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 280,
                      height: 80,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          DateFormat('hh:mm:ss').format(DateTime.now()),
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                            fontSize: 60,
                            color: Colors.white,
                          )),
                        ),
                      ),
                    ),
                  );
                },
              ),
              Icon(Icons.timer),
            ],
          ),
        ),
      ),
    );
  }
}
