import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_rays7c/Services/firebase_auth_service.dart';
import 'package:flutter_alarm_rays7c/auth_layout/wrapper_page.dart';
import 'package:flutter_alarm_rays7c/home_layout/home_page.dart';

class AuthPage extends StatefulWidget {
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final auth = Auth();
  final _firebaseAuth = FirebaseAuth.instance;
  Timer timer;
  bool isEmailVerified = false;

  @override
  void initState() {
    super.initState();
    isEmailVerified = _firebaseAuth.currentUser?.emailVerified;
    if (isEmailVerified == null) {
      return null;
    } else if (!isEmailVerified) {
      timer = Timer.periodic(Duration(seconds: 5), (_) => checkEmailVerified());
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await _firebaseAuth.currentUser?.reload();
    isEmailVerified = _firebaseAuth.currentUser.emailVerified;
    if (isEmailVerified) {
      timer?.cancel();
    }
  }

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
                  if (isEmailVerified == false || isEmailVerified == null) {
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
