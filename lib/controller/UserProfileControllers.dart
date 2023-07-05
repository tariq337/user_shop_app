import 'package:dio/dio.dart';
import 'package:dukanuser/constant.dart';
import 'package:dukanuser/model/UserProfileModels.dart';
import 'package:dukanuser/screen/authScreen.dart';
import 'package:dukanuser/token/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'dart:developer';

class UserController extends GetxController {
  RxBool isLoading = false.obs;

  RxString error = ''.obs;
  Rx<UserProfileModels> user = UserProfileModels().obs;
  Dio dio = Dio();
  @override
  void onInit() async {
    await getUser();
    super.onInit();
  }

  Future<void> getUser() async {
    try {
      isLoading(true);
      String apiKey = await getToken();
      dio.options.headers['apiKey'] = apiKey.toString();

      final response = await dio.get(userProfile);

      if (response.statusCode == 200) {
        log(response.data.toString());
        error.value = '';
        user.value = UserProfileModels.fromJson(response.data);
      } else if (response.statusCode == 401) {
        error.value = 'token';
      } else if (response.statusCode == 402) {
        error.value = 'not admin';
      } else {
        error.value = response.data['cause'].toString();
      }
    } catch (e) {
      log(e.toString());
      error.value = serverError;
    }
    isLoading(false);
    update();
  }

  Future<void> putUser(String tip, String data) async {
    try {
      isLoading(true);
      String apiKey = await getToken();
      dio.options.headers['apiKey'] = apiKey.toString();

      final response = await dio.put(userProfile, data: {
        tip: data,
      });

      if (response.statusCode == 200) {
        log(response.data.toString());
        error.value = '';
      } else if (response.statusCode == 401) {
        error.value = 'token';
      } else if (response.statusCode == 402) {
        error.value = 'not admin';
      } else {
        error.value = response.data['cause'].toString();
      }
    } catch (e) {
      log(e.toString());
      error.value = serverError;
    }
    isLoading(false);
    update();
  }

  Future<void> putImage(String tip, String filename, String filepath,
      BuildContext context) async {
    try {
      isLoading(true);
      String apiKey = await getToken();
      dio.options.headers['apiKey'] = apiKey.toString();

      final response = await dio.put(userProfile,
          data: FormData.fromMap({
            tip: await MultipartFile.fromFile(filepath, filename: filename),
          }));

      if (response.statusCode == 200) {
        log(response.data.toString());
        error.value = '';
      } else if (response.statusCode == 401) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const AuthScreen()),
            (route) => false);
        mess(context, 'الرجاء اعادة تسجيل الدخول', Colors.red);
      }
    } catch (e) {
      log(e.toString());
      error.value = serverError;
    }
    isLoading(false);
    update();
  }
}
