import 'package:flutter/material.dart';
import 'package:flutter_alarm_rays7c/Services/firebase_auth_service.dart';
import 'package:flutter_alarm_rays7c/constants/loading.dart';
import 'package:flutter_alarm_rays7c/models/widgets_model.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final Auth auth = Auth();
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

  final _emailFocus = FocusNode();
  final _passFocus = FocusNode();
  final _confirmPassFocus = FocusNode();

  String _warning;
  bool _isLoading;

  @override
  void initState() {
    _isLoading = false;
    super.initState();
  }

  @override
  void dispose() {
    print('dispose method in Register Page');
    _emailController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    _emailFocus.dispose();
    _passFocus.dispose();
    _confirmPassFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Loading()
        : Scaffold(
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Form(
                key: _formKey,
                child: SafeArea(
                  child: ListView(
                    padding: EdgeInsets.all(30),
                    children: [
                      iconBackButton(context, 'wrapper'),
                      ShowAlert(
                        warning: _warning,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 55),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      TextFormEmailField(emailController: _emailController),
                      TextFormPassField(passController: _passController),
                      TextFormConfirmPassField(
                          passController: _passController,
                          confirmPassController: _confirmPassController),
                      SizedBox(
                        height: 30,
                      ),
                      enterButton(_formKey, _submitForm, 'Sign Up')
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  void _submitForm() async {
    print('Email: $_emailController');
    print('Password: $_passController');
    try {
      setState(() => _isLoading = true);
      await auth.createUserWithEmailAndPassword(
          _emailController.text, _passController.text);
      Navigator.pushReplacementNamed(context, '/home');
    } catch (error) {
      print(error);
      setState(() {
        _isLoading = false;
      });
      switch (error.toString()) {
        case "[firebase_auth/invalid-email] The email address is badly formatted.":
          setState(() {
            _warning = "Your email is invalid";
          });
          break;
        case "[firebase_auth/too-many-requests] We have blocked all requests from this device due to unusual activity. Try again later.":
          setState(() {
            _warning = "Too many requests. Try again later!";
          });
          break;
        case "[firebase_auth/email-already-in-use] The email address is already in use by another account.":
          setState(() {
            _warning = "Email is already in use on different account";
          });
          break;
        case "[firebase_auth/unknown] Given String is empty or null":
          setState(() {
            _warning = "Your credentials are invalid";
          });
          break;
      }
    }
  }
}
