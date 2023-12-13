class UserInformation {
  String email;
  String nickname;
  String phoneNo;
  String profileImage;
  bool newsNotification;
  String? pushToken;
  String role;
  String? googleId;
  String? password;
  String? kakaoId;
  String? naverId;
  String? appleId;
  String? refreshToken;

  UserInformation(
    this.email,
    this.nickname,
    this.phoneNo,
    this.profileImage,
    this.newsNotification,
    this.pushToken,
    this.role,
    this.googleId,
    this.password,
    this.kakaoId,
    this.naverId,
    this.appleId,
    this.refreshToken,
  );

  factory UserInformation.fromJson(Map<String, dynamic> json) {
    List<String> tempList = [json['join_user_list']];

    return UserInformation(
        json['email'].toString(),
        json['nickname'].toString(),
        json['phoneNo'].toString(),
        json['profileImage'].toString(),
        bool.parse(json['newsNotification'].toString()),
        json['pushToken']?.toString(),
        json['role'].toString(),
        json['googleId']?.toString(),
        json['password'].toString(),
        json['kakaoId']?.toString(),
        json['naverId']?.toString(),
        json['appleId']?.toString(),
        json['refreshToken']?.toString());
  }

  Map<String, dynamic> toJson() => {
        'email': email.toString(),
        'nickname': nickname.toString(),
        'phoneNo': phoneNo.toString(),
        'profileImage': profileImage.toString(),
        'newsNotification': newsNotification,
        'pushToken': pushToken.toString(),
        'role': role.toString(),
        'googleId': googleId.toString(),
        'password': password.toString(),
        'kakaoId': kakaoId.toString(),
        'naverId': naverId.toString(),
        'appleId': appleId.toString(),
        'refreshToken': kakaoId.toString(),
      };
}
