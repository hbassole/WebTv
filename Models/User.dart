class User {
  final int id;
  final String username;
  final String email;
  List<UserVideo> userVideo;
  Profile profile ;
  List<Directvideo> directvideo;
  List<Vue> vues;

  User({this.id, this.username, this.email, this.profile, this.userVideo, this.directvideo, this.vues});

  factory User.fromJson(Map<String, dynamic>json){

    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      userVideo: List<UserVideo>.from(json["user_video"].map((x) => UserVideo.fromJson(x))),
      profile: Profile.fromJson(json['profile']),
      directvideo: List<Directvideo>.from(json["directvideo"].map((x) => Directvideo.fromJson(x))),
      vues: List<Vue>.from(json["vues"].map((x) => Vue.fromJson(x))),
    );
  }

}


class Profile {

  final String contact;
  final String avatar;

  Profile({this.contact, this.avatar});

  factory Profile.fromJson(Map<String, dynamic>json){

    return Profile(
      contact : json['contact'],
      avatar: json['avatar']
    );
  }

}

class UserVideo {
  int id;
  List<Vue> vues;
  String imageUrl;
  String videoUrl;
  UserVideo({
    this.id,
    this.vues,
    this.imageUrl,
    this.videoUrl,
  });

  factory UserVideo.fromJson(Map<String, dynamic> json) => UserVideo(
    id: json["id"],
    vues: List<Vue>.from(json["vues"].map((x) => Vue.fromJson(x))),
    imageUrl: json["image_url"] == null ?  json["image_preview"]  : json["image_url"],
    videoUrl: json["video_url"] == null ? null : json["video_url"],

  );
}


class Vue {
  int id;
  Vue({
    this.id,
  });

  factory Vue.fromJson(Map<String, dynamic> json) => Vue(
    id: json["id"],
  );

}


class Directvideo {
  int id;
  String image_url;
  String video_url;
  Directvideo({
    this.id,
    this.image_url,
    this.video_url,
  });

  factory Directvideo.fromJson(Map<String, dynamic> json) => Directvideo(
    id: json["id"],
    image_url: json["image_url"] == null ?  null : json["image_url"],
    video_url: json["video_url"] == null ?  null : json["video_url"],
  );

}




