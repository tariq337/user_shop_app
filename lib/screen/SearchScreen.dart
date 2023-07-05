import 'package:dukanuser/controller/SearchController.dart';
import 'package:dukanuser/model/searchModel.dart';
import 'package:dukanuser/screen/ProductsScreen.dart';
import 'package:dukanuser/widget/DistrubutorCard.dart';
import 'package:dukanuser/widget/auth.dart';
import 'package:dukanuser/widget/details.dart';
import 'package:dukanuser/widget/productsCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchController searchController = Get.put(SearchController());

  Size get size => MediaQuery.of(context).size;
  final TextEditingController _searchController = TextEditingController();
  bool isCategory = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   backgroundColor: const Color(0xFFfffff0),
      body: Center(child: Obx(() {
        return SafeArea(
          child: Container(
            margin: const EdgeInsets.only(top: 20, left: 5, right: 10),
            width: size.width,
            height: size.height,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "يمكنك البحث عن المنتجات اوالتجار",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 6.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextField(
                      onSubmitted: (v) async {
                        await searchController.searchData(
                            _searchController.text, 1);
                      },
                      controller: _searchController,
                      onChanged: (value) async {
                        if (value.trim().isNotEmpty) {
                          //  await searchController.searchData(value, 1);
                        }
                      },
                      decoration: InputDecoration(
                          hintText: "بحث",
                          hintStyle: const TextStyle(color: Color(0xff3c4046)),
                          border: InputBorder.none,
                          prefixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () async {
                              await searchController.searchData(
                                  _searchController.text, 1);
                            },
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: auth(
                        () async {},
                        context,
                        searchController.error.value,
                        searchController.isLoading.value,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'المنتجات',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            if ((((searchController.searchModel.value.details ??
                                            Details(products: [], users: []))
                                        .products) ??
                                    [])
                                .isEmpty)
                              const Text(
                                'لاتوجد عناصر',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              )
                            else
                              SizedBox(
                                height: 300,
                                width: size.width,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: (((searchController.searchModel
                                                        .value.details ??
                                                    Details(
                                                        products: [],
                                                        users: []))
                                                .products) ??
                                            [])
                                        .length,
                                    itemBuilder: (context, index) {
                                      return Row(
                                        children: [
                                          ProductsCart(
                                            ontop: () {
                                              showModalBottomSheet<void>(
                                                isScrollControlled: true,
                                                elevation: 7,
                                                enableDrag: true,
                                                backgroundColor:
                                                    Colors.transparent,
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return details(
                                                    userId: searchController
                                                        .searchModel
                                                        .value
                                                        .details!
                                                        .products![index]
                                                        .userId
                                                        .toString(),
                                                    distance: searchController
                                                        .searchModel
                                                        .value
                                                        .details!
                                                        .products![index]
                                                        .distance,
                                                    groceryDescription:
                                                        searchController
                                                            .searchModel
                                                            .value
                                                            .details!
                                                            .products![index]
                                                            .groceryDescription,
                                                    groceryName:
                                                        searchController
                                                            .searchModel
                                                            .value
                                                            .details!
                                                            .products![index]
                                                            .groceryName,
                                                    lastPriceChange:
                                                        searchController
                                                            .searchModel
                                                            .value
                                                            .details!
                                                            .products![index]
                                                            .lastPriceChange,
                                                    userLocationDescription:
                                                        searchController
                                                            .searchModel
                                                            .value
                                                            .details!
                                                            .products![index]
                                                            .userLocationDescription,
                                                    userName: searchController
                                                        .searchModel
                                                        .value
                                                        .details!
                                                        .products![index]
                                                        .userName,
                                                    phoneNumber:
                                                        searchController
                                                            .searchModel
                                                            .value
                                                            .details!
                                                            .products![index]
                                                            .phoneNumber,
                                                    price: searchController
                                                        .searchModel
                                                        .value
                                                        .details!
                                                        .products![index]
                                                        .price
                                                        .toString(),
                                                  );
                                                },
                                              );
                                              /*
                                             )*/
                                            },
                                            groceryName: searchController
                                                .searchModel
                                                .value
                                                .details!
                                                .products![index]
                                                .groceryName,
                                            name: searchController
                                                .searchModel
                                                .value
                                                .details!
                                                .products![index]
                                                .name,
                                            price: searchController
                                                .searchModel
                                                .value
                                                .details!
                                                .products![index]
                                                .price,
                                            deta: searchController
                                                .searchModel
                                                .value
                                                .details!
                                                .products![index]
                                                .lastPriceChange,
                                            id: searchController
                                                .searchModel
                                                .value
                                                .details!
                                                .products![index]
                                                .id,
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                        ],
                                      );
                                    }),
                              ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'التجار',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            (((searchController.searchModel.value.details ??
                                                Details(
                                                    products: [], users: []))
                                            .users ??
                                        [])
                                    .isEmpty
                                ? const Text(
                                    'لاتوجد عناصر',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold),
                                  )
                                : SizedBox(
                                    height: 300,
                                    width: size.width,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: (((searchController
                                                            .searchModel
                                                            .value
                                                            .details ??
                                                        Details(
                                                            products: [],
                                                            users: []))
                                                    .users) ??
                                                [])
                                            .length,
                                        itemBuilder: (context, index) {
                                          return Row(
                                            children: [
                                              DistrubutorCard(
                                                ontop: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ProductsScreen(
                                                                  id: searchController
                                                                      .searchModel
                                                                      .value
                                                                      .details!
                                                                      .users![
                                                                          index]
                                                                      .userId)));
                                                },
                                                name: searchController
                                                    .searchModel
                                                    .value
                                                    .details!
                                                    .users![index]
                                                    .userName,
                                                groceryName: searchController
                                                    .searchModel
                                                    .value
                                                    .details!
                                                    .users![index]
                                                    .groceryName,
                                                distance: searchController
                                                    .searchModel
                                                    .value
                                                    .details!
                                                    .users![index]
                                                    .distance,
                                                id: searchController
                                                    .searchModel
                                                    .value
                                                    .details!
                                                    .users![index]
                                                    .userId,
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                            ],
                                          );
                                        }),
                                  ))
                          ],
                        )),
                  )
                ],
              ),
            ),
          ),
        );
      })),
    );
  }
}
