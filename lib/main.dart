import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_rays7c/Services/NotificationServices.dart';
import 'package:flutter_alarm_rays7c/authPages/forgot_page.dart';
import 'package:flutter_alarm_rays7c/authPages/register_page.dart';
import 'package:flutter_alarm_rays7c/homePages/home.dart';
import 'authPages/login_page.dart';
import 'authPages/wrapper_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: {
      '/signUp': (context) => RegisterPage(),
      '/signIn': (context) => LoginPage(),
      '/wrapper': (context) => Wrapper(),
      '/forgot': (context) => ForgotPassword(),
      '/home': (context) => HomePage()
    }, title: 'Flutter Demo', home: AuthPage());
  }
}

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
                    return HomePage();
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
