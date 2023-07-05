import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:dukanuser/constant.dart';
import 'package:dukanuser/controller/ProductsControllers.dart';
import 'package:dukanuser/controller/SearchProducts.dart';
import 'package:dukanuser/widget/auth.dart';
import 'package:dukanuser/widget/details.dart';
import 'package:dukanuser/widget/productsCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsScreen extends StatefulWidget {
  final id;
  const ProductsScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    ProductsController dcontroller = Get.put(ProductsController(widget.id));
    log(widget.id.toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text('منتجات'),
        centerTitle: true,
        backgroundColor: login_bg,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: Searchdistrubutor(id: widget.id));
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: Center(
        child: Obx(() {
          return auth(() async {
            await dcontroller.getProducts(widget.id, 1);
          },
              context,
              dcontroller.error.value,
              dcontroller.isLoading.value,
              RefreshIndicator(
                  onRefresh: () async {
                    await dcontroller.getProducts(widget.id, 1);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ListView(
                      children: [
                        Center(
                          child: Wrap(
                            children: [
                              for (int index = 0;
                                  index <
                                      ((dcontroller.products.value.details) ??
                                              [])
                                          .length;
                                  index++)
                                ElasticIn(
                                    duration:
                                        const Duration(milliseconds: 400 * 2),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: ProductsCart(
                                          ontop: () {
                                            showModalBottomSheet<void>(
                                              isScrollControlled: true,
                                              elevation: 7,
                                              enableDrag: true,
                                              backgroundColor:
                                                  Colors.transparent,
                                              context: context,
                                              builder: (BuildContext context) {
                                                return details(
                                                  userId: dcontroller.products
                                                      .value.user!.userId
                                                      .toString(),
                                                  userName: dcontroller.products
                                                      .value.user!.userName,
                                                  userLocationDescription:
                                                      dcontroller
                                                          .products
                                                          .value
                                                          .user!
                                                          .userDescription,
                                                  groceryName: dcontroller
                                                      .products
                                                      .value
                                                      .user!
                                                      .groceryName,
                                                  groceryDescription:
                                                      dcontroller
                                                          .products
                                                          .value
                                                          .user!
                                                          .groceryDescription,
                                                  distance: dcontroller.products
                                                      .value.user!.distance,
                                                  phoneNumber: dcontroller
                                                      .products
                                                      .value
                                                      .user!
                                                      .phoneNumber,
                                                  price: dcontroller
                                                      .products
                                                      .value
                                                      .details![index]
                                                      .price
                                                      .toString(),
                                                  lastPriceChange: dcontroller
                                                      .products
                                                      .value
                                                      .details![index]
                                                      .lastPriceChange,
                                                );
                                              },
                                            );
                                          },
                                          name: dcontroller.products.value
                                              .details![index].name,
                                          price: dcontroller.products.value
                                              .details![index].price,
                                          deta: dcontroller.products.value
                                              .details![index].lastPriceChange,
                                          id: dcontroller.products.value
                                              .details![index].id),
                                    ))
                            ],
                          ),
                        )
                      ],
                    ),
                  )));
        }),
      ),
    );
  }
}

class Searchdistrubutor extends SearchDelegate {
  final id;
  Searchdistrubutor({required this.id});

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: () => close(context, null),
            icon: const Icon(Icons.arrow_forward))
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () {
        if (query.isEmpty) {
          close(context, null);
        } else {
          query = '';
        }
      },
      icon: const Icon(Icons.clear));

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }
    return Center(
      child: GetBuilder<SearchProducts>(
          init: SearchProducts(id, query),
          builder: (dcontroller) {
            return auth(() async {
              dcontroller.searchDistrubuotor(id, query, 1);
            },
                context,
                dcontroller.error.value,
                dcontroller.isLoading.value,
                RefreshIndicator(
                    onRefresh: () async {
                      dcontroller.searchDistrubuotor(id, query, 1);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: ListView(
                        children: [
                          Center(
                            child: Wrap(
                              children: [
                                for (int index = 0;
                                    index <
                                        ((dcontroller.products.value.details) ??
                                                [])
                                            .length;
                                    index++)
                                  ElasticIn(
                                    duration:
                                        const Duration(milliseconds: 400 * 2),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: ProductsCart(
                                          ontop: () {
                                            showModalBottomSheet<void>(
                                              isScrollControlled: true,
                                              elevation: 7,
                                              enableDrag: true,
                                              backgroundColor:
                                                  Colors.transparent,
                                              context: context,
                                              builder: (BuildContext context) {
                                                return details(
                                                  userId: dcontroller.products
                                                      .value.user!.userId
                                                      .toString(),
                                                  userName: dcontroller.products
                                                      .value.user!.userName,
                                                  userLocationDescription:
                                                      dcontroller
                                                          .products
                                                          .value
                                                          .user!
                                                          .userDescription,
                                                  groceryName: dcontroller
                                                      .products
                                                      .value
                                                      .user!
                                                      .groceryName,
                                                  groceryDescription:
                                                      dcontroller
                                                          .products
                                                          .value
                                                          .user!
                                                          .groceryDescription,
                                                  distance: dcontroller.products
                                                      .value.user!.distance,
                                                  phoneNumber: dcontroller
                                                      .products
                                                      .value
                                                      .user!
                                                      .phoneNumber,
                                                  price: dcontroller
                                                      .products
                                                      .value
                                                      .details![index]
                                                      .price
                                                      .toString(),
                                                  lastPriceChange: dcontroller
                                                      .products
                                                      .value
                                                      .details![index]
                                                      .lastPriceChange,
                                                );
                                              },
                                            );
                                          },
                                          name: dcontroller.products.value
                                              .details![index].name,
                                          price: dcontroller.products.value
                                              .details![index].price,
                                          deta: dcontroller.products.value
                                              .details![index].lastPriceChange,
                                          id: dcontroller.products.value
                                              .details![index].id),
                                    ),
                                  )
                              ],
                            ),
                          )
                        ],
                      ),
                    )));
          }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) => Container();
}
