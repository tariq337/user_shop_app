import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dukanuser/constant.dart';
import 'package:dukanuser/model/ProductsModel.dart';
import 'package:dukanuser/token/user_service.dart';
import 'package:get/get.dart';

class SearchProducts extends GetxController {
  Rx<ProductsModel> products = ProductsModel().obs;
  RxBool isLoading = false.obs;
  RxString error = ''.obs;
  Dio dio = Dio();
  final id;
  final key;

  SearchProducts(this.id, this.key);

  @override
  void onInit() {
    searchDistrubuotor(id, key, 1);
    super.onInit();
  }

  Future<void> searchDistrubuotor(int id, String key, int page) async {
    try {
      isLoading(true);
      String apiKey = await getToken();
      dio.options.headers['apiKey'] = apiKey.toString();

      var response = await dio.get(
        searchDistrubuotorProducteUrl(id) + '?page=$page&key=$key',
      );
      if (response.statusCode == 200) {
        log(response.data.toString());
        error.value = '';
        products.value = ProductsModel.fromJson(response.data);
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
