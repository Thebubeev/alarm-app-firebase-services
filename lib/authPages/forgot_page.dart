import 'package:flutter/material.dart';
import 'package:flutter_alarm_rays7c/Firebase/AuthService.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../constants.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final Auth auth = Auth();
  // text field state
  String email;
  String _warning;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: ListView(padding: EdgeInsets.all(30), children: [
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
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                    } else if (!val.contains('@') || (!val.contains('.'))) {
                      return 'Enter your real email';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (val) {
                    setState(() => email = val);
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
                        try {
                          await auth.resetPasswordUsingEmail(email);
                          Navigator.pushReplacementNamed(context, '/wrapper');
                          Fluttertoast.showToast(
                              msg: "Please check your email",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 5,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          print('The link has been sent to $email');
                        } catch (error) {
                          print(error);
                          switch (error.toString()) {
                            case "[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.":
                              setState(() {
                                _warning =
                                    "There is no user with those credentials";
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
