import 'package:flutter/material.dart';
import 'package:flutter_alarm_rays7c/Services/firebase_auth_service.dart';
import 'package:flutter_alarm_rays7c/constants/loading.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Auth auth = Auth();
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
  void dispose() {
    print('dispose method in Login Page');
    _emailController.dispose();
    _passController.dispose();
    _emailFocus.dispose();
    _passFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void _submitForm() async {
      try {
        setState(() => _isLoading = true);
        await auth.signInWithEmailAndPassword(
            _emailController.text, _passController.text);
        Navigator.pushReplacementNamed(context, '/home');
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
                      IconButton(
                          padding: EdgeInsets.only(top: 15, bottom: 15),
                          alignment: Alignment.topLeft,
                          icon: Icon(Icons.arrow_back_ios),
                          iconSize: 35,
                          onPressed: () {
                            Navigator.pushNamed(context, '/wrapper');
                          }),
                      showAlert(),
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
                      textFormEmailField(_emailController),
                      textFormPassField(_passController),
                      SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
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
                            'Sign In',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Gilroy',
                                fontSize: 17),
                          )),
                        ),
                      ),
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

  Widget textFormEmailField(TextEditingController _emailController) =>
      TextFormField(
        decoration: InputDecoration(
          labelText: 'Email',
          labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Gilroy'),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
        controller: _emailController,
        autofocus: true,
        onFieldSubmitted: (_) {
          _fieldFocusChange(context, _emailFocus, _passFocus);
        },
        focusNode: _emailFocus,
        validator: (val) {
          if (val.isEmpty) {
            return 'Enter email';
          } else if (!val.contains('@') || (!val.contains('.'))) {
            return 'Enter your real email';
          } else {
            return null;
          }
        },
        onSaved: (val) {
          _emailController.text = val;
        },
      );

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  Widget textFormPassField(TextEditingController _passController) =>
      TextFormField(
        decoration: InputDecoration(
            labelText: 'Password',
            labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Gilroy'),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
              icon: Icon(
                _isPasswordVisible == true
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: Colors.black,
              ),
            )),
        controller: _passController,
        focusNode: _passFocus,
        autofocus: true,
        validator: (String val) {
          if (val.isEmpty) {
            return 'Enter password';
          } else if (val.length < 6) {
            return 'Password must contain more than 6 letters';
          } else {
            return null;
          }
        },
        obscureText: _isPasswordVisible ? false : true,
        onSaved: (val) {
          _passController.text = val;
        },
      );
}
