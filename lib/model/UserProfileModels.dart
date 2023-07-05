class UserProfileModels {
  bool? active;
  String? groceryDescription;
  String? groceryName;
  String? joinDate;
  String? location;
  String? locationDescription;
  int? menuCount;
  String? phoneNumber;
  String? userDescription;
  int? userId;
  String? userName;

  UserProfileModels(
      {this.active,
      this.groceryDescription,
      this.groceryName,
      this.joinDate,
      this.location,
      this.locationDescription,
      this.menuCount,
      this.phoneNumber,
      this.userDescription,
      this.userId,
      this.userName});

  UserProfileModels.fromJson(Map<String, dynamic> json) {
    active = json['active'] ?? false;
    groceryDescription = json['grocery description'] ?? 'لايوجد';
    groceryName = json['grocery name'];
    joinDate = json['join date'];
    location = json['location'];
    locationDescription = json['location_description'] ?? 'لايوجد';
    menuCount = json['menu_count'];
    phoneNumber = json['phone number'];
    userDescription = json['user description'] ?? 'لايوجد';
    userId = json['user id'];
    userName = json['user name'];
  }
}
