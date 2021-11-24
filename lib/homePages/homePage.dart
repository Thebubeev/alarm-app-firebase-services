import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TabBar extends StatefulWidget {
  const TabBar({Key key}) : super(key: key);

  @override
  _TabBarState createState() => _TabBarState();
}

class _TabBarState extends State<TabBar> {
  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("HH:mm");
    String string = dateFormat.format(DateTime.now());
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(50),
        children: [
          IconButton(
              padding: EdgeInsets.only(top: 10),
              alignment: Alignment.topRight,
              icon: Icon(Icons.exit_to_app),
              color: Colors.white,
              iconSize: 35,
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, '/wrapper');
              }),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 20),
            child: Align(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  color: Colors.white,
                ),
                height: 70,
                width: 180,
                child: Center(
                    child: Text(
                  string,
                  style: GoogleFonts.lato(
                      textStyle: TextStyle(
                    fontSize: 60,
                    color: Colors.black,
                  )),
                )),
              ),
            ),
          ),
          _buildTime('Set 15 min'),
          _buildTime('Set 30 min'),
          _buildTime('Set 45 min'),
          _buildTime('Set 60 min'),
          FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () {},
            child: Icon(
              Icons.add,
              size: 35,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTime(String time) {
    return Padding(
      padding: const EdgeInsets.only(top: 13, bottom: 13, left: 10, right: 10),
      child: GestureDetector(
        onTap: () {},
        child: Card(
          shadowColor: Colors.white24,
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Align(
            child: Container(
              width: 250,
              height: 50,
              child: Center(
                child: Text(
                  time,
                  style: GoogleFonts.lato(
                      textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                  )),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
