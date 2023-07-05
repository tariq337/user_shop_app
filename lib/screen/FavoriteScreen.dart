import 'package:dukanuser/constant.dart';
import 'package:dukanuser/controller/FavoriteController.dart';
import 'package:dukanuser/widget/auth.dart';
import 'package:dukanuser/widget/details.dart';
import 'package:dukanuser/widget/productsCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  FavoriteController dcontroller = Get.put(FavoriteController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المفضلة'),
        centerTitle: true,
        backgroundColor: login_bg,
      ),
      body: Center(
        child: Obx(() {
          return auth(() async {
            dcontroller.getFavorite();
          },
              context,
              dcontroller.error.value,
              dcontroller.isLoading.value,
              RefreshIndicator(
                  onRefresh: () async {
                    dcontroller.getFavorite();
                  },
                  child: ListView(
                    children: [
                      Center(
                        child: Wrap(
                          children: [
                            for (int index = 0;
                                index <
                                    ((dcontroller.productsFavorite.value
                                                .details) ??
                                            [])
                                        .length;
                                index++)
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: ProductsCart(
                                    ontop: () {
                                      showModalBottomSheet<void>(
                                        isScrollControlled: true,
                                        elevation: 7,
                                        enableDrag: true,
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return details(
                                            userId: dcontroller.productsFavorite
                                                .value.details![index].userId
                                                .toString(),
                                            userName: dcontroller
                                                .productsFavorite
                                                .value
                                                .details![index]
                                                .userName,
                                            userLocationDescription: dcontroller
                                                .productsFavorite
                                                .value
                                                .details![index]
                                                .userLocationDescription,
                                            groceryName: dcontroller
                                                .productsFavorite
                                                .value
                                                .details![index]
                                                .groceryName,
                                            groceryDescription: dcontroller
                                                .productsFavorite
                                                .value
                                                .details![index]
                                                .groceryDescription,
                                            distance: dcontroller
                                                .productsFavorite
                                                .value
                                                .details![index]
                                                .distance,
                                            phoneNumber: dcontroller
                                                .productsFavorite
                                                .value
                                                .details![index]
                                                .phoneNumber,
                                            price: dcontroller.productsFavorite
                                                .value.details![index].price
                                                .toString(),
                                            lastPriceChange: dcontroller
                                                .productsFavorite
                                                .value
                                                .details![index]
                                                .lastPriceChange,
                                          );
                                        },
                                      );
                                    },
                                    name: dcontroller.productsFavorite.value
                                        .details![index].name,
                                    price: dcontroller.productsFavorite.value
                                        .details![index].price,
                                    deta: dcontroller.productsFavorite.value
                                        .details![index].lastPriceChange,
                                    id: dcontroller.productsFavorite.value
                                        .details![index].id),
                              )
                          ],
                        ),
                      )
                    ],
                  )));
        }),
      ),
    );
  }
}
