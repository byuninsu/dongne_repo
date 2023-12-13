import 'dart:convert';
import 'dart:typed_data';

class Room {
  int id;
  String title;
  String orderLink;
  String longitude;
  String latitude;
  String restaurantName;
  String category;
  int max;
  int deliveryFee;
  String dueDate;
  int StatusId;
  int AreaId;

  Room(
      this.id,
      this.title,
      this.orderLink,
      this.longitude,
      this.latitude,
      this.restaurantName,
      this.category,
      this.max,
      this.deliveryFee,
      this.dueDate,
      this.StatusId,
      this.AreaId,
      );

  // 기본값을 설정한 기본 Room 생성자
  factory Room.defaultRoom() {
    return Room(
      0,
      "Default Title",
      "Default Order Link",
      "Default Longitude",
      "Default Latitude",
      "Default Restaurant Name",
      "Default Category",
      0,
      0,
      "Default Due Date",
      0,
      0,
    );
  }




  factory Room.fromJson(Map<String, dynamic> json) {

    return Room(
      json['id'],
      json['title'].toString(),
      json['orderLink'].toString(),
      json['longitude'].toString(),
      json['latitude'].toString(),
      json['restaurantName'].toString(),
      json['category'].toString(),
      int.parse(json['max'].toString()),
      int.parse(json['deliveryFee'].toString()),
      json['dueDate'].toString(),
      int.parse(json['StatusId'].toString()),
      int.parse(json['AreaId'].toString()),
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title.toString(),
    'orderLink': orderLink.toString(),
    'longitude': longitude.toString(),
    'latitude': latitude.toString(),
    'restaurantName': restaurantName.toString(),
    'category': category.toString(),
    'max': max,
    'deliveryFee': deliveryFee,
    'dueDate': dueDate.toString(),
    'StatusId': StatusId,
    'AreaId': AreaId,
  };

}
