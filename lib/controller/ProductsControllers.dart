import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:dukanuser/constant.dart';
import 'package:dukanuser/model/ProductsModel.dart';
import 'package:dukanuser/model/distrubutorModel.dart';
import 'package:dukanuser/token/user_service.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  Rx<ProductsModel> products = ProductsModel().obs;
  RxBool isLoading = false.obs;
  RxString error = ''.obs;
  Dio dio = Dio();
  final id;

  ProductsController(this.id);

  @override
  void onInit() {
    getProducts(id, 1);
    super.onInit();
  }

  Future<void> getProducts(int id, int page) async {
    try {
      isLoading(true);
      String apiKey = await getToken();
      dio.options.headers['apiKey'] = apiKey.toString();
      log('getProducts');
      var response = await dio.get(getUserProducteUrl(id) + '?page=$page',
          onReceiveProgress: (int a, int c) {
        log('$a >>> $c');
      });
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
