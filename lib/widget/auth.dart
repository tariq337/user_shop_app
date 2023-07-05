import 'dart:developer';

import 'package:dukanuser/constant.dart';
import 'package:dukanuser/screen/authScreen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget auth(
    refresh, BuildContext context, String error, bool isloading, Widget child) {
  if (isloading) {
    return Center(
        child: Lottie.asset(
      'img/lod.json',
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .5,
    ));
  } else if (error.isNotEmpty) {
    log(error);
    if (error == 'token') {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const AuthScreen()),
          (route) => false);
      mess(context, 'الرجاء اعادة تسجيل الدخول', Colors.red);
    }
    return GestureDetector(
      onTap: refresh,
      child: Center(
          child: Lottie.asset(
        '/img/noInternetConnection.json',
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .5,
      )),
    );
  }
  return child;
}
