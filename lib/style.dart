import 'package:flutter/material.dart';

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  primary: Colors.white,
  backgroundColor: Colors.green,
  padding: const EdgeInsets.symmetric(vertical: 5),
  minimumSize: Size.fromHeight(40),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
);
