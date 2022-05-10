// ignore_for_file: implementation_imports

import 'package:flutter/material.dart';
import 'package:flutter_alarm_rays7c/Services/firebase_auth_service.dart';
import 'package:flutter_alarm_rays7c/constants/loading.dart';
import 'package:flutter_alarm_rays7c/widgets/widgets_model.dart';
import 'package:flutter_alarm_rays7c/auth_layout/provider.dart';
import 'package:provider/src/provider.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final Auth auth = Auth();
  // text field state
  TextEditingController _emailController = TextEditingController();

  String _warning;
  bool _isLoading;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _isLoading = false;
    super.initState();
  }

  @override
  void dispose() {
    print('dispose method in Forgot Page');
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Form(
                key: _formKey,
                child: SafeArea(
                  child: ListView(padding: EdgeInsets.all(30), children: [
                    iconBackButton(context, 'signIn'),
                    ShowAlert(
                      warning: _warning,
                    ),
                    SizedBox(
                      height: 55,
                    ),
                    Text(
                      'Forgot password',
                      style: TextStyle(fontSize: 40),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormEmailField(
                            emailController: _emailController,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          enterButton(_formKey, _submitForm, 'Send')
                        ],
                      ),
                    )
                  ]),
                ),
              ),
            ),
          );
  }

  void _submitForm() async {
    try {
      setState(() {
        _isLoading = true;
      });
      await auth.resetPasswordUsingEmail(_emailController.text);
      Navigator.pushReplacementNamed(context, '/wrapper');
      context
          .read<NotificationFunctions>()
          .fluttertoast('Please, check your email!');
      print('The link has been sent to ${_emailController.text}');
    } catch (error) {
      print(error);
      setState(() {
        _isLoading = false;
      });
      switch (error.toString()) {
        case "[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.":
          setState(() {
            _warning = "There is no user with those credentials";
          });
          break;
        case "[firebase_auth/too-many-requests] We have blocked all requests from this device due to unusual activity. Try again later.":
          setState(() {
            _warning = "Too many requests. Try again later!";
          });
          break;
        case "[firebase_auth/invalid-email] The email address is badly formatted.":
          setState(() {
            _warning = "Your email is invalid";
          });
          break;
      }
    }
  }
}
