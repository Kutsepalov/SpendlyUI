import 'package:flutter/material.dart';

class ValueFormField extends TextFormField {
  final String? regex;
  final Icon? icon;
  final String? labelText;
  final String? helperText;
  final String? hintText;
  final bool? isRequired;

  ValueFormField(
      {super.key,
      super.controller,
      this.regex,
      super.keyboardType,
      this.icon,
      this.labelText,
      this.helperText,
      this.hintText,
      this.isRequired,
      super.maxLength})
      : super(
          validator: (value) {
            RegExp regExp = RegExp(regex!);
            if ((isRequired ?? false) &&
                value != null &&
                value.isNotEmpty &&
                !regExp.hasMatch(value)) {
              return "Enter a valid value, please";
            }
            return null;
          },
          decoration: InputDecoration(
            icon: icon,
            labelText: labelText,
            helperText: helperText,
            hintText: hintText,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
          ),
          cursorColor: Colors.blue,
        );
}
