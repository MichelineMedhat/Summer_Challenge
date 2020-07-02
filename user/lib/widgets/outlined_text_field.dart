import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class OutlinedTextField extends StatelessWidget {
  final String textKey;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final String prefixText;
  final String suffixText;
  final FormFieldValidator<String> validator;

  OutlinedTextField({
    this.textKey,
    this.controller,
    this.validator,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.prefixText,
    this.suffixText
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      autovalidate: true,
      autocorrect: false,
      controller: controller,
      validator: validator,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Colors.white
      ),
      decoration: InputDecoration(
          contentPadding:
              EdgeInsets.all(16.0),
          prefixText: prefixText,
          suffixText: suffixText,
          prefixStyle: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
          border: OutlineInputBorder(borderSide: BorderSide()),
          labelText: textKey,
          labelStyle: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.normal,
            fontSize: 16,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2.5,
                style: BorderStyle.solid),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
                color:  Theme.of(context).primaryColor,
                width: 2.5,
                style: BorderStyle.solid),
          ),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(
                color: Colors.orange,
                width: 2.5,
              )),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(
                color: Colors.orange,
                width: 2.5,
              ))),
    );
  }
}