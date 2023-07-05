import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget Logo() {
  return Material(
      elevation: 8.0,
      shape: const CircleBorder(),
      child: CircleAvatar(
        backgroundColor: Colors.grey[100],
        child: Lottie.asset(
          'img/check.json',
          width: 50,
          height: 50,
          fit: BoxFit.fill,
        ),
        radius: 50.0,
      ));
}

Widget loding() {
  return Scaffold(
    body: Center(child: Logo()),
  );
}
