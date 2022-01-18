import 'package:flutter/material.dart';

void _fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}

final _emailFocus = FocusNode();
final _passFocus = FocusNode();
final _confirmPassFocus = FocusNode();

bool _isPasswordVisible = false;

class TextFormEmailField extends StatefulWidget {
  final TextEditingController emailController;
  const TextFormEmailField({Key key, this.emailController}) : super(key: key);

  @override
  State<TextFormEmailField> createState() => _TextFormEmailFieldState();
}

class _TextFormEmailFieldState extends State<TextFormEmailField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
      controller: widget.emailController,
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
        setState(() {
          widget.emailController.text = val;
        });
      },
    );
  }
}

class TextFormPassField extends StatefulWidget {
  final TextEditingController passController;
  const TextFormPassField({Key key, this.passController}) : super(key: key);

  @override
  State<TextFormPassField> createState() => _TextFormPassFieldState();
}

class _TextFormPassFieldState extends State<TextFormPassField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
      controller: widget.passController,
      focusNode: _passFocus,
      autofocus: true,
      onFieldSubmitted: (_) {
        _fieldFocusChange(context, _passFocus, _confirmPassFocus);
      },
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
        setState(() {
          widget.passController.text = val;
        });
      },
    );
  }
}

class TextFormConfirmPassField extends StatefulWidget {
  final TextEditingController passController, confirmPassController;
  const TextFormConfirmPassField(
      {Key key, this.passController, this.confirmPassController})
      : super(key: key);

  @override
  State<TextFormConfirmPassField> createState() =>
      _TextFormConfirmPassFieldState();
}

class _TextFormConfirmPassFieldState extends State<TextFormConfirmPassField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Confirm your password',
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
      controller: widget.confirmPassController,
      autofocus: true,
      focusNode: _confirmPassFocus,
      validator: (String val) {
        if (val.isEmpty) {
          return 'Enter password';
        } else if (val.length < 6) {
          return 'Password must contain more than 6 letters';
        } else if (val != widget.passController.text) {
          return "Password must be the same";
        } else {
          return null;
        }
      },
      obscureText: _isPasswordVisible ? false : true,
      onSaved: (val) {
        setState(() {
          widget.passController.text = val;
        });
      },
    );
  }
}

class ShowAlert extends StatefulWidget {
  String warning;
  ShowAlert({Key key, @required this.warning}) : super(key: key);

  @override
  State<ShowAlert> createState() => _ShowAlertState();
}

class _ShowAlertState extends State<ShowAlert> {
  @override
  Widget build(BuildContext context) {
    if (widget.warning != null) {
      return Container(
        color: Colors.redAccent,
        child: Row(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Icon(Icons.error_outline)),
            Expanded(
              child: Text(
                widget.warning,
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
                    widget.warning = null;
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

Widget iconBackButton(BuildContext context, String text) => IconButton(
    padding: EdgeInsets.only(top: 15, bottom: 15),
    alignment: Alignment.topLeft,
    icon: Icon(Icons.arrow_back_ios),
    iconSize: 35,
    onPressed: () {
      Navigator.pushNamed(context, '/$text');
    });

Widget enterButton(GlobalKey<FormState> _formKey, Function _submitForm, String text) =>
    GestureDetector(
        onTap: () async {
          if (_formKey.currentState.validate()) // validate the textfields
          {
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
            text,
            style: TextStyle(
                color: Colors.white, fontFamily: 'Gilroy', fontSize: 17),
          )),
        ));
