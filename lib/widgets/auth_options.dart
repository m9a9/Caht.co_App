import 'package:chatco_app/constatns.dart';
import 'package:flutter/material.dart';

Widget AuthOptions({
  VoidCallback? ontap,
  required String image,
}) {
  return GestureDetector(
    onTap: ontap,
    child: Container(
      padding: EdgeInsets.all(10),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Image.asset(
        image,
        height: 40,
        width: 55,
      ),
    ),
  );
}

void ShowSnakBar(context, String message, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: color,
    content: Text(
      message,
      style: TextStyle(fontSize: 18),
    ),
    duration: Duration(seconds: 3),
    action: SnackBarAction(
      label: 'OK',
      onPressed: () {},
      textColor: Colors.white,
    ),
  ));
}
