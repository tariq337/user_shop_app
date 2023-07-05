import 'package:dukanuser/screen/authScreen.dart';
import 'package:dukanuser/screen/home.dart';
import 'package:dukanuser/widget/logo.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'اعرف اسعارك',
      debugShowCheckedModeBanner: false,
      home: CheckAuth(),
    );
  }
}

class CheckAuth extends StatefulWidget {
  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  @override
  void initState() {
    super.initState();
    _check();
  }

  _check() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String token = pref.getString('apiKey') ?? '';
    if (token.isEmpty) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const AuthScreen()),
          (route) => false);
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const Home()),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Logo();
  }
}
