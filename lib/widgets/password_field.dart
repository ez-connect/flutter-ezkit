import 'package:flutter/material.dart';

import '../utils.dart';

class PasswordField extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final String Function(String) validator;

  const PasswordField({
    Key key,
    this.labelText,
    this.controller,
    this.validator,
  }) : super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: this.widget.controller,
      obscureText: this._obscureText,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        labelText: this.widget.labelText,
        suffix: InkWell(
          child: Icon(
            this._obscureText ? Icons.visibility : Icons.visibility_off,
            size: 18,
            color: ThemeEx.theme.accentColor,
          ),
          onTap: () {
            this.setState(() {
              this._obscureText = !this._obscureText;
            });
          },
        ),
      ),
      validator: this.widget.validator ?? Validator.password,
    );
  }
}
