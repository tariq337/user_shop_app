class SearchModel {
  Details? details;

  SearchModel({this.details});

  SearchModel.fromJson(Map<String, dynamic> json) {
    details =
        json['details'] != null ? Details.fromJson(json['details']) : null;
  }
}

class Details {
  List<Products>? products;
  List<Users>? users;

  Details({this.products, this.users});

  Details.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(Users.fromJson(v));
      });
    }
  }
}

class Products {
  String? changeList;
  String? distance;
  String? groceryDescription;
  String? groceryName;
  int? id;
  String? lastPriceChange;
  String? name;
  String? phoneNumber;
  int? price;
  int? userId;
  String? userLocation;
  String? userLocationDescription;
  String? userName;

  Products(
      {this.changeList,
      this.distance,
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

  Products.fromJson(Map<String, dynamic> json) {
    changeList = json['change list'];
    distance = json['distance'];
    groceryDescription = json['grocery description'];
    groceryName = json['grocery name'];
    id = json['id'];
    lastPriceChange = json['last price change'];
    name = json['name'];
    phoneNumber = json['phone number'];
    price = json['price'];
    userId = json['user id'];
    userLocation = json['user location'];
    userLocationDescription = json['user location description'];
    userName = json['user name'];
  }
}

class Users {
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

  Users(
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

  Users.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    distance = json['distance'];
    groceryDescription = json['grocery description'];
    groceryName = json['grocery name'];
    joinDate = json['join date'];
    location = json['location'];
    locationDescription = json['location_description'];
    phoneNumber = json['phone number'];
    userDescription = json['user description'];
    userId = json['user id'];
    userName = json['user name'];
  }
}
