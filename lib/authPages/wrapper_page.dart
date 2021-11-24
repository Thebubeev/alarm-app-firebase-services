import 'package:flutter_alarm_rays7c/constants.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Text(
                'Alarm Rays7c',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 40),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/signUp');
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                    color: Colors.black,
                  ),
                  height: 80,
                  width: 340,
                  child: Center(
                      child: Text(
                    'Sign Up',
                    style: bottomText,
                  )),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/signIn');
                },
                child: Container(
                  height: 80,
                  color: Colors.white70,
                  child: Center(child: Text('Sign In', style: bottomBlackText)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
