import 'dart:developer';

import 'package:dukanuser/constant.dart';
import 'package:dukanuser/controller/distrubuotorController.dart';
import 'package:dukanuser/controller/searchDistrubuotor.dart';
import 'package:dukanuser/screen/ProductsScreen.dart';
import 'package:dukanuser/widget/DistrubutorCard.dart';
import 'package:dukanuser/widget/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class distrubutorScreen extends StatefulWidget {
  const distrubutorScreen({Key? key}) : super(key: key);

  @override
  State<distrubutorScreen> createState() => _distrubutorScreenState();
}

class _distrubutorScreenState extends State<distrubutorScreen> {
  distrubuotorController dcontroller = Get.put(distrubuotorController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('التجار'),
        centerTitle: true,
        backgroundColor: login_bg,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: Searchdistrubutor());
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: Center(
        child: Obx(() {
          return auth(() async {
            dcontroller.getDistrubuotor(1);
          },
              context,
              dcontroller.error.value,
              dcontroller.isLoading.value,
              RefreshIndicator(
                onRefresh: () async {
                  dcontroller.getDistrubuotor(1);
                },
                child: ListView.builder(
                    itemCount:
                        ((dcontroller.distrubutor.value.details) ?? []).length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(12),
                        child: DistrubutorCard(
                          ontop: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductsScreen(
                                        id: dcontroller.distrubutor.value
                                            .details![index].userId)));
                          },
                          id: dcontroller
                              .distrubutor.value.details![index].userId,
                          name: dcontroller
                              .distrubutor.value.details![index].userName,
                          groceryName: dcontroller
                              .distrubutor.value.details![index].groceryName,
                          distance: dcontroller
                              .distrubutor.value.details![index].distance,
                        ),
                      );
                    }),
              ));
        }),
      ),
    );
  }
}

class Searchdistrubutor extends SearchDelegate {
  searchDistrubuotorController dcontroller =
      Get.put(searchDistrubuotorController());
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
    dcontroller.searchDistrubuotor(query, 1);
    if (query.isEmpty) {
      return Container();
    }
    return Center(
      child: Obx(() {
        return auth(() async {
          dcontroller.searchDistrubuotor(query, 1);
        },
            context,
            dcontroller.error.value,
            dcontroller.isLoading.value,
            RefreshIndicator(
              onRefresh: () async {
                dcontroller.searchDistrubuotor(query, 1);
              },
              child: ListView.builder(
                  itemCount:
                      ((dcontroller.distrubutor.value.details) ?? []).length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(12),
                      child: DistrubutorCard(
                        ontop: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductsScreen(
                                      id: dcontroller.distrubutor.value
                                          .details![index].userId)));
                        },
                        id: dcontroller
                            .distrubutor.value.details![index].userId,
                        name: dcontroller
                            .distrubutor.value.details![index].userName,
                        groceryName: dcontroller
                            .distrubutor.value.details![index].groceryName,
                        distance: dcontroller
                            .distrubutor.value.details![index].distance,
                      ),
                    );
                  }),
            ));
      }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) => Container();
}
