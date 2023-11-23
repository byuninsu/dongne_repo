import 'dart:convert';
import 'dart:typed_data';

class Room {
  String title;
  String category;
  int max;
  int AreaId;
  String orderLink;
  String restaurantName;
  String dueDate;
  String latitude;
  String longitude;

  Room(
      this.title,
      this.category,
      this.max,
      this.AreaId,
      this.orderLink,
      this.restaurantName,
      this.dueDate,
      this.latitude,
      this.longitude,
      );


  factory Room.fromJson(Map<String, dynamic> json) {

    return Room(
      json['title'].toString(),
      json['category'].toString(),
      int.parse(json['max'].toString()),
      int.parse(json['AreaId'].toString()),
      json['orderLink'].toString(),
      json['restaurantName'].toString(),
      json['dueDate'].toString(),
      json['latitude'].toString(),
      json['longitude'].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title.toString(),
    'category': category.toString(),
    'max': max.toString(),
    'AreaId': AreaId.toString(),
    'orderLink': orderLink.toString(),
    'restaurantName': restaurantName.toString(),
    'dueDate': dueDate.toString(),
    'latitude': latitude.toString(),
    'longitude': longitude.toString(),

  };

}
