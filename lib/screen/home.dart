import 'package:dukanuser/controller/SelectedController.dart';
import 'package:dukanuser/screen/FavoriteScreen.dart';
import 'package:dukanuser/screen/SearchScreen.dart';
import 'package:dukanuser/screen/bottomNavigationBar.dart';
import 'package:dukanuser/screen/distrubutorScreen.dart';
import 'package:dukanuser/screen/ptofile.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final SelectedController selectedController = Get.put(SelectedController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Obx(() {
        return Scaffold(
          body: selectedController.selected.value == 0
              ? const SearchScreen()
              : selectedController.selected.value == 1
                  ? const distrubutorScreen()
                  : selectedController.selected.value == 2
                      ? const FavoriteScreen()
                      : const Profile(),
          bottomNavigationBar: bottomNavigationBar(
            ontop: (index) {
              selectedController.onselected(index);
            },
            selected: selectedController.selected.value,
          ),
        );
      }),
    );
  }
}
