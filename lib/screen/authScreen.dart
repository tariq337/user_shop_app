import 'package:animate_do/animate_do.dart';
import 'package:dukanuser/constant.dart';
import 'package:dukanuser/screen/RegisterScreen.dart';
import 'package:dukanuser/screen/loginScreen.dart';
import 'package:dukanuser/widget/buttom_login.dart';
import 'package:dukanuser/widget/logo.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  int dur = 700;
  @override
  Widget build(BuildContext context) {
    const color = Colors.white;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          backgroundColor: login_bg,
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FadeInDown(
                    duration: Duration(milliseconds: dur), child: Logo()),
                FadeInDown(
                  duration: Duration(milliseconds: dur),
                  child: const Text(
                    "مرحبا",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35.0,
                        color: color),
                  ),
                ),
                FadeInDown(
                  duration: Duration(milliseconds: dur * 2),
                  child: const Text(
                    "في تسعيرة",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35.0,
                        color: color),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                FadeInDown(
                  duration: Duration(milliseconds: dur * 2),
                  child: const Text(
                    "يمكنك معرفة الاسعار",
                    style: TextStyle(fontSize: 20.0, color: color),
                  ),
                ),
                FadeInDown(
                  duration: Duration(milliseconds: dur * 2),
                  child: const Text(
                    " ومتابعتها من هنا",
                    style: TextStyle(fontSize: 20.0, color: color),
                  ),
                ),
                const SizedBox(
                  height: 100.0,
                ),
                ElasticIn(
                  duration: const Duration(milliseconds: 1000 * 4),
                  child: animatedButtonUI('تسجيل حساب جديد', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterScreen()),
                    );
                  }),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                ElasticIn(
                  duration: const Duration(milliseconds: 1000 * 4),
                  child: textButton('لدي حساب ', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  }),
                ),
              ],
            ),
          )),
    );
  }
}
