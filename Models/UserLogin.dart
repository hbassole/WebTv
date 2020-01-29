class UserLogin{

  final bool success;
  final UserInfo user;

  UserLogin({this.user, this.success});

  factory UserLogin.fromJson(Map<String, dynamic>json){
    return UserLogin(
      success: json["success"] ?? null,
      user : UserInfo.fromJson(json["user"]),
    );
  }
}

class UserInfo{

  final int id;
  final String contact;
  final String avatar;
  final String username;
  final String email;
  final String ville;
  final String adresse;


  UserInfo({this.username, this.email, this.ville, this.adresse, this.contact, this.avatar, this.id});

  factory UserInfo.fromJson(Map<String, dynamic>json){
    return UserInfo(
      id: json["id"],
      contact: json["contact"],
      avatar: json["avatar"],
      username: json["user__first_name"],
      email: json["user__email"],
      ville: json["ville"],
      adresse: json["adresse"],
    );
  }


}

