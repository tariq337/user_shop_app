class Distrubutor {
  List<Details>? details;

  Distrubutor({this.details});

  Distrubutor.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(Details.fromJson(v));
      });
    }
  }
}

class Details {
  String? distance;
  String? groceryName;
  int? userId;
  String? userName;

  Details({this.distance, this.groceryName, this.userId, this.userName});

  Details.fromJson(Map<String, dynamic> json) {
    distance = json['distance'] ?? 'لايوجد';
    groceryName = json['grocery name'] ?? 'لايوجد';
    userId = json['user id'];
    userName = json['user name'] ?? 'لايوجد';
  }
}
