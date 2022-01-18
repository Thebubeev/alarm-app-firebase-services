import 'package:flutter/material.dart';

void _fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}

final _emailFocus = FocusNode();
final _passFocus = FocusNode();
final _confirmPassFocus = FocusNode();

String _warning;
bool _isPasswordVisible;

class TextFormEmailField extends StatelessWidget {
  final TextEditingController emailController;
  const TextFormEmailField({Key key, this.emailController}) : super(key: key);

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
      controller: emailController,
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
        emailController.text = val;
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
        widget.passController.text = val;
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
      autofocus: false,
      focusNode: _confirmPassFocus,
      validator: (String val) {
        if (val.isEmpty) {
          return 'Enter password';
        } else if (val.length < 6) {
          return 'Password must contain more than 6 letters';
        } else if (val != widget.confirmPassController.text) {
          return "Password must be the same";
        } else {
          return null;
        }
      },
      obscureText: _isPasswordVisible ? false : true,
      onSaved: (val) {
        widget.passController.text = val;
      },
    );
  }
}
