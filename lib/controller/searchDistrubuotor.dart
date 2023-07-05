import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dukanuser/constant.dart';
import 'package:dukanuser/model/distrubutorModel.dart';
import 'package:dukanuser/token/user_service.dart';
import 'package:get/get.dart';

class searchDistrubuotorController extends GetxController {
  Rx<Distrubutor> distrubutor = Distrubutor().obs;
  RxBool isLoading = false.obs;
  RxString error = ''.obs;
  Dio dio = Dio();

  Future<void> searchDistrubuotor(String key, int page) async {
    try {
      isLoading(true);
      String apiKey = await getToken();
      dio.options.headers['apiKey'] = apiKey.toString();

      var response = await dio.get(
        searchDistrubuotorUrl + '?page=$page&key=$key',
      );
      if (response.statusCode == 200) {
        log(response.data.toString());
        error.value = '';
        distrubutor.value = Distrubutor.fromJson(response.data);
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
}
