import 'dart:convert';
import 'dart:typed_data';

class Room {
  int room_number;
  int room_password;
  String room_name;
  List<String> join_user_list;
  String first_option;
  String second_option;
  double vote_rate;
  int first_option_vote;
  int second_option_vote;
  String first_option_description;
  String second_option_description;
  Uint8List first_option_image;
  Uint8List second_option_image;

  Room(
      this.room_number,
      this.room_password,
      this.room_name,
      this.join_user_list,
      this.first_option,
      this.second_option,
      this.vote_rate,
      this.first_option_vote,
      this.second_option_vote,
      this.first_option_description,
      this.second_option_description,
      this.first_option_image,
      this.second_option_image
      );


  factory Room.fromJson(Map<String, dynamic> json) {
    List<String> tempList = [json['join_user_list']];

    return Room(
      //user id는 int형임으로 parse가 필요함
      int.parse(json['room_number'].toString()),
      int.parse(json['room_password'].toString()),
      json['room_name'].toString(),
      tempList,
      json['first_option'].toString(),
      json['second_option'].toString(),
      double.parse(json['vote_rate'].toString()),
      int.parse(json['first_option_vote'].toString()),
      int.parse(json['second_option_vote'].toString()),
      json['first_option_description'].toString(),
      json['second_option_description'].toString(),
      base64Decode(json['first_option_image']),
      base64Decode(json['second_option_image']),
    );
  }

  Map<String, dynamic> toJson() => {
    'room_number': room_number.toString(),
    'room_password': room_password.toString(),
    'room_name': room_name.toString(),
    'join_user_list': join_user_list.join(','),
    'first_option': first_option.toString(),
    'second_option': second_option.toString(),
    'vote_rate': vote_rate.toString(),
    'first_option_vote': first_option_vote.toString(),
    'second_option_vote': second_option_vote.toString(),
    'first_option_description': first_option_description.toString(),
    'second_option_description': second_option_description.toString(),
    'first_option_image': base64Encode(first_option_image.toList()),
    'second_option_image': base64Encode(second_option_image.toList())
  };

}
