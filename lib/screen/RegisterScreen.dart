import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:dukanuser/constant.dart';
import 'package:dukanuser/controller/loginControllers.dart';
import 'package:dukanuser/screen/home.dart';
import 'package:dukanuser/screen/loginScreen.dart';
import 'package:dukanuser/token/user_service.dart';
import 'package:dukanuser/widget/buttom_login.dart';
import 'package:dukanuser/widget/logo.dart';
import 'package:dukanuser/widget/text_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:location/location.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isEnabled = true;
  final nodename = FocusNode();
  final nodegrocry = FocusNode();
  final nodephone = FocusNode();
  final nodepassword = FocusNode();
  TextEditingController username = TextEditingController();
  TextEditingController groceryName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  final AuthController authController = Get.put(AuthController());
  Size get size => MediaQuery.of(context).size;

  Location location = Location();
  late bool isServicesEnibl = false;
  late PermissionStatus _permissionStatus;
  late LocationData locationData;
  late bool isgetlocation = false;
  @override
  void initState() {
    getLocationdata();
    super.initState();
  }

  int dur = 700;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: login_bg,
          ),
          child: Center(
            child: Obx(() {
              return LoadingOverlay(
                color: Colors.black54,
                opacity: .3,
                isLoading: authController.isLoading.value,
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FadeInDown(
                            duration: Duration(milliseconds: dur),
                            child: Logo()),
                        FadeInDown(
                          duration: Duration(milliseconds: dur),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: size.height * .01,
                                bottom: size.height * .03),
                            child: const Text(
                              'تسجيل حساب جديد',
                              style: TextStyle(
                                fontSize: 28,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: ElasticIn(
                              duration: Duration(milliseconds: dur),
                              child: textEdit(
                                  (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'ادخل اسم المستخدم';
                                    }
                                    return null;
                                  },
                                  username,
                                  TextInputType.text,
                                  'اسم المستخدم',
                                  const Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  nodename,
                                  (value) {
                                    log('1');
                                    FocusScope.of(context)
                                        .requestFocus(nodegrocry);
                                  })),
                        ),
                        SizedBox(
                          height: size.height * .02,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: ElasticIn(
                              duration: Duration(milliseconds: dur),
                              child: textEdit(
                                  (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'ادخل اسم المحل';
                                    }
                                    return null;
                                  },
                                  groceryName,
                                  TextInputType.text,
                                  'اسم المحل',
                                  const Icon(
                                    Icons.home,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  nodegrocry,
                                  (value) {
                                    FocusScope.of(context)
                                        .requestFocus(nodephone);
                                  })),
                        ),
                        SizedBox(
                          height: size.height * .02,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: ElasticIn(
                              duration: Duration(milliseconds: dur),
                              child: textEdit(
                                  (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'ادخل رقم الهاتف';
                                    }
                                    return null;
                                  },
                                  phone,
                                  TextInputType.number,
                                  'رقم الهاتف',
                                  const Icon(
                                    Icons.phone,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  nodephone,
                                  (value) {
                                    FocusScope.of(context)
                                        .requestFocus(nodepassword);
                                  })),
                        ),
                        SizedBox(
                          height: size.height * .02,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: ElasticIn(
                              duration: Duration(milliseconds: dur),
                              child: textEdit(
                                  (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'ادخل كلمة المرور';
                                    }
                                    if (value.length < 8) {
                                      return 'بجب ان تكون كلمة المرور اكبر من 8';
                                    }
                                    return null;
                                  },
                                  password,
                                  TextInputType.visiblePassword,
                                  'كلمة المرور',
                                  const Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  nodepassword,
                                  (value) async {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    await getLocationdata();
                                  })),
                        ),
                        SizedBox(
                          height: size.height * .02,
                        ),
                        ElasticIn(
                            duration: Duration(milliseconds: dur * 2),
                            child: animatedButtonUI('تسجبل دخول', () async {
                              if (_formKey.currentState!.validate()) {
                                if (isgetlocation) {
                                  await authController.regesterController(
                                      username.text,
                                      groceryName.text,
                                      phone.text,
                                      password.text,
                                      '${locationData.latitude},${locationData.longitude}');
                                  if (authController.apiKey.value.isNotEmpty) {
                                    String isSetToken = await setToken(
                                        authController.apiKey.value);
                                    if (isSetToken.isNotEmpty) {
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Home()),
                                          (route) => false);
                                    } else {
                                      mess(context, 'خطاء غير متوقع',
                                          Colors.red);
                                    }
                                  } else {
                                    username.text = '';
                                    groceryName.text = '';
                                    password.text = '';
                                    phone.text = '';
                                    mess(context, authController.error.value,
                                        Colors.red);
                                  }
                                } else {
                                  mess(context, 'لم يتم تحديد الموقع',
                                      Colors.red);
                                  await getLocationdata();
                                }
                              }
                            })),
                        SizedBox(
                          height: size.height * .02,
                        ),
                        ElasticIn(
                          duration: Duration(milliseconds: dur * 2),
                          child: textButton('لدي حساب', () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const LoginScreen()),
                                (Route<dynamic> route) => false);
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Future<void> getLocationdata() async {
    isServicesEnibl = await location.serviceEnabled();
    if (!isServicesEnibl) {
      isServicesEnibl = await location.requestService();
      if (isServicesEnibl) return;
    }
    _permissionStatus = await location.hasPermission();
    if (_permissionStatus == PermissionStatus.denied) {
      _permissionStatus = await location.requestPermission();
      if (_permissionStatus != PermissionStatus.granted) return;
    }

    locationData = await location.getLocation();
    setState(() {
      isgetlocation = true;
    });
  }
}
