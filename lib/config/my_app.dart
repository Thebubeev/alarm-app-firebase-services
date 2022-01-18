import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_rays7c/auth_layout/wrapper_page.dart';
import 'package:flutter_alarm_rays7c/home_layout/home_page.dart';

class AuthPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Text('Error ${snapshot.error}'),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  User user = snapshot.data;
                  if (user == null) {
                    return Wrapper();
                  } else {
                    return HomeLayout();
                  }
                }
                return CircularProgressIndicator();
              });
        }
        return CircularProgressIndicator();
      },
    );
  }
}
