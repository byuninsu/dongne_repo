class User {
  String email;
  String nickname;
  String phoneNo;
  String profileImage;
  bool newsNotification;
  String? pushToken;
  String role;
  String? idToken;
  String? password;
  String? kakaoId;
  String? naverId;
  String? appleId;
  String? refreshToken;

  User(
    this.email,
    this.nickname,
    this.phoneNo,
    this.profileImage,
    this.newsNotification,
    this.pushToken,
    this.role,
    this.idToken,
    this.password,
    this.kakaoId,
    this.naverId,
    this.appleId,
    this.refreshToken,
  );

  factory User.fromJson(Map<String, dynamic> json) {
    List<String> tempList = [json['join_user_list']];

    return User(
        json['email'].toString(),
        json['nickname'].toString(),
        json['phoneNo'].toString(),
        json['profileImage'].toString(),
        bool.parse(json['newsNotification'].toString()),
        json['pushToken'].toString(),
        json['role'].toString(),
        json['idToken'].toString(),
        json['password'].toString(),
        json['kakaoId'].toString(),
        json['naverId'].toString(),
        json['appleId'].toString(),
        json['refreshToken'].toString());
  }

  Map<String, dynamic> toJson() => {
        'email': email.toString(),
        'nickname': nickname.toString(),
        'phoneNo': phoneNo.toString(),
        'profileImage': profileImage.toString(),
        'newsNotification': newsNotification.toString(),
        'pushToken': pushToken.toString(),
        'role': role.toString(),
        'idToken': idToken.toString(),
        'password': password.toString(),
        'kakaoId': kakaoId.toString(),
        'naverId': kakaoId.toString(),
        'appleId': kakaoId.toString(),
        'refreshToken': kakaoId.toString(),
      };
}
