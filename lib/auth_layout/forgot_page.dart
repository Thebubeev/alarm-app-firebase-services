import 'package:flutter/material.dart';
import 'package:flutter_alarm_rays7c/Services/firebase_auth_service.dart';
import 'package:flutter_alarm_rays7c/constants/constants.dart';
import 'package:flutter_alarm_rays7c/constants/loading.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
    void _submitForm() async {
      try {
        setState(() {
          _isLoading = true;
        });
        await auth.resetPasswordUsingEmail(_emailController.text);
        Navigator.pushReplacementNamed(context, '/wrapper');
        Fluttertoast.showToast(
            msg: "Please check your email",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
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
          case "[firebase_auth/invalid-email] The email address is badly formatted.":
            setState(() {
              _warning = "Your email is invalid";
            });
            break;
        }
      }
    }

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
                    IconButton(
                        padding: EdgeInsets.only(bottom: 15, top: 15),
                        alignment: Alignment.topLeft,
                        icon: Icon(Icons.arrow_back_ios),
                        iconSize: 35,
                        onPressed: () {
                          Navigator.pushNamed(context, '/signIn');
                        }),
                    showAlert(),
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
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                  fontFamily: 'Gilroy'),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                            ),
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'Enter email';
                              } else if (!val.contains('@') ||
                                  (!val.contains('.'))) {
                                return 'Enter your real email';
                              } else {
                                return null;
                              }
                            },
                            onChanged: (val) {
                              setState(() => _emailController.text = val);
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: GestureDetector(
                              onTap: () async {
                                if (_formKey.currentState
                                    .validate()) /* Автоматически обновляет состояние */ {
                                  _formKey.currentState.save();
                                  _submitForm();
                                }
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
                                  'Send',
                                  style: bottomText,
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
                ),
              ),
            ),
          );
  }

  Widget showAlert() {
    if (_warning != null) {
      return Container(
        color: Colors.redAccent,
        child: Row(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Icon(Icons.error_outline)),
            Expanded(
              child: Text(
                _warning,
                style: TextStyle(
                    fontSize: 18, fontFamily: 'Gilroy', color: Colors.white),
                maxLines: 3,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _warning = null;
                  });
                },
              ),
            )
          ],
        ),
      );
    }
    return SizedBox(height: 0);
  }
}
