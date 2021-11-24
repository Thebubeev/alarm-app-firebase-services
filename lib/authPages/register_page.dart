import 'package:flutter/material.dart';
import 'package:flutter_alarm_rays7c/Firebase/AuthService.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final Auth auth = Auth();
  final _formKey = GlobalKey<FormState>();
  String email, password, confirmPassword;

  String _warning;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
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
              'Sign Up',
              style: TextStyle(fontSize: 55),
            ),
            SizedBox(
              height: 40,
            ),
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
              ),
              validator: (String val) {
                confirmPassword = val;
                if (val.isEmpty) {
                  return 'Enter password';
                } else if (val.length < 6) {
                  return 'Password must contain more than 6 letters';
                } else {
                  return null;
                }
              },
              obscureText: true,
              onChanged: (val) {
                setState(() => password = val);
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Confirm your password',
                labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Gilroy'),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              validator: (String val) {
                if (val.isEmpty) {
                  return 'Enter password';
                } else if (val.length < 6) {
                  return 'Password must contain more than 6 letters';
                } else if (val != confirmPassword) {
                  return "Password must be the same";
                } else {
                  return null;
                }
              },
              obscureText: true,
              onChanged: (val) {
                setState(() => password = val);
              },
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () async {
                if (_formKey.currentState.validate()) // validate the textfields
                {
                  try {
                    await auth.createUserWithEmailAndPassword(email, password);
                    Navigator.pushReplacementNamed(context, '/home');
                  } catch (error) {
                    print(error);
                    switch (error.toString()) {
                      case "[firebase_auth/invalid-email] The email address is badly formatted.":
                        setState(() {
                          _warning = "Your email is invalid";
                        });
                        break;
                      case "[firebase_auth/email-already-in-use] The email address is already in use by another account.":
                        setState(() {
                          _warning =
                              "Email is already in use on different account";
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
                  'Sign Up',
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'Gilroy', fontSize: 17),
                )),
              ),
            ),
          ],
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
