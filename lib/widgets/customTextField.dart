import 'package:chatco_app/constatns.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {required this.hint,
      this.obsecure = false,
      required this.onChange,
      this.perfix});

  String hint;
  bool obsecure;
  Widget? perfix;
  Function(String) onChange;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        validator: (data) {
          if (data!.isEmpty) {
            return 'Field is reauired';
          }
        },
        obscureText: obsecure,
        onChanged: onChange,
        decoration: InputDecoration(
          prefixIcon: perfix,
          prefixIconColor: kPrimaryColor,
          labelText: hint,
          labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor, width: 2),
          ),
        ),
      ),
    );
  }
}
