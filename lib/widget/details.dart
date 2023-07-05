import 'dart:developer';
import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';
import 'package:dukanuser/constant.dart';
import 'package:dukanuser/model/searchModel.dart';
import 'package:dukanuser/token/user_service.dart';
import 'package:dukanuser/widget/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:url_launcher/url_launcher.dart';

class details extends StatefulWidget {
  final bool isgetDetails = true;
  final String? distance;
  final String? lastPriceChange;
  final String? phoneNumber;
  final String? price;
  final String? userLocationDescription;
  final String? userName;
  final String? groceryDescription;
  final String? groceryName;
  final String? userId;

  const details({
    Key? key,
    required this.distance,
    required this.lastPriceChange,
    required this.phoneNumber,
    required this.price,
    required this.userLocationDescription,
    required this.userName,
    required this.groceryDescription,
    required this.groceryName,
    required this.userId,
  }) : super(key: key);

  @override
  State<details> createState() => _detailsState();
}

class _detailsState extends State<details> {
  Size get size => MediaQuery.of(context).size;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: .5,
        builder: (_, controll) {
          return Container(
            width: size.width,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50))),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: ListView(
                  controller: controll,
                  children: <Widget>[
                    Align(
                      child: Container(
                        width: 150,
                        height: 7,
                        decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(90),
                          child: Image(
                              height: 135,
                              width: 140,
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                '$startUrl/users/${widget.userId}/user_image',
                              ),
                              errorBuilder: (context, exception, stackTrack) =>
                                  const Icon(
                                    Icons.image_not_supported_outlined,
                                    size: 90,
                                  )),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "${widget.userName}",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "${widget.groceryName}",
                              style: const TextStyle(fontSize: 13),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(3)),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text("SD ${widget.price}"),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(3)),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text("${widget.distance}"),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(3)),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text("اخر تعديل ${widget.lastPriceChange}"),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "وصف المحل",
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${widget.groceryDescription}',
                      style: const TextStyle(height: 1.6),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "وصف الموقع",
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${widget.userLocationDescription}',
                      style: const TextStyle(height: 1.6),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "صورة المحل",
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image(
                            height: size.width * .6,
                            width: size.width * .6,
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              '$startUrl/users/${widget.userId}/grocery_image',
                            ),
                            errorBuilder: (context, exception, stackTrack) =>
                                const Icon(
                                  Icons.image_not_supported_outlined,
                                  size: 90,
                                )),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElasticIn(
                      duration: const Duration(milliseconds: 400 * 4),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: FlatButton(
                          onPressed: () async {
                            final Uri uri =
                                Uri.parse('tel:${widget.phoneNumber}');

                            if (!await launchUrl(uri)) {
                              mess(context, 'اعد المحاولة', Colors.red);
                            }
                          },
                          color: login_bg,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(24),
                            ),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(
                                Icons.phone,
                                color: Colors.white,
                              ),
                              SizedBox(width: 12),
                              Text(
                                "عرض رقم الهاتف",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
