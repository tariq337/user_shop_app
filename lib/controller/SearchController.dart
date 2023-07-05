import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dukanuser/constant.dart';
import 'package:dukanuser/model/searchModel.dart';
import 'package:dukanuser/token/user_service.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isSearch = false.obs;
  Rx<String> error = ''.obs;

  Dio dio = Dio();
  Rx<SearchModel> searchModel = SearchModel().obs;

  Future<void> searchData(String key, int page) async {
    try {
      isLoading(true);
      isSearch(true);
      String apiKey = await getToken();
      dio.options.headers['apiKey'] = apiKey.toString();

      var response = await dio.get(
        searchUrl + '?key=$key&page=$page',
      );
      if (response.statusCode == 200) {
        log(response.data.toString());
        error.value = '';
        searchModel.value = SearchModel.fromJson(response.data);
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
