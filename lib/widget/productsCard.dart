import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dukanuser/constant.dart';
import 'package:dukanuser/token/user_service.dart';
import 'package:flutter/material.dart';

class ProductsCart extends StatefulWidget {
  final name;
  final price;
  final deta;
  final id;
  final String? groceryName;
  final ontop;
  const ProductsCart(
      {Key? key,
      this.groceryName,
      required this.name,
      required this.price,
      required this.deta,
      required this.id,
      required this.ontop})
      : super(key: key);

  @override
  State<ProductsCart> createState() => _ProductsCartState();
}

class _ProductsCartState extends State<ProductsCart> {
  bool ischeck = true;
  bool isFavorite = false;
  Dio dio = Dio();
  @override
  void initState() {
    checkFavorite(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .45 > 200
          ? 200
          : MediaQuery.of(context).size.width * .45,
      height: 250,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                  height: 135,
                  width: MediaQuery.of(context).size.width * .45 > 200
                      ? 200
                      : MediaQuery.of(context).size.width * .45,
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    '$passdataUrl/${widget.id}/product_image',
                  ),
                  errorBuilder: (context, exception, stackTrack) => const Icon(
                        Icons.image_not_supported_outlined,
                        size: 90,
                      )),
            ),
          ),
          Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 8),
                child: GestureDetector(
                  onTap: () async {
                    setState(() {
                      ischeck = true;
                    });
                    if (isFavorite) {
                      deleteFavorite(widget.id);
                    } else {
                      addItemFavorite(widget.id);
                    }
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: login_bg,
                        borderRadius: BorderRadius.circular(10)),
                    child: ischeck
                        ? const Icon(
                            Icons.update,
                            size: 20,
                          )
                        : isFavorite
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 20,
                              )
                            : const Icon(
                                Icons.favorite_border,
                                size: 20,
                              ),
                  ),
                ),
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: widget.ontop,
              child: Container(
                height: 130,
                width: MediaQuery.of(context).size.width * .4 > 150
                    ? 150
                    : MediaQuery.of(context).size.width * .4,
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 7,
                        offset: Offset(2, 5),
                        color: Colors.black12,
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                  child: Column(
                    children: [
                      Text(
                        widget.name.toString().length > 24
                            ? widget.name.toString().substring(0, 20) + '..'
                            : "${widget.name}",
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        (widget.groceryName ?? '').toString().length > 24
                            ? (widget.groceryName ?? '')
                                    .toString()
                                    .substring(0, 20) +
                                '..'
                            : (widget.groceryName ?? ''),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        'اخر تحديث ${widget.deta}',
                        style: const TextStyle(
                            color: Color(0xff919293), fontSize: 11),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'SD ',
                                style: TextStyle(
                                    color: login_bg,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              Text(
                                "${widget.price}",
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void checkFavorite(id) async {
    try {
      String apiKey = await getToken();
      dio.options.headers['apiKey'] = apiKey.toString();
      await dio
          .get(
        addFavoriteUrl + 'in/$id',
      )
          .then((value) {
        if (value.statusCode == 200) {
          setState(() {
            isFavorite = value.data['check'];
            ischeck = false;
          });
        } else {
          setState(() {
            isFavorite = false;
            ischeck = false;
          });
        }
        log(value.statusCode.toString());
      });
    } catch (e) {
      setState(() {
        isFavorite = false;
        ischeck = false;
      });
    }
  }

  void deleteFavorite(id) async {
    try {
      String apiKey = await getToken();
      dio.options.headers['apiKey'] = apiKey.toString();
      var response = await dio
          .delete(
        addFavoriteUrl + '$id',
      )
          .then((value) {
        if (value.statusCode == 200) {
          setState(() {
            isFavorite = false;
            ischeck = false;
          });
        } else {
          setState(() {
            isFavorite = true;
            ischeck = false;
          });
        }
      });
    } catch (e) {
      setState(() {
        isFavorite = true;
        ischeck = false;
      });
    }
  }

  void addItemFavorite(id) async {
    try {
      String apiKey = await getToken();
      dio.options.headers['apiKey'] = apiKey.toString();
      var response = await dio
          .put(
        addFavoriteUrl + '$id',
      )
          .then((value) {
        if (value.statusCode == 200) {
          setState(() {
            isFavorite = true;
            ischeck = false;
          });
        } else {
          setState(() {
            isFavorite = false;
            ischeck = false;
          });
        }
      });
    } catch (e) {
      setState(() {
        isFavorite = false;
        ischeck = false;
      });
    }
  }
}
