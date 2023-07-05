class ProductsModel {
  List<Details>? details;
  User? user;

  ProductsModel({this.details, this.user});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(Details.fromJson(v));
      });
    }
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
}

class Details {
  String? changeList;
  int? id;
  String? lastPriceChange;
  String? name;
  int? price;

  Details(
      {this.changeList, this.id, this.lastPriceChange, this.name, this.price});

  Details.fromJson(Map<String, dynamic> json) {
    changeList = json['change list'];
    id = json['id'];
    lastPriceChange = json['last price change'] ?? 'لايوجد';
    name = json['name'];
    price = json['price'];
  }
}

class User {
  bool? active;
  String? distance;
  String? groceryDescription;
  String? groceryName;
  String? joinDate;
  String? location;
  String? locationDescription;
  String? phoneNumber;
  String? userDescription;
  int? userId;
  String? userName;

  User(
      {this.active,
      this.distance,
      this.groceryDescription,
      this.groceryName,
      this.joinDate,
      this.location,
      this.locationDescription,
      this.phoneNumber,
      this.userDescription,
      this.userId,
      this.userName});

  User.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    distance = json['distance'] ?? 'لايوجد';
    groceryDescription = json['grocery description'] ?? 'لايوجد';
    groceryName = json['grocery name'] ?? 'لايوجد';
    joinDate = json['join date'];
    location = json['location'];
    locationDescription = json['location_description'] ?? 'لايوجد';
    phoneNumber = json['phone number'] ?? '00000000000';
    userDescription = json['user description'] ?? 'لايوجد';
    userId = json['user id'];
    userName = json['user name'] ?? 'لايوجد';
  }
}
