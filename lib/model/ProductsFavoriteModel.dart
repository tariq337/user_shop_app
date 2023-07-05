class ProductsFavoriteModel {
  List<Details>? details;

  ProductsFavoriteModel({this.details});

  ProductsFavoriteModel.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(Details.fromJson(v));
      });
    }
  }
}

class Details {
  String? changeList;
  String? groceryDescription;
  String? groceryName;
  int? id;
  String? distance;
  String? lastPriceChange;
  String? name;
  String? phoneNumber;
  int? price;
  int? userId;
  String? userLocation;
  String? userLocationDescription;
  String? userName;

  Details(
      {this.distance,
      this.changeList,
      this.groceryDescription,
      this.groceryName,
      this.id,
      this.lastPriceChange,
      this.name,
      this.phoneNumber,
      this.price,
      this.userId,
      this.userLocation,
      this.userLocationDescription,
      this.userName});

  Details.fromJson(Map<String, dynamic> json) {
    distance = json['distance'] ?? 'لايوجد';

    changeList = json['change list'] ?? 'لايوجد';
    groceryDescription = json['grocery description'] ?? 'لايوجد';
    groceryName = json['grocery name'] ?? 'لايوجد';
    id = json['id'];
    lastPriceChange = json['last price change'] ?? 'لايوجد';
    name = json['name'];
    phoneNumber = json['phone number'] ?? '00000000000';
    price = json['price'];
    userId = json['user id'];
    userLocation = json['user location'] ?? 'لايوجد';
    userLocationDescription = json['user location description'] ?? 'لايوجد';
    userName = json['user name'] ?? 'لايوجد';
  }
}
