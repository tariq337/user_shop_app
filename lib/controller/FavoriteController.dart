import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:dukanuser/constant.dart';
import 'package:dukanuser/model/ProductsFavoriteModel.dart';
import 'package:dukanuser/token/user_service.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
  Rx<ProductsFavoriteModel> productsFavorite = ProductsFavoriteModel().obs;
  RxBool isLoading = false.obs;
  RxString error = ''.obs;
  Dio dio = Dio();

  @override
  void onInit() {
    getFavorite();
    super.onInit();
  }

  Future<void> getFavorite() async {
    try {
      isLoading(true);
      String apiKey = await getToken();
      dio.options.headers['apiKey'] = apiKey.toString();
      var response = await dio.get(getFavoriteUrl);
      if (response.statusCode == 200) {
        error.value = '';
        productsFavorite.value = ProductsFavoriteModel.fromJson(response.data);
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
