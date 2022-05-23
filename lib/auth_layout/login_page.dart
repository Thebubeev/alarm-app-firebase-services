import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_rays7c/Services/firebase_auth_service.dart';
import 'package:flutter_alarm_rays7c/constants/loading.dart';
import 'package:flutter_alarm_rays7c/widgets/widgets_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Auth auth = Auth();
  final _firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final _emailFocus = FocusNode();
  final _passFocus = FocusNode();

  String _warning;
  bool _isPasswordVisible;
  bool _isLoading;

  @override
  void initState() {
    _isPasswordVisible = false;
    _isLoading = false;
    super.initState();
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
                        'Sign In',
                        style: TextStyle(fontSize: 70),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      TextFormEmailField(emailController: _emailController),
                      TextFormPassField(passController: _passController),
                      SizedBox(
                        height: 30,
                      ),
                      enterButton(_formKey, _submitForm, 'Sign In'),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/forgot');
                          },
                          child: Container(
                            child: Text(
                              'Forgot your password?',
                              style: TextStyle(color: Colors.black),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  void _submitForm() async {
    try {
      setState(() => _isLoading = true);
      await auth
          .signInWithEmailAndPassword(
              _emailController.text.trim(), _passController.text.trim())
          .then((_) async => _firebaseAuth.currentUser.emailVerified
              ? Navigator.pushReplacementNamed(context, '/home')
              : {
                  Fluttertoast.showToast(
                      msg: 'Please, check the mail to confirm your account!',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 15,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 15.0),
                  await auth.sendVerificationEmail(),
                  setState(() {
                    _isLoading = false;
                  })
                });
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
            _warning = _firebaseAuth.currentUser.emailVerified
                ? "Your email is invalid"
                : 'Please, verify your account.';
          });
          _firebaseAuth.currentUser.emailVerified
              ? null
              : await auth.sendVerificationEmail();
          break;
        case "[firebase_auth/wrong-password] The password is invalid or the user does not have a password.":
          setState(() {
            _warning = "Your password is invalid";
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
