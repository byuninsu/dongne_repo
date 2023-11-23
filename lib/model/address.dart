import 'dart:convert';
import 'dart:typed_data';

class Address {
  String apartmentName;
  String address;
  String city;
  String state;


  Address(
      this.apartmentName,
      this.address,
      this.city,
      this.state,
      );


  factory Address.fromJson(Map<String, dynamic> json) {

    return Address(
      json['apartmentName'].toString(),
      json['address'].toString(),
      json['city'].toString(),
      json['state'].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'apartmentName': apartmentName.toString(),
    'address': address.toString(),
    'city': city.toString(),
    'state': state.toString(),
  };

}
