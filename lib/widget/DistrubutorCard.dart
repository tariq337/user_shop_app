import 'package:dukanuser/constant.dart';
import 'package:dukanuser/screen/ProductsScreen.dart';
import 'package:flutter/material.dart';

class DistrubutorCard extends StatelessWidget {
  final name;
  final distance;
  final id;
  final groceryName;
  final ontop;

  const DistrubutorCard(
      {Key? key,
      required this.name,
      required this.distance,
      required this.id,
      this.groceryName,
      this.ontop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontop,
      //  Navigator.push(context, MaterialPageRoute(builder: (context) => CoffeeDetailsPage()));

      child: Container(
        height: 150,
        child: Row(
          children: [
            const SizedBox(
              height: 10,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                  height: 135,
                  width: 140,
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    '$startUrl/users/$id/user_image',
                  ),
                  errorBuilder: (context, exception, stackTrack) => const Icon(
                        Icons.image_not_supported_outlined,
                        size: 90,
                      )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    name.toString().length > 24
                        ? name.toString().substring(0, 20) + '..'
                        : "$name",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    groceryName.toString().length > 24
                        ? groceryName.toString().substring(0, 20) + '..'
                        : "$groceryName",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    '$distance',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
